-- =============================================================================
-- DotNetWebApp Seed Data
-- Generic example data for the white-label skeleton
-- =============================================================================

-- WEBAPP DATABASE
-- =============================================================================
USE [WEBAPP];
GO

-- Clear existing seed data (reverse FK order)
DELETE FROM [dbo].[order_lines] WHERE ol_id IN (1,2,3,4,5,6);
DELETE FROM [dbo].[inventory] WHERE in_id IN (1,2,3,4,5);
DELETE FROM [dbo].[orders] WHERE or_id IN (1,2,3,4);
DELETE FROM [dbo].[products] WHERE pr_id IN (1,2,3,4,5);
DELETE FROM [dbo].[customers] WHERE cu_id IN (1,2,3);
DELETE FROM [dbo].[vendors] WHERE ve_id IN (1,2,3);
DELETE FROM [dbo].[warehouses] WHERE wa_id IN (1,2,3);
DELETE FROM [dbo].[units_of_measure] WHERE um_id IN (1,2,3,4,5);
GO

-- Units of Measure
SET IDENTITY_INSERT [dbo].[units_of_measure] ON;
INSERT INTO [dbo].[units_of_measure] ([um_id], [um_name], [um_abbrev]) VALUES (1, 'Each', 'EA');
INSERT INTO [dbo].[units_of_measure] ([um_id], [um_name], [um_abbrev]) VALUES (2, 'Case', 'CS');
INSERT INTO [dbo].[units_of_measure] ([um_id], [um_name], [um_abbrev]) VALUES (3, 'Pallet', 'PLT');
INSERT INTO [dbo].[units_of_measure] ([um_id], [um_name], [um_abbrev]) VALUES (4, 'Gallon', 'GAL');
INSERT INTO [dbo].[units_of_measure] ([um_id], [um_name], [um_abbrev]) VALUES (5, 'Pound', 'LB');
SET IDENTITY_INSERT [dbo].[units_of_measure] OFF;
PRINT 'Seeded 5 units of measure';
GO

-- Warehouses
SET IDENTITY_INSERT [dbo].[warehouses] ON;
INSERT INTO [dbo].[warehouses] ([wa_id], [wa_name], [wa_code], [wa_street], [wa_city], [wa_state], [wa_zip], [wa_active])
VALUES (1, 'Main Warehouse', 'MAIN', '100 Industrial Pkwy', 'Springfield', 'IL', '62701', 1);
INSERT INTO [dbo].[warehouses] ([wa_id], [wa_name], [wa_code], [wa_street], [wa_city], [wa_state], [wa_zip], [wa_active])
VALUES (2, 'East Distribution Center', 'EAST', '200 Commerce Dr', 'Columbus', 'OH', '43215', 1);
INSERT INTO [dbo].[warehouses] ([wa_id], [wa_name], [wa_code], [wa_street], [wa_city], [wa_state], [wa_zip], [wa_active])
VALUES (3, 'West Fulfillment', 'WEST', '300 Logistics Ave', 'Phoenix', 'AZ', '85001', 1);
SET IDENTITY_INSERT [dbo].[warehouses] OFF;
PRINT 'Seeded 3 warehouses';
GO

-- Vendors
SET IDENTITY_INSERT [dbo].[vendors] ON;
INSERT INTO [dbo].[vendors] ([ve_id], [ve_name], [ve_code], [ve_city], [ve_state], [ve_phone], [ve_active])
VALUES (1, 'Acme Supplies Co', 'ACME', 'Chicago', 'IL', '312-555-0100', 1);
INSERT INTO [dbo].[vendors] ([ve_id], [ve_name], [ve_code], [ve_city], [ve_state], [ve_phone], [ve_active])
VALUES (2, 'Initech Materials', 'INIT', 'Austin', 'TX', '512-555-0200', 1);
INSERT INTO [dbo].[vendors] ([ve_id], [ve_name], [ve_code], [ve_city], [ve_state], [ve_phone], [ve_active])
VALUES (3, 'Globex Industries', 'GLOB', 'Portland', 'OR', '503-555-0300', 1);
SET IDENTITY_INSERT [dbo].[vendors] OFF;
PRINT 'Seeded 3 vendors';
GO

