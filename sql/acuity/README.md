# Acuity Import - Seed Data and Test Files

This directory contains seed data and test files for the Acuity Import system (Phase 2 - First Application).

## Files

### seed.sql
SQL script that creates test users and sample data for Acuity Import testing.

**Creates:**
- 5 test users in `gai_dmstech` (user warehouse assignments)
  - `testuser` - Default test user (CPFG, Security=1)
  - `admin` - Admin user (CPFG, Security=0)
  - `cpfg_user` - CPFG warehouse user
  - `northlake_user` - Northlake warehouse user
  - `jrade` - Developer user (CPFG, Security=0)

- 1 sample ICT order in `gai_scheduler`
  - Order: 20250123499 (ICT at CPFG)
  - Will be updated when CSV is imported with matching appointment ID

**Execution:**
This file is automatically included when running:
```bash
make seed
```

### seed.csv
Sample Acuity scheduling CSV file with 6 test appointments.

**Format:** 22 columns matching Acuity export specification
- Column 0: Start Time
- Column 1: End Time
- Column 20: Order Numbers (CRITICAL - can contain multiple orders)
- Column 21: Appointment ID

**Test Cases Included:**
1. **Single Sales Order** - Northlake warehouse
   - Order: 2025-41158-00
   - Driver: Joey Funk
   - Carrier: rxo

2. **Single Sales Order** - CPFG warehouse
   - Order: 2025-41159-00
   - Driver: Sarah Connor
   - Carrier: True River

3. **ICT Order** - With GAI- prefix
   - Order: GAI-20250123499
   - Driver: John Smith
   - Carrier: Federal Express
   - **UPDATE scenario** (matches existing order in seed.sql)

4. **Purchase Order** - With FBS# prefix
   - Order: FBS#20250123401
   - Driver: Jane Doe
   - Carrier: UPS

5. **Multiple Orders** - Comma-separated (tests bug fix)
   - Orders: 2025-41160-00, 2025-41161-00
   - Driver: Bob Wilson
   - **Tests the multi-order handling fix**

6. **Pro Number** - Pro- prefix
   - Order: Pro-208386
   - Driver: Alice Brown
   - Phone: Empty (tests default "()" behavior)

## Usage

### 1. Seed the Database
```bash
make seed
```

This will create all test users and sample data.

### 2. Test CSV Import

**Via UI (Recommended):**
1. Navigate to http://localhost:5000/acuity-import
2. Enter username: `testuser` (or any user from seed data)
3. Upload `sql/acuity/seed.csv`
4. Review import results

**Via API:**
```bash
curl -X POST http://localhost:5000/api/AcuityImport/upload \
  -F "file=@sql/acuity/seed.csv" \
  -F "userName=testuser"
```

### 3. Verify Results

Query the database to see imported orders:
```sql
USE GAIMisc;
SELECT
    gs_ordnum AS OrderNumber,
    gs_company AS Company,
    gs_carrier AS Carrier,
    gs_driver AS Driver,
    gs_appid AS AppointmentID,
    gs_datestart AS ScheduledStart,
    gs_status AS Status,
    gs_num1 AS OrderType
FROM gai_scheduler
WHERE gs_ordnum IN (
    20254115800, 20254115900, 20250123499,
    20250123401, 20254116000, 20254116100
)
ORDER BY gs_datestart;
```

## Test Coverage

The seed.csv file tests these critical scenarios:

✓ Order number cleaning (GAI-, FBS#, Pro- prefixes)
✓ Multiple orders in single cell (comma-separated)
✓ Warehouse determination (Northlake vs CPFG)
✓ Driver name fix (FirstName + LastName, not FirstName + FirstName)
✓ Default values (empty phone → "()", empty carrier → "TBD")
✓ Order type classification (ICT/SO/PO)
✓ INSERT vs UPDATE logic (ICT order exists, should be updated)
✓ Date parsing (Acuity "October 17, 2025 7:00 am" format)

## Expected Results

After importing `seed.csv`:
- **5 new records inserted** (orders 41158-00, 41159-00, 123401, 41160-00, 41161-00)
- **1 record updated** (order 123499 - ICT with appointment ID)
- **0 errors** (all orders should process successfully)

Total: 6 appointments → 7 orders (one appointment has 2 orders)

## Troubleshooting

**Issue:** "User not found"
**Solution:** Run `make seed` to create test users

**Issue:** "Orders not found in Deacom"
**Solution:** This is expected - seed.csv uses fictional order numbers. Real Deacom integration would require actual orders in the `dttord`/`dtpur` tables.

**Issue:** Import shows errors for orders not in Deacom
**Solution:** For full testing, add corresponding records to Deacom tables (`dttord`, `dtpur`, etc.) in `sql/seed.sql`

## Next Steps

To add real Deacom data for testing:
1. Add sales orders to `dttord` in `sql/seed.sql`
2. Add purchase orders to `dtpur`/`dttpur` in `sql/seed.sql`
3. Re-run `make seed`
4. Import will then enrich with real company names, promise dates, etc.
