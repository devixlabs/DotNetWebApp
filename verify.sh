#!/usr/bin/env bash
set -e

echo "================================"
echo "DotNetWebApp CRUD Verification"
echo "================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${YELLOW}[→]${NC} $1"
}

# Function to cleanup on exit
cleanup() {
    if [ -n "$SERVER_PID" ]; then
        print_info "Stopping dev server (PID: $SERVER_PID)..."
        kill "$SERVER_PID" 2>/dev/null || true
        wait "$SERVER_PID" 2>/dev/null || true
    fi
    make stop-dev
}

trap cleanup EXIT

# Step 1: Check and build
print_info "Step 1: Running make check..."
make check
print_status "Build check passed"
echo ""

# Step 2: Run tests
print_info "Step 2: Running make test..."
make test
print_status "All tests passed"
echo ""

# Step 3: Drop database
print_info "Step 3: Dropping database(s)..."
make db-drop || print_info "Docker database drop attempted (may not exist)"
make ms-drop || print_info "MSSQL Server database drop attempted (may not exist)"
print_status "Database(s) dropped? ¯\_(ツ)_/¯"
echo ""

# Step 4: Run DDL pipeline
print_info "Step 4: Running DDL pipeline (make run-ddl-pipeline)..."
make run-ddl-pipeline
print_status "DDL pipeline completed"
echo ""

# Step 5: Apply migrations
print_info "Step 5: Applying migrations (make migrate)..."
make migrate
print_status "Migrations applied"
echo ""

# Step 6: Seed data
print_info "Step 6: Seeding data (make seed)..."
make seed
print_status "Data seeded"
echo ""

# Step 7: Start dev server
print_info "Step 7: Starting dev server (make dev)..."
make dev > /tmp/dotnet-dev.log 2>&1 &
SERVER_PID=$!
print_status "Dev server started (PID: $SERVER_PID)"

# Wait for server to be ready
print_info "Waiting for server to be ready..."
MAX_WAIT=30
WAIT_COUNT=0
while [ $WAIT_COUNT -lt $MAX_WAIT ]; do
    if curl -k -s https://localhost:7012/api/admin/entities/acme/Product > /dev/null 2>&1; then
        print_status "Server is ready!"
        break
    fi
    sleep 1
    WAIT_COUNT=$((WAIT_COUNT + 1))
    echo -n "."
done
echo ""

if [ $WAIT_COUNT -eq $MAX_WAIT ]; then
    print_error "Server failed to start within ${MAX_WAIT} seconds"
    exit 1
fi

echo ""
echo "================================"
echo "Testing CRUD Operations"
echo "================================"
echo ""