-- Customers
SET IDENTITY_INSERT [dbo].[customers] ON;
INSERT INTO [dbo].[customers] ([cu_id], [cu_name], [cu_code], [cu_city], [cu_state], [cu_phone], [cu_email], [cu_active])
VALUES (1, 'Acme Corporation', 'ACME-001', 'Springfield', 'IL', '217-555-1000', 'orders@acme.example.com', 1);
INSERT INTO [dbo].[customers] ([cu_id], [cu_name], [cu_code], [cu_city], [cu_state], [cu_phone], [cu_email], [cu_active])
VALUES (2, 'Initech Solutions', 'INIT-001', 'Austin', 'TX', '512-555-2000', 'purchasing@initech.example.com', 1);
INSERT INTO [dbo].[customers] ([cu_id], [cu_name], [cu_code], [cu_city], [cu_state], [cu_phone], [cu_email], [cu_active])
VALUES (3, 'Globex Corp', 'GLOB-001', 'Portland', 'OR', '503-555-3000', 'ops@globex.example.com', 1);
SET IDENTITY_INSERT [dbo].[customers] OFF;
PRINT 'Seeded 3 customers';
GO

-- Products
SET IDENTITY_INSERT [dbo].[products] ON;
INSERT INTO [dbo].[products] ([pr_id], [pr_name], [pr_code], [pr_price], [pr_cost], [pr_category], [pr_unit], [pr_active])
VALUES (1, 'Widget A', 'WGT-A', 12.50, 5.00, 'Widgets', 'Each', 1);
INSERT INTO [dbo].[products] ([pr_id], [pr_name], [pr_code], [pr_price], [pr_cost], [pr_category], [pr_unit], [pr_active])
VALUES (2, 'Widget B', 'WGT-B', 18.75, 7.50, 'Widgets', 'Each', 1);
INSERT INTO [dbo].[products] ([pr_id], [pr_name], [pr_code], [pr_price], [pr_cost], [pr_category], [pr_unit], [pr_active])
VALUES (3, 'Gadget Pro', 'GDG-P', 45.00, 20.00, 'Gadgets', 'Each', 1);
INSERT INTO [dbo].[products] ([pr_id], [pr_name], [pr_code], [pr_price], [pr_cost], [pr_category], [pr_unit], [pr_active])
VALUES (4, 'Bulk Material X', 'MAT-X', 2.50, 1.00, 'Materials', 'Pound', 1);
INSERT INTO [dbo].[products] ([pr_id], [pr_name], [pr_code], [pr_price], [pr_cost], [pr_category], [pr_unit], [pr_active])
VALUES (5, 'Container Set', 'CNT-S', 35.00, 15.00, 'Containers', 'Case', 1);
SET IDENTITY_INSERT [dbo].[products] OFF;
PRINT 'Seeded 5 products';
GO

-- Orders
SET IDENTITY_INSERT [dbo].[orders] ON;
INSERT INTO [dbo].[orders] ([or_id], [or_number], [or_customer_id], [or_warehouse_id], [or_date], [or_status], [or_total])
VALUES (1, 10001, 1, 1, '2026-03-01', 'Shipped', 150.00);
INSERT INTO [dbo].[orders] ([or_id], [or_number], [or_customer_id], [or_warehouse_id], [or_date], [or_status], [or_total])
VALUES (2, 10002, 2, 1, '2026-03-02', 'Processing', 225.00);
INSERT INTO [dbo].[orders] ([or_id], [or_number], [or_customer_id], [or_warehouse_id], [or_date], [or_status], [or_total])
VALUES (3, 10003, 3, 2, '2026-03-03', 'New', 87.50);
INSERT INTO [dbo].[orders] ([or_id], [or_number], [or_customer_id], [or_warehouse_id], [or_date], [or_status], [or_total])
VALUES (4, 10004, 1, 3, '2026-03-04', 'New', 500.00);
SET IDENTITY_INSERT [dbo].[orders] OFF;
PRINT 'Seeded 4 orders';
GO

