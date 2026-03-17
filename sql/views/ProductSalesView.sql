-- ProductSalesView.sql
-- Product summary with unit of measure and vendor associations
-- Parameters: @TopN (default: 10)
--
-- Usage from IViewService:
--   await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView", new { TopN = 50 });
--
-- NOTE: This is a demonstration view for the Phase 2B view pipeline.
-- Uses products, units_of_measure, and vendors tables
-- to show product summary with vendor counts.

SELECT TOP (@TopN)
    p.pr_id AS ProductId,
    p.pr_name AS ProductName,
    p.pr_price AS Price,
    p.pr_unit AS UnitName,
    COALESCE(COUNT(DISTINCT v.ve_id), 0) AS VendorCount,
    COALESCE(COUNT(DISTINCT v.ve_id) * p.pr_price, 0) AS TotalValue
FROM dbo.products p
LEFT JOIN dbo.vendors v ON v.ve_active = 1
WHERE p.pr_active = 1
GROUP BY p.pr_id, p.pr_name, p.pr_price, p.pr_unit
ORDER BY TotalValue DESC;