# Test 1: GET all products (admin app)
print_info "Test 1: GET all products (admin app)"
RESPONSE=$(curl -k -s https://localhost:7012/api/admin/entities/acme/Product)
COUNT=$(echo "$RESPONSE" | jq 'length')
print_status "Found $COUNT products"
echo "$RESPONSE" | jq '.[0:2]' # Show first 2 products
echo ""

# Test 2: GET product by ID (admin app)
print_info "Test 2: GET product by ID (admin app, id=1)"
RESPONSE=$(curl -k -s https://localhost:7012/api/admin/entities/acme/Product/1)
PRODUCT_NAME=$(echo "$RESPONSE" | jq -r '.name')
print_status "Retrieved product: $PRODUCT_NAME"
echo "$RESPONSE" | jq .
echo ""

# Test 3: GET count (admin app)
print_info "Test 3: GET product count (admin app)"
COUNT=$(curl -k -s https://localhost:7012/api/admin/entities/acme/Product/count)
print_status "Product count: $COUNT"
echo ""

# Test 4: POST - Create new product (admin app)
print_info "Test 4: POST - Create new product (admin app)"
RESPONSE=$(curl -k -s -X POST https://localhost:7012/api/admin/entities/acme/Product \
  -H "Content-Type: application/json" \
  -d '{
    "Name": "Verification Test Product",
    "Description": "Created by verify-crud.sh script",
    "Price": 123.45,
    "CategoryId": 1
  }')
NEW_ID=$(echo "$RESPONSE" | jq -r '.id')
print_status "Created product with ID: $NEW_ID"
echo "$RESPONSE" | jq .
echo ""

# Test 5: GET the newly created product (admin app)
print_info "Test 5: GET newly created product (admin app, id=$NEW_ID)"
RESPONSE=$(curl -k -s https://localhost:7012/api/admin/entities/acme/Product/"$NEW_ID")
PRODUCT_NAME=$(echo "$RESPONSE" | jq -r '.name')
print_status "Retrieved: $PRODUCT_NAME"
echo "$RESPONSE" | jq .
echo ""

# Test 6: PUT - Update the product (admin app)
print_info "Test 6: PUT - Update product (admin app, id=$NEW_ID)"
RESPONSE=$(curl -k -s -X PUT https://localhost:7012/api/admin/entities/acme/Product/"$NEW_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "Name": "UPDATED Test Product",
    "Description": "Updated by verify-crud.sh script",
    "Price": 999.99,
    "CategoryId": 2
  }')
UPDATED_NAME=$(echo "$RESPONSE" | jq -r '.name')
UPDATED_PRICE=$(echo "$RESPONSE" | jq -r '.price')
print_status "Updated: $UPDATED_NAME - Price: \$$UPDATED_PRICE"
echo "$RESPONSE" | jq .
echo ""

# Test 7: Verify update persisted (admin app)
print_info "Test 7: GET updated product to verify persistence (admin app, id=$NEW_ID)"
RESPONSE=$(curl -k -s https://localhost:7012/api/admin/entities/acme/Product/"$NEW_ID")
PRODUCT_NAME=$(echo "$RESPONSE" | jq -r '.name')
PRODUCT_PRICE=$(echo "$RESPONSE" | jq -r '.price')
if [ "$PRODUCT_NAME" = "UPDATED Test Product" ] && [ "$PRODUCT_PRICE" = "999.99" ]; then
    print_status "Update verified: $PRODUCT_NAME - \$$PRODUCT_PRICE"
else
    print_error "Update verification failed!"
    exit 1
fi
echo "$RESPONSE" | jq .
echo ""

# Test 8: DELETE the product (admin app)
print_info "Test 8: DELETE product (admin app, id=$NEW_ID)"
HTTP_CODE=$(curl -k -s -X DELETE https://localhost:7012/api/admin/entities/acme/Product/"$NEW_ID" \
  -w "%{http_code}" -o /dev/null)
if [ "$HTTP_CODE" = "204" ]; then
    print_status "Product deleted (HTTP 204 No Content)"
else
    print_error "Delete failed (HTTP $HTTP_CODE)"
    exit 1
fi
echo ""

# Test 9: Verify deletion (should return 404)
print_info "Test 9: GET deleted product (should return 404)"
HTTP_CODE=$(curl -k -s https://localhost:7012/api/admin/entities/acme/Product/"$NEW_ID" \
  -w "%{http_code}" -o /tmp/delete-check.json)
RESPONSE=$(cat /tmp/delete-check.json)
if [ "$HTTP_CODE" = "404" ]; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error')
    print_status "Deletion verified: $ERROR_MSG (HTTP 404)"
else
    print_error "Deletion verification failed (HTTP $HTTP_CODE)"
    exit 1
fi
echo ""

# Test 10: Error handling - Non-existent ID
print_info "Test 10: GET non-existent product (admin app, id=99999)"
HTTP_CODE=$(curl -k -s https://localhost:7012/api/admin/entities/acme/Product/99999 \
  -w "%{http_code}" -o /tmp/notfound-check.json)
RESPONSE=$(cat /tmp/notfound-check.json)
if [ "$HTTP_CODE" = "404" ]; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error')
    print_status "Error handling verified: $ERROR_MSG (HTTP 404)"
else
    print_error "Error handling test failed (HTTP $HTTP_CODE)"
    exit 1
fi
echo ""

# Test 11: Error handling - Invalid entity name
print_info "Test 11: GET invalid entity name (admin app)"
HTTP_CODE=$(curl -k -s https://localhost:7012/api/admin/entities/acme/invalidEntity/1 \
  -w "%{http_code}" -o /tmp/invalid-check.json)
RESPONSE=$(cat /tmp/invalid-check.json)
if [ "$HTTP_CODE" = "404" ]; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error')
    print_status "Entity validation verified: $ERROR_MSG (HTTP 404)"
else
    print_error "Entity validation test failed (HTTP $HTTP_CODE)"
    exit 1
fi
echo ""

# Test 12: Multi-schema entity isolation (admin/metrics apps)
# Test: acme:Company (admin) vs initech:Company (metrics)
print_info "Test 12: Multi-schema entity isolation (admin app acme:Company vs metrics app initech:Company)"

# 12a: Verify admin app acme:Company returns data with 'name' field
RESPONSE=$(curl -k -s "https://localhost:7012/api/admin/entities/acme/Company")
HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/admin/entities/acme/Company")
if [ "$HTTP_CODE" != "200" ]; then
    print_error "Failed to fetch admin app acme:Company (HTTP $HTTP_CODE)"
    exit 1
fi
HAS_NAME=$(echo "$RESPONSE" | jq '.[0] | has("name")')
HAS_COMPANY_NAME=$(echo "$RESPONSE" | jq '.[0] | has("companyName")')
if [ "$HAS_NAME" = "true" ] && [ "$HAS_COMPANY_NAME" = "false" ]; then
    print_status "admin app acme:Company correctly returns 'name' field (not 'companyName')"
else
    print_error "admin app acme:Company returned wrong schema! has_name=$HAS_NAME, has_companyName=$HAS_COMPANY_NAME"
    echo "$RESPONSE" | jq '.[0]'
    exit 1
fi

# 12b: Verify metrics app initech:Company returns data with 'companyName' field
RESPONSE=$(curl -k -s "https://localhost:7012/api/metrics/entities/initech/Company")
HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/metrics/entities/initech/Company")
if [ "$HTTP_CODE" != "200" ]; then
    print_error "Failed to fetch metrics app initech:Company (HTTP $HTTP_CODE)"
    exit 1
fi
HAS_COMPANY_NAME=$(echo "$RESPONSE" | jq '.[0] | has("companyName")')
HAS_NAME=$(echo "$RESPONSE" | jq '.[0] | has("name")')
if [ "$HAS_COMPANY_NAME" = "true" ] && [ "$HAS_NAME" = "false" ]; then
    print_status "metrics app initech:Company correctly returns 'companyName' field (not 'name')"
else
    print_error "metrics app initech:Company returned wrong schema! has_companyName=$HAS_COMPANY_NAME, has_name=$HAS_NAME"
    echo "$RESPONSE" | jq '.[0]'
    exit 1
fi
print_status "Multi-schema entity isolation verified"
echo ""

# Test 13: Cross-app entity isolation
# admin app can see Category, but reporting and metrics cannot
print_info "Test 13: Cross-app entity isolation (Category is admin-only)"

# 13a: admin app can access Category
HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/admin/entities/acme/Category")
if [ "$HTTP_CODE" = "200" ]; then
    print_status "admin app can access Category (HTTP 200)"
else
    print_error "admin app should access Category but got HTTP $HTTP_CODE"
    exit 1
fi

# 13b: reporting app cannot access Category (should be 404)
HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/reporting/entities/acme/Category")
if [ "$HTTP_CODE" = "404" ]; then
    print_status "reporting app correctly cannot access Category (HTTP 404)"
else
    print_error "reporting app should not access Category but got HTTP $HTTP_CODE"
    exit 1
fi

# 13c: metrics app cannot access any acme entities (different schema)
HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/metrics/entities/acme/Category")
if [ "$HTTP_CODE" = "404" ]; then
    print_status "metrics app correctly cannot access acme entities (HTTP 404)"
else
    print_error "metrics app should not access acme entities but got HTTP $HTTP_CODE"
    exit 1
fi
print_status "Cross-app entity isolation verified"
echo ""

# Test 14: Invalid app returns 404
print_info "Test 14: Invalid app returns 404"
HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/invalidapp/entities/acme/Product")
if [ "$HTTP_CODE" = "404" ]; then
    print_status "Invalid app correctly returns 404"
else
    print_error "Invalid app should return 404 but got HTTP $HTTP_CODE"
    exit 1
fi
print_status "Invalid app error handling verified"
echo ""

# Final count verification
print_info "Final verification: Product count (admin app)"
FINAL_COUNT=$(curl -k -s https://localhost:7012/api/admin/entities/acme/Product/count)
print_status "Final product count: $FINAL_COUNT (should equal initial count)"
echo ""

echo "================================"
echo "✅ ALL MULTI-APP TESTS VERIFIED"
echo "================================"
echo ""
print_status "All 14 tests passed successfully!"
print_info "Server logs available at: /tmp/dotnet-dev.log"
echo ""
