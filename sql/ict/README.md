# ICT (Inter-Company Transfer) - Seed Data

This directory contains seed data for ICT system testing.

## Files

### seed.sql
SQL script that creates test ICT orders and line items.

**Creates:**
- 2 sample ICT orders in `gai_scheduler`
  - `20250000199` - Empty order (CPFG → Northlake, ready for product additions)
  - `20250000299` - Order with 2 line items (Northlake → CPFG, demonstrates calculations)
- 2 sample line items in `gai_allocate` (for order 20250000299)

**Execution:**
This file is automatically included when running:
```bash
make seed
```

## ICT Order Format

### Order Number Structure
```
Format: YYYY + 5-digit-index + "99"
Example: 20250000199
         ^^^^ ^^^^^ ^^
         year index ICT suffix
```

### Order Types (gs_num1)
- `3` = ICT Northlake (destination: WID 92)
- `4` = ICT CPFG (destination: WID 3)

### Warehouse IDs (gs_id)
- `3` = CPFG (6280 W. Howard St., Niles, IL 60714)
- `92` = Northlake (555 Northwest Ave., Northlake, IL 60164)

## Test Orders

### Order 1: 20250000199 (Empty Order)
- **Destination:** Northlake (WID 92)
- **Source:** CPFG (WID 3)
- **Purpose:** Ready for testing product additions
- **Status:** Empty (0 products, 0 pallets)

### Order 2: 20250000299 (Complete Order)
- **Destination:** CPFG (WID 3)
- **Source:** Northlake (WID 92)
- **Products:** 2 line items
  - TEST-001: 100 cases, 3 pallets, 250 lbs net
  - TEST-002: 50 cases, 2 pallets, 250 lbs net
- **Totals:** 2 products, 5 pallets, 500 lbs net, 550 lbs gross
- **Job:** JOB-2025-001
- **Status:** Complete (demonstrates calculations)

## Usage

### 1. Seed the Database
```bash
make seed
```

This will create all test ICT orders and line items.

### 2. Test ICT UI
**Navigate to:** http://localhost:5000/ict-orders

**Test Scenarios:**
1. **View Orders** - See the 2 sample orders in the grid
2. **Create New Order** - Click "Create New Order" to generate a new order number
3. **Add Products** - Test product addition and pallet calculations
4. **Submit Order** - Verify totals are calculated correctly
5. **Delete Order** - Confirm deletion from both tables

### 3. Test ICT API
**List Orders:**
```bash
curl http://localhost:5000/api/ict/orders?warehouseId=3
```

**Get Order Details:**
```bash
curl http://localhost:5000/api/ict/orders/20250000299
```

**Create New Order:**
```bash
curl -X POST http://localhost:5000/api/ict/orders \
  -H "Content-Type: application/json" \
  -d '{
    "sourceWarehouseId": 3,
    "destinationWarehouseId": 92,
    "notes": "API Test Order",
    "jobNumber": "JOB-2025-002"
  }'
```

**Add Line Item:**
```bash
curl -X POST http://localhost:5000/api/ict/orders/20250000199/items \
  -H "Content-Type: application/json" \
  -d '{
    "productCode": "TEST-001",
    "quantity": 50,
    "description": "Test Product 001",
    "jobNumber": "JOB-2025-001"
  }'
```

### 4. Verify Database
Query the database to see ICT orders:
```sql
USE GAIMisc;

-- View ICT orders
SELECT
    gs_ordnum AS OrderNumber,
    gs_id AS WarehouseId,
    gs_num1 AS OrderType,
    gs_num4 AS ProductCount,
    gs_num5 AS TotalPallets,
    gs_nwt AS NetWeight,
    gs_gwt AS GrossWeight,
    gs_chr3 AS JobNumber
FROM gai_scheduler
WHERE gs_ordnum % 100 = 99
  AND gs_dec3 = 99
ORDER BY gs_ordnum;

-- View line items for an order
SELECT
    all_ordernum AS OrderNumber,
    all_codenum AS ProductCode,
    all_description AS Description,
    all_qty AS Quantity,
    all_int2 AS Pallets,
    all_nwt AS NetWeight,
    all_gwt AS GrossWeight
FROM gai_allocate
WHERE all_ordernum = 20250000299
  AND all_dec3 = 99
ORDER BY all_index;
```

## Test Coverage

The seed data tests these critical ICT scenarios:

✓ Order number format (YYYY + 5-digit + "99")
✓ Warehouse determination (3=CPFG, 92=Northlake)
✓ Order type classification (3=ICT-NL, 4=ICT-CPFG)
✓ Pallet calculations (Math.Ceiling - always rounds UP)
✓ Weight calculations (net, gross, tare)
✓ Line item aggregation (totals from line items)
✓ Order creation/deletion (both tables)
✓ Job number linking

## Expected Behavior

### Pallet Calculation (CRITICAL!)
The system MUST use `Math.Ceiling` to always round UP:
- 100 cases / 40 per pallet = 2.5 → **3 pallets**
- 101 cases / 50 per pallet = 2.02 → **3 pallets**
- 50 cases / 40 per pallet = 1.25 → **2 pallets**

### Order Number Generation
When creating new orders:
1. Query MAX index from `gai_scheduler` for current year
2. Increment by 1
3. Format: `{year}{nextIndex:D5}99`
4. Example: If MAX is 20250000299, next will be 202500003​99

### Order Submission
When submitting an order:
1. Aggregates line items (COUNT, SUM pallets, SUM weights)
2. Updates `gai_scheduler` totals:
   - gs_num4 = product count
   - gs_num5 = total pallets
   - gs_pronum = product count (duplicate)
   - gs_pallets = total pallets (duplicate)
   - gs_nwt = total net weight
   - gs_gwt = total gross weight

### Order Deletion
CRITICAL: Must delete from BOTH tables:
1. Delete from `gai_scheduler` (header)
2. Delete from `gai_allocate` (line items)

## Troubleshooting

**Issue:** "Order not found"
**Solution:** Run `make seed` to create test orders

**Issue:** "No products available"
**Solution:** ICT uses products from Deacom (`dmprod`, `dtfifo`). The seed data creates orders with fictional product codes. For full testing, add real products to these tables or use existing products from your Deacom system.

**Issue:** Pallet calculation seems wrong
**Solution:** Verify `Math.Ceiling` is being used. Run unit tests:
```bash
dotnet test --filter "PalletCalculator"
```

## Next Steps

To add real product data for testing:
1. Add products to `dmprod` in `sql/seed.sql`
2. Add inventory to `dtfifo` for those products
3. Add cases-per-pallet attribute to `dtd2` (d2_d1id = 224)
4. Re-run `make seed`
5. Products will then appear in "Get Available Products" API

## Integration with Other Systems

**Links to:**
- **Acuity Import** - ICT orders can be scheduled via Acuity
- **PrePick** - ICT orders can be picked and audited
- **DockScheduler** - ICT orders appear in dock scheduling

**Shared Tables:**
- `gai_scheduler` - Order headers (used by all 5 apps)
- `gai_allocate` - Line items (used by ICT and Allocation)
- `gai_dmstech` - User configuration (used by all 5 apps)
