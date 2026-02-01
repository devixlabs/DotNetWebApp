-- ============================================================================
-- SEED DATA FOR DotNetWebApp
-- Uses actual column names from sql/schema.sql
-- Minimal seed data with only simple tables that don't require complex foreign keys
-- ============================================================================

-- ============================================================================
-- 1. UNITS OF MEASURE (dmunit)
-- Simple table with no foreign key dependencies
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmunit] WHERE un_name = 'Each')
BEGIN
    INSERT INTO [dbo].[dmunit]
    (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES
    ('Each', 1, 1, 'P', 1, 1.0, 0.0, 0.0, 0, 1.0, '', 'EA');
END;

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmunit] WHERE un_name = 'Case')
BEGIN
    INSERT INTO [dbo].[dmunit]
    (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES
    ('Case', 1, 0, 'P', 0, 12.0, 0.0, 0.0, 0, 1.0, '', 'CS');
END;

-- ============================================================================
-- NOTE: Tables with many NOT NULL columns and foreign key requirements
-- (dmprod, dmbill, dmship, dttord, etc.) are excluded from this seed script.
-- The schema.sql has many legacy DMS tables with complex dependencies.
-- To seed these tables, populate them with proper application logic or
-- provide a complete seed dataset that respects all constraints.
-- Tables commented out in schema.sql (acuity_forms, acuity_form_values,
-- __EFMigrationsHistory) are NOT seeded.
-- ============================================================================

-- ============================================================================
-- DATA VERIFICATION & SUMMARY
-- ============================================================================

PRINT '';
PRINT '========== SEED DATA SUMMARY ==========';
SELECT 'UNITS' AS [Category], COUNT(*) AS [Count] FROM [dbo].[dmunit];

PRINT 'Seed data loaded successfully!';
PRINT '=======================================';