-- Order Lines
SET IDENTITY_INSERT [dbo].[order_lines] ON;
INSERT INTO [dbo].[order_lines] ([ol_id], [ol_order_id], [ol_product_id], [ol_qty], [ol_price], [ol_total])
VALUES (1, 1, 1, 10, 12.50, 125.00);
INSERT INTO [dbo].[order_lines] ([ol_id], [ol_order_id], [ol_product_id], [ol_qty], [ol_price], [ol_total])
VALUES (2, 1, 2, 1, 18.75, 18.75);
INSERT INTO [dbo].[order_lines] ([ol_id], [ol_order_id], [ol_product_id], [ol_qty], [ol_price], [ol_total])
VALUES (3, 2, 3, 5, 45.00, 225.00);
INSERT INTO [dbo].[order_lines] ([ol_id], [ol_order_id], [ol_product_id], [ol_qty], [ol_price], [ol_total])
VALUES (4, 3, 4, 35, 2.50, 87.50);
INSERT INTO [dbo].[order_lines] ([ol_id], [ol_order_id], [ol_product_id], [ol_qty], [ol_price], [ol_total])
VALUES (5, 4, 5, 10, 35.00, 350.00);
INSERT INTO [dbo].[order_lines] ([ol_id], [ol_order_id], [ol_product_id], [ol_qty], [ol_price], [ol_total])
VALUES (6, 4, 1, 12, 12.50, 150.00);
SET IDENTITY_INSERT [dbo].[order_lines] OFF;
PRINT 'Seeded 6 order lines';
GO

-- Inventory
SET IDENTITY_INSERT [dbo].[inventory] ON;
INSERT INTO [dbo].[inventory] ([in_id], [in_product_id], [in_warehouse_id], [in_lot], [in_qty], [in_reserved], [in_expiry])
VALUES (1, 1, 1, 'LOT-2026-001', 500, 10, '2027-03-01');
INSERT INTO [dbo].[inventory] ([in_id], [in_product_id], [in_warehouse_id], [in_lot], [in_qty], [in_reserved], [in_expiry])
VALUES (2, 2, 1, 'LOT-2026-002', 200, 1, '2027-06-01');
INSERT INTO [dbo].[inventory] ([in_id], [in_product_id], [in_warehouse_id], [in_lot], [in_qty], [in_reserved], [in_expiry])
VALUES (3, 3, 2, 'LOT-2026-003', 100, 5, NULL);
INSERT INTO [dbo].[inventory] ([in_id], [in_product_id], [in_warehouse_id], [in_lot], [in_qty], [in_reserved], [in_expiry])
VALUES (4, 4, 1, 'LOT-2026-004', 10000, 35, NULL);
INSERT INTO [dbo].[inventory] ([in_id], [in_product_id], [in_warehouse_id], [in_lot], [in_qty], [in_reserved], [in_expiry])
VALUES (5, 5, 3, 'LOT-2026-005', 50, 10, '2027-12-01');
SET IDENTITY_INSERT [dbo].[inventory] OFF;
PRINT 'Seeded 5 inventory records';
GO

PRINT '========== WEBAPP DATABASE SEED COMPLETE ==========';
GO


-- WEBAPPMisc DATABASE
-- =============================================================================
USE [WEBAPPMisc];
GO

-- AcidCorrection reference data
IF NOT EXISTS (SELECT 1 FROM [dbo].[AcidCorrection] WHERE PercentAcid = 0.5)
    INSERT INTO [dbo].[AcidCorrection] (PercentAcid, AcidCorrection) VALUES (0.5, 0.15);
IF NOT EXISTS (SELECT 1 FROM [dbo].[AcidCorrection] WHERE PercentAcid = 1.0)
    INSERT INTO [dbo].[AcidCorrection] (PercentAcid, AcidCorrection) VALUES (1.0, 0.30);
IF NOT EXISTS (SELECT 1 FROM [dbo].[AcidCorrection] WHERE PercentAcid = 1.5)
    INSERT INTO [dbo].[AcidCorrection] (PercentAcid, AcidCorrection) VALUES (1.5, 0.45);
PRINT 'Seeded AcidCorrection reference data';

-- BrixChart reference data
IF NOT EXISTS (SELECT 1 FROM [dbo].[BrixChart] WHERE Brix = 10.0)
    INSERT INTO [dbo].[BrixChart] (RefractiveIndex, Brix, SpecificGravity, LbPerGallon, PoundSolid) VALUES (1.3479, 10.0, 1.0400, 8.67, 0.867);
