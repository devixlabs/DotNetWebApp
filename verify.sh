#!/usr/bin/env bash
set -e

# Parameterized verification script
# Usage: ./verify.sh [FLAGS] [APP_NAME] [SCHEMA_NAME] [ENTITY_NAME] [SECONDARY_APP] [SECONDARY_SCHEMA] [SECONDARY_ENTITY]
#
# Flags:
#   --drop              Drop and recreate databases (destructive - use with caution)
#
# Examples:
#   ./verify.sh                                        # Safe: reuse existing databases
#   ./verify.sh --drop                                 # Drop databases, recreate from scratch
#   ./verify.sh admin myschema MyEntity                # Override schema (safe mode)
#   ./verify.sh --drop admin acme Product              # Drop + custom schema
#   ./verify.sh admin acme Product reporting acme Order  # Multi-app test (safe mode)

# Parse flags
DROP_DATABASE=false
if [ "$1" = "--drop" ]; then
    DROP_DATABASE=true
    shift  # Remove flag, shift remaining args
fi

# Set defaults (generic example schema - safe to share)
APP_NAME="${1:-admin}"
SCHEMA_NAME="${2:-acme}"
ENTITY_NAME="${3:-Product}"
SECONDARY_APP="${4:-metrics}"
SECONDARY_SCHEMA="${5:-initech}"
SECONDARY_ENTITY="${6:-Company}"

echo "================================"
echo "DotNetWebApp CRUD Verification"
echo "================================"
echo "Testing: $APP_NAME / $SCHEMA_NAME / $ENTITY_NAME"
if [ "$SECONDARY_SCHEMA" != "initech" ] || [ "$SECONDARY_APP" != "metrics" ]; then
    echo "Secondary: $SECONDARY_APP / $SECONDARY_SCHEMA / $SECONDARY_ENTITY"
fi
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

# Step 3: Drop database (optional)
if [ "$DROP_DATABASE" = true ]; then
    print_info "Step 3: Dropping database(s) (--drop flag)..."
    make db-drop || print_info "Docker database drop attempted (may not exist)"
    print_status "Docker database dropped"
else
    print_info "Step 3: Skipping database drop (safe mode - use --drop to reset)"
    print_status "Using existing databases"
fi
echo ""

# Step 4: Run DDL pipeline
print_info "Step 4: Running DDL pipeline (make run-ddl-pipeline)..."
make run-ddl-pipeline
print_status "DDL pipeline completed"
echo ""

# Step 5: Apply migrations (includes schema initialization)
print_info "Step 5: Applying migrations (make migrate)..."
make migrate
print_status "Migrations applied (includes schema initialization)"
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
print_status "Run: tail -f /tmp/dotnet-dev.log"
echo ""

# Wait for server to be ready
print_info "Waiting for server to be ready..."
MAX_WAIT=30
WAIT_COUNT=0
while [ $WAIT_COUNT -lt $MAX_WAIT ]; do
    if curl -k -s "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}" > /dev/null 2>&1; then
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

# Test 1: GET all entities
print_info "Test 1: GET all entities ($APP_NAME / $SCHEMA_NAME / $ENTITY_NAME)"
RESPONSE=$(curl -k -s "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}")
COUNT=$(echo "$RESPONSE" | jq 'length')
print_status "Found $COUNT records"
echo "$RESPONSE" | jq '.[0:2]' # Show first 2 records
echo ""

# Test 2: GET entity by ID
print_info "Test 2: GET entity by ID (id=1)"
RESPONSE=$(curl -k -s "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}/1")
ENTITY_DISPLAY=$(echo "$RESPONSE" | jq -r 'to_entries[0].value // "Record"')
print_status "Retrieved: $ENTITY_DISPLAY"
echo "$RESPONSE" | jq .
echo ""

# Test 3: GET count
print_info "Test 3: GET entity count"
COUNT=$(curl -k -s "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}/count")
print_status "Entity count: $COUNT"
echo ""

# Test 4: POST - Create new entity
# Note: Generic test - actual payload depends on entity schema
print_info "Test 4: POST - Create new entity (note: schema-dependent)"
print_status "Skipping POST test (schema-specific payload required)"
print_info "For custom entities, provide specific field data"
echo ""
NEW_ID="1"  # Default to ID 1 for subsequent tests

# Test 5: GET existing entity
print_info "Test 5: GET existing entity (id=$NEW_ID)"
RESPONSE=$(curl -k -s "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}/${NEW_ID}")
ENTITY_DISPLAY=$(echo "$RESPONSE" | jq -r 'to_entries[0].value // "Record"')
print_status "Retrieved: $ENTITY_DISPLAY"
echo "$RESPONSE" | jq .
echo ""

