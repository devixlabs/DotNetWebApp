-- ProductSalesView.sql
-- Product sales summary with category and order totals
-- Parameters: @TopN (default: 10)
--
-- Usage from IViewService:
--   await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView", new { TopN = 50 });

SELECT
    p.Id,
    p.Name,
    p.Price,
    c.Name AS CategoryName,
    ISNULL(SUM(od.Quantity), 0) AS TotalSold,
    ISNULL(SUM(od.Quantity * p.Price), 0) AS TotalRevenue
FROM acme.Products p
LEFT JOIN acme.Categories c ON p.CategoryId = c.Id
LEFT JOIN acme.OrderDetails od ON p.Id = od.ProductId
GROUP BY p.Id, p.Name, p.Price, c.Name
ORDER BY TotalSold DESC
OFFSET 0 ROWS FETCH NEXT @TopN ROWS ONLY;