IF NOT EXISTS (SELECT 1 FROM [dbo].[BrixChart] WHERE Brix = 15.0)
    INSERT INTO [dbo].[BrixChart] (RefractiveIndex, Brix, SpecificGravity, LbPerGallon, PoundSolid) VALUES (1.3557, 15.0, 1.0613, 8.84, 1.327);
IF NOT EXISTS (SELECT 1 FROM [dbo].[BrixChart] WHERE Brix = 20.0)
    INSERT INTO [dbo].[BrixChart] (RefractiveIndex, Brix, SpecificGravity, LbPerGallon, PoundSolid) VALUES (1.3638, 20.0, 1.0833, 9.02, 1.804);
PRINT 'Seeded BrixChart reference data';

-- User Configuration (webapp_dmstech)
PRINT 'Seeding webapp_dmstech (User Warehouse Assignments)...';

DELETE FROM [dbo].[webapp_dmstech] WHERE gs_chr1 IN ('testuser', 'admin', 'warehouse_user');

INSERT INTO [dbo].[webapp_dmstech] (gs_id, gs_type, gs_chr1, gs_chr2, gs_chr3, gs_int1)
VALUES
    (1, 1, 'admin', 'Main Warehouse', 'MAIN', 1),
    (2, 1, 'testuser', 'East Distribution Center', 'EAST', 2),
    (3, 1, 'warehouse_user', 'West Fulfillment', 'WEST', 3);
PRINT 'Inserted 3 test users into webapp_dmstech';

-- Sample webapp_scheduler records
PRINT 'Seeding sample webapp_scheduler records...';

DELETE FROM [dbo].[webapp_scheduler] WHERE gs_ordnum IN (20260301001, 20260301002, 20260301003);

INSERT INTO [dbo].[webapp_scheduler] (
    gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend, gs_dockm,
    gs_company, gs_carrier, gs_driver, gs_notes, gs_status, gs_appid,
    gs_chr1, gs_chr2, gs_chr3, gs_num1
) VALUES
    (1, 20260301001, 'Dock A', '2026-03-01 08:00:00', '2026-03-01 10:00:00', '08:00:00',
     'Acme Corporation', 'FastFreight', 'Driver A', 'Sample WAMS order', 'Scheduled', 'WAMS-001',
     'MAIN', '', '', 0),
    (2, 20260301002, 'Dock B', '2026-03-01 09:00:00', '2026-03-01 11:00:00', '09:00:00',
     'Initech Solutions', 'QuickShip', 'Driver B', 'Sample picking order', 'In Progress', 'PICK-001',
     'EAST', '', '', 0),
    (3, 20260301003, 'Dock A', '2026-03-02 07:00:00', '2026-03-02 09:00:00', '07:00:00',
     'Globex Corp', 'TBD', 'TBD', 'Sample appointment', 'New', 'APPT-001',
     'MAIN', '', '', 0);
PRINT 'Inserted 3 sample webapp_scheduler records';

-- Sample webapp_allocate records
PRINT 'Seeding sample webapp_allocate records...';

DELETE FROM [dbo].[webapp_allocate] WHERE all_ordernum IN (10001, 10002);

INSERT INTO [dbo].[webapp_allocate]
    (all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick, all_date, all_description, all_um, all_status)
VALUES
    (1, 10001, 'WGT-A', 'LOT-2026-001', 10, 10, '2026-03-01', 'Widget A', 'Each', 'Picked'),
    (1, 10001, 'WGT-B', 'LOT-2026-002', 1, 0, '2026-03-01', 'Widget B', 'Each', 'Pending'),
    (2, 10002, 'GDG-P', 'LOT-2026-003', 5, 3, '2026-03-02', 'Gadget Pro', 'Each', 'Partial');
PRINT 'Inserted 3 sample webapp_allocate records';

-- Sample webapp_lock records
PRINT 'Seeding sample webapp_lock records...';

DELETE FROM [dbo].[webapp_lock] WHERE gl_ordnum IN (10002);

INSERT INTO [dbo].[webapp_lock]
    (gl_id, gl_ordnum, gl_partnum, gl_userlot, gl_username, gl_qty1, gl_datel)
VALUES
    (1, 10002, 'GDG-P', 'LOT-2026-003', 'testuser', 5, '2026-03-02 09:15:00');
PRINT 'Inserted 1 sample webapp_lock record';

PRINT '========== WEBAPPMisc DATABASE SEED COMPLETE ==========';
GO
