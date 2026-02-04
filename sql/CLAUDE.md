# SQL Directory - Claude Context

## Overview

This directory contains SQL scripts for database schema and seed data management.

## Key Files

- **schema.sql** - SQL DDL source for entity definitions (run through DDL pipeline)
- **seed.sql** - Comprehensive seed data for all applications (GAI, GAIMisc databases)
- **views/** - SQL SELECT queries for view definitions (referenced in appsettings.json)

## Seed Data Management

### Current Seed Data Coverage (as of 2026-02-04)

**GAI Database (Allocation Application):**
- **dttord table:** 271 orders
  - 11 base test orders (Feb 1-2 + historical)
  - 260 generated orders (Feb 3-28, 10 per day)
  - Order numbers: 50001-50006 (base), 50171-50223 (historical), 50301-50560 (generated)
  - Mix: ~67% CPFG (waid=3), ~33% Northlake (waid=92)

**GAIMisc Database:**
- **gai_allocate table:** 196 allocation records
  - 14 base test allocations
  - 182 generated allocations (Feb 3-28, covering ~60% of orders)
  - Both warehouses: CPFG (all_id=3) and Northlake (all_id=92)
  - Date coverage: Every day from Feb 3-28

- **gai_scheduler table:** 913 orders
  - 405 PrePick orders (Feb 2-28, 15 per day)
  - 270 "Allocation" scheduler entries (Feb 2-28, 10 per day) - NOTE: These are NOT dttord allocations
  - 216 DMS orders (Feb 2-28, 8 per day)

### Important Order Number Ranges

**AVOID CONFLICTS:** When generating new seed data, avoid these ranges:
- 50001-50006: Core allocation test orders
- 50171-50223: Historical allocation test orders (Jan 27-Feb 1)
- **50301-50560:** Generated Feb 3-28 allocation orders (OCCUPIED)
- **Safe range for new data:** Start at 50561 or 60001+

### Generating Additional Seed Data

The Python scripts used to generate the current data are located in the scratchpad:
```
/tmp/claude-1000/-home-jrade-code-devixlabs-DotNetWebApp/{session-id}/scratchpad/
```

**Key Scripts:**
1. **generate_allocation_fixed.py** - Generates dttord (Allocation orders)
   - Uses exact column format from existing INSERT statements
   - Produces 91-column INSERT matching seed.sql structure
   - Order numbers configurable (currently 50301+)

2. **generate_allocations.py** - Generates gai_allocate (Inventory allocations)
   - Creates allocations for subset of orders (~60%)
   - Generates actual dates (not GETDATE())
   - Varies allocation status and pick quantities

3. **generate_feb_seed.py** - Generates gai_scheduler orders (PrePick/DMS/Scheduler)
   - 15 PrePick orders per day
   - 10 "Allocation" scheduler entries per day (different from dttord!)
   - 8 DMS orders per day

### Critical Lessons Learned

#### 1. Column Count Mismatches
**Problem:** Generated INSERT statements with 118 columns failed because existing seed.sql uses 91 columns.

**Solution:** Extract exact column list from existing INSERT statements:
```bash
grep -A 11 "^INSERT INTO \[dbo\]\.\[dttord\]" sql/seed.sql | head -12
```

Always match the column count and order exactly when generating new data.

#### 2. Order Number Conflicts
**Problem:** Generated orders starting at 50201 overwrote historical test orders (50201, 50221, 50223).

**Solution:**
- Document all reserved order number ranges
- Start generated data at safe ranges (50301+ worked)
- Use DELETE statements that match the generated range exactly

#### 3. Date Generation with GETDATE()
**Problem:** Using `GETDATE()` in INSERT statements causes all records to have the same date (when seed.sql runs).

**Solution:** Generate actual date strings in Python:
```python
date_str = current.strftime('%Y-%m-%d %H:%M:%S')
# Then use: '{date_str}' in SQL, not GETDATE()
```

#### 4. Idempotency Requirements
**Problem:** Running `make seed` multiple times accumulates duplicate data.

**Solution:** Always include DELETE statements before INSERT:
```sql
-- Clear existing Feb 3-28 allocation orders (idempotent)
DELETE FROM [dbo].[dttord] WHERE to_ordnum >= 50301 AND to_ordnum < 60000;
PRINT 'Cleared existing Feb 3-28 allocation orders for idempotent reloading';
```

#### 5. Database vs Schema Confusion
**Problem:** Queried `DotNetWebAppDb.GAIMisc.gai_scheduler` when data was actually in `GAIMisc.dbo.gai_scheduler` (GAIMisc is a DATABASE, not a schema).

**Solution:** Understand the database structure:
- **GAI database** - Contains dttord (Allocation orders), dtord (order lines), dtfifo (inventory)
- **GAIMisc database** - Contains gai_scheduler (PrePick/DMS), gai_allocate (allocations), gai_lock
- **DotNetWebAppDb database** - Main application database with generated entities

### Inserting Generated Data into seed.sql

**General Pattern:**
1. Backup current seed.sql (though git can restore)
2. Identify insertion point (line number)
3. Split file at insertion point
4. Concatenate: part1 + generated SQL + part2
5. Update any summary PRINT statements

**Example for dttord (Allocation orders):**
```bash
# Insert after line 909 (after last historical order, before PRINT statement)
head -909 sql/seed.sql > /tmp/part1.sql
tail -n +910 sql/seed.sql > /tmp/part2.sql
cat /tmp/part1.sql > sql/seed.sql.new
echo "" >> sql/seed.sql.new
cat generated_orders.sql >> sql/seed.sql.new
echo "" >> sql/seed.sql.new
cat /tmp/part2.sql >> sql/seed.sql.new
mv sql/seed.sql.new sql/seed.sql
```

**Example for gai_allocate (Inventory allocations):**
```bash
# Insert before line 4480 (before "Allocation Seed Data Complete")
head -4479 sql/seed.sql > /tmp/part1.sql
tail -n +4480 sql/seed.sql > /tmp/part2.sql
# ... concatenate with generated SQL ...
```

### Testing Generated Data

After updating seed.sql:

1. **Run the seed:**
   ```bash
   make seed
   ```

2. **Check for errors:**
   ```bash
   make seed 2>&1 | grep -i "error\|msg [0-9]"
   ```

3. **Verify counts:**
   ```bash
   # Allocation orders
   docker exec sqlserver-dev /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" \
     -d GAI -C -Q "SELECT COUNT(*) FROM dttord" -W

   # Inventory allocations
   docker exec sqlserver-dev /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" \
     -d GAIMisc -C -Q "SELECT COUNT(*) FROM gai_allocate" -W

   # Scheduler orders
   docker exec sqlserver-dev /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" \
     -d GAIMisc -C -Q "SELECT COUNT(*) FROM gai_scheduler" -W
   ```

4. **Verify date distribution:**
   ```bash
   # Check allocations by date
   docker exec sqlserver-dev /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" \
     -d GAIMisc -C -Q "SELECT CONVERT(DATE, all_date) as Date, COUNT(*) as Count \
     FROM gai_allocate GROUP BY CONVERT(DATE, all_date) ORDER BY CONVERT(DATE, all_date)" -W
   ```

### Common Pitfalls

1. **Wrong column count** - Always match existing INSERT format exactly
2. **Order number conflicts** - Check reserved ranges before generating
3. **GETDATE() instead of actual dates** - Causes all records to have same timestamp
4. **Missing DELETE statements** - Causes data accumulation on re-runs
5. **Wrong database** - GAI vs GAIMisc vs DotNetWebAppDb confusion
6. **Line number drift** - After inserting data, line numbers shift; always work from fresh git checkout

### Future Enhancements

If you need to generate data for a different month or year:

1. **Update Python scripts:**
   ```python
   start_date = datetime(2026, 3, 1)  # Change month
   end_date = datetime(2026, 3, 31)
   ```

2. **Update order number ranges:**
   ```python
   order_num = 60001  # Use new safe range
   ```

3. **Update DELETE statements:**
   ```sql
   DELETE FROM [dbo].[dttord] WHERE to_ordnum >= 60001 AND to_ordnum < 70000;
   ```

### sqlcmd Path Note

The SQL Server container uses **mssql-tools18** (not mssql-tools):
```bash
docker exec sqlserver-dev /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C
```

The `-C` flag is required to trust the server certificate.

## Summary

The seed.sql file now contains comprehensive test data for February 2026 across all three applications (Allocation, PrePick, DMS). All data is idempotent and can be regenerated using the Python scripts in the scratchpad directory. When adding new data, always check for order number conflicts and match existing column formats exactly.
