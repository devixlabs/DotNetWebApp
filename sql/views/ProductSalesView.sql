-- ProductSalesView.sql
-- Product summary with category and company associations
-- Parameters: @TopN (default: 10)
--
-- Usage from IViewService:
--   await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView", new { TopN = 50 });
--
-- NOTE: This is a demonstration view for the Phase 2B view pipeline.
-- Since Orders/OrderDetails tables don't exist in the schema, we show product information
-- with associated companies (via CompanyProducts junction table).

SELECT TOP (@TopN)
    p.Id,
    p.Name,
    p.Price,
    c.Name AS CategoryName,
    COALESCE(COUNT(DISTINCT cp.CompanyId), 0) AS TotalSold,
    COALESCE(COUNT(DISTINCT cp.CompanyId) * p.Price, 0) AS TotalRevenue
FROM acme.Products p
LEFT JOIN acme.Categories c ON p.CategoryId = c.Id
LEFT JOIN acme.CompanyProducts cp ON p.Id = cp.ProductId
GROUP BY p.Id, p.Name, p.Price, c.Name
ORDER BY TotalRevenue DESC;