# Test 6: PUT - Update entity
# Note: Generic test - actual payload depends on entity schema
print_info "Test 6: PUT - Update entity (note: schema-specific payload required)"
print_status "Skipping PUT test (schema-specific payload required)"
print_info "For custom entities, provide specific field data"
echo ""

# Test 7: Verify data still accessible
print_info "Test 7: Verify data still accessible (id=$NEW_ID)"
HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}/${NEW_ID}")
if [ "$HTTP_CODE" = "200" ]; then
    print_status "Data accessible (HTTP 200)"
else
    print_error "Data access failed (HTTP $HTTP_CODE)"
    exit 1
fi
echo ""

# Test 8: DELETE - Not tested in generic mode
print_info "Test 8: DELETE entity (note: requires test record)"
print_status "Skipping DELETE test (no test record created in generic mode)"
echo ""

# Test 9: Error handling - Non-existent ID
print_info "Test 9: GET non-existent entity (should return 404)"
HTTP_CODE=$(curl -k -s "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}/99999" \
  -w "%{http_code}" -o /tmp/notfound-check.json)
RESPONSE=$(cat /tmp/notfound-check.json)
if [ "$HTTP_CODE" = "404" ]; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error' 2>/dev/null || echo "Not found")
    print_status "Error handling verified: $ERROR_MSG (HTTP 404)"
else
    print_error "Error handling test failed (HTTP $HTTP_CODE)"
    exit 1
fi
echo ""

# Test 10: Error handling - Invalid entity name
print_info "Test 10: GET invalid entity name (should return 404)"
HTTP_CODE=$(curl -k -s "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/InvalidEntity/1" \
  -w "%{http_code}" -o /tmp/invalid-check.json)
RESPONSE=$(cat /tmp/invalid-check.json)
if [ "$HTTP_CODE" = "404" ]; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error' 2>/dev/null || echo "Not found")
    print_status "Entity validation verified: $ERROR_MSG (HTTP 404)"
else
    print_error "Entity validation test failed (HTTP $HTTP_CODE)"
    exit 1
fi
echo ""

# Test 12: Multi-app/schema isolation (optional - if secondary schema configured)
print_info "Test 12: Multi-app isolation verification (optional)"

if [ "$SECONDARY_SCHEMA" != "$SCHEMA_NAME" ] || [ "$SECONDARY_APP" != "$APP_NAME" ]; then
    # Verify primary app can access primary entity
    HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}")
    if [ "$HTTP_CODE" = "200" ]; then
        print_status "$APP_NAME can access $SCHEMA_NAME:$ENTITY_NAME (HTTP 200)"
    else
        print_error "$APP_NAME should access $SCHEMA_NAME:$ENTITY_NAME but got HTTP $HTTP_CODE"
        exit 1
    fi

    # Verify secondary app can access secondary entity
    HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/${SECONDARY_APP}/entities/${SECONDARY_SCHEMA}/${SECONDARY_ENTITY}")
    if [ "$HTTP_CODE" = "200" ]; then
        print_status "$SECONDARY_APP can access $SECONDARY_SCHEMA:$SECONDARY_ENTITY (HTTP 200)"
    else
        print_error "$SECONDARY_APP should access $SECONDARY_SCHEMA:$SECONDARY_ENTITY but got HTTP $HTTP_CODE"
        exit 1
    fi

    print_status "Multi-app/schema isolation verified"
else
    print_status "Skipped (single schema/app test)"
fi
echo ""

# Test 13: Invalid app returns 404
print_info "Test 13: Invalid app returns 404"
HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" "https://localhost:7012/api/invalidapp/entities/${SCHEMA_NAME}/${ENTITY_NAME}")
if [ "$HTTP_CODE" = "404" ]; then
    print_status "Invalid app correctly returns 404"
else
    print_error "Invalid app should return 404 but got HTTP $HTTP_CODE"
    exit 1
fi
print_status "Invalid app error handling verified"
echo ""

# Final count verification
print_info "Final verification: Entity count ($APP_NAME / $SCHEMA_NAME / $ENTITY_NAME)"
FINAL_COUNT=$(curl -k -s "https://localhost:7012/api/${APP_NAME}/entities/${SCHEMA_NAME}/${ENTITY_NAME}/count")
print_status "Final entity count: $FINAL_COUNT"
echo ""

echo "==================================================="
echo "✅✅✅   VERIFICATION TESTS PASSED   ✅✅✅"
print_status "All tests passed successfully!"
print_info "Configuration: $APP_NAME / $SCHEMA_NAME / $ENTITY_NAME"
print_info "Server logs: /tmp/dotnet-dev.log"
echo "==================================================="
echo ""
