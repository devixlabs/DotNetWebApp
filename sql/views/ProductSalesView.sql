-- ProductSalesView.sql
-- Product summary with unit of measure and vendor associations
-- Parameters: @TopN (default: 10)
--
-- Usage from IViewService:
--   await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView", new { TopN = 50 });
--
-- NOTE: This is a demonstration view for the Phase 2B view pipeline.
-- Uses dmprod (products), dmunit (units of measure), and dmvend (vendors)
-- from the schema to show product summary with unit factors and vendor counts.

SELECT TOP (@TopN)
    p.pr_id AS ProductId,
    p.pr_descrip AS ProductName,
    p.pr_lispric AS Price,
    u.un_name AS UnitName,
    COALESCE(u.un_factor, 0) AS UnitFactor,
    COALESCE(COUNT(DISTINCT v.ve_id), 0) AS VendorCount,
    COALESCE(COUNT(DISTINCT v.ve_id) * p.pr_lispric, 0) AS TotalValue
FROM GAI.dmprod p
LEFT JOIN GAI.dmunit u ON p.pr_prunid = u.un_id
LEFT JOIN GAI.dmvend v ON v.ve_id > 0
WHERE p.pr_active = 1
GROUP BY p.pr_id, p.pr_descrip, p.pr_lispric, u.un_name, u.un_factor
ORDER BY TotalValue DESC;
