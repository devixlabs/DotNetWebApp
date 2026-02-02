-- =====================================================
-- Acuity Import - Seed Data
-- =====================================================
-- Creates test users and sample data for Acuity Import system testing
-- Run with: make seed (includes this file via sql/seed.sql)

USE GAIMisc;
GO

-- =====================================================
-- 1. User Configuration (gai_dmstech)
-- =====================================================
-- Required fields from spec:
--   gs_chr1 = Username (Windows login)
--   gs_int1 = Security level (0=Admin, 1-5=User, 9=SuperUser)
--   gs_chr3 = Warehouse assignment ("CPFG" or "Northlake")
--   gs_type = User type

PRINT 'Seeding gai_dmstech (User Warehouse Assignments)...';

-- Clear existing test data
DELETE FROM gai_dmstech WHERE gs_chr1 IN ('testuser', 'admin', 'cpfg_user', 'northlake_user', 'jrade');

-- Test Users for Acuity Import
INSERT INTO gai_dmstech (gs_index, gs_id, gs_type, gs_chr1, gs_chr2, gs_chr3, gs_int1)
VALUES
    -- Admin user at CPFG warehouse
    (1, 1, 1, 'admin', 'Administrator', 'CPFG', 0),

    -- Test user at CPFG warehouse (most common for testing)
    (2, 1, 1, 'testuser', 'Test User', 'CPFG', 1),

    -- CPFG warehouse user
    (3, 1, 1, 'cpfg_user', 'CPFG User', 'CPFG', 1),

    -- Northlake warehouse user
    (4, 2, 1, 'northlake_user', 'Northlake User', 'Northlake', 1),

    -- Developer user (replace with actual username if needed)
    (5, 1, 1, 'jrade', 'John Rade', 'CPFG', 0);

PRINT 'Inserted 5 test users into gai_dmstech';

-- Verify inserts
SELECT
    gs_chr1 AS Username,
    gs_chr3 AS Warehouse,
    gs_int1 AS SecurityLevel,
    CASE
        WHEN gs_int1 = 0 THEN 'Admin'
        WHEN gs_int1 = 9 THEN 'SuperUser'
        ELSE 'User'
    END AS Role
FROM gai_dmstech
WHERE gs_chr1 IN ('testuser', 'admin', 'cpfg_user', 'northlake_user', 'jrade')
ORDER BY gs_chr1;

PRINT 'gai_dmstech seed data complete!';
PRINT '';

-- =====================================================
-- 2. Sample Scheduler Data (Optional - for testing updates)
-- =====================================================
PRINT 'Seeding sample gai_scheduler records...';

-- Clear existing test data
DELETE FROM gai_scheduler WHERE gs_ordnum IN (20250123499, 20250123400, 20250123401);

-- Sample ICT order (pre-created, will be updated by Acuity Import)
INSERT INTO gai_scheduler (
    gs_index, gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend,
    gs_dockm, gs_company, gs_carrier, gs_driver, gs_chr2,
    gs_notes, gs_status, gs_datechkin, gs_appid, gs_forkop,
    gs_num1, gs_chr3, gs_date1
)
VALUES
    -- ICT order at CPFG (WID=3)
    (1, 3, 20250123499, '0', '2025-10-17 07:00:00', '2025-10-17 07:30:00',
     '00:00:00', 'Greenwood Associates Inc.', 'TBD', '', '()',
     'Notes', 'N/A', '2025-10-17 07:00:00', '', '',
     3, NULL, '2025-10-17 07:00:00');

PRINT 'Inserted 1 sample ICT order into gai_scheduler';
PRINT 'This order will be updated when CSV is imported with matching appointment ID';
PRINT '';

-- =====================================================
-- Summary
-- =====================================================
PRINT '============================================';
PRINT 'Acuity Import Seed Data Complete!';
PRINT '============================================';
PRINT '';
PRINT 'Test Users Created:';
PRINT '  - testuser (CPFG, Security=1) - Default test user';
PRINT '  - admin (CPFG, Security=0) - Admin user';
PRINT '  - cpfg_user (CPFG, Security=1)';
PRINT '  - northlake_user (Northlake, Security=1)';
PRINT '  - jrade (CPFG, Security=0) - Developer';
PRINT '';
PRINT 'Sample Orders Created:';
PRINT '  - 20250123499 (ICT order at CPFG)';
PRINT '';
PRINT 'Next Steps:';
PRINT '  1. Upload sql/acuity/seed.csv via /acuity-import page';
PRINT '  2. Use username "testuser" (default in UI)';
PRINT '  3. Verify import results';
PRINT '';
