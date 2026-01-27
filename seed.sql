
INSERT INTO acme.Categories (Name)
SELECT 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM acme.Categories WHERE Name = 'Electronics');

INSERT INTO acme.Categories (Name)
SELECT 'Books'
WHERE NOT EXISTS (SELECT 1 FROM acme.Categories WHERE Name = 'Books');

INSERT INTO acme.Categories (Name)
SELECT 'Outdoor'
WHERE NOT EXISTS (SELECT 1 FROM acme.Categories WHERE Name = 'Outdoor');

INSERT INTO acme.Products (Name, Description, Price, CategoryId)
SELECT
    'Wireless Mouse',
    'Ergonomic Bluetooth mouse',
    29.99,
    (SELECT Id FROM acme.Categories WHERE Name = 'Electronics')
WHERE EXISTS (SELECT 1 FROM acme.Categories WHERE Name = 'Electronics')
  AND NOT EXISTS (SELECT 1 FROM acme.Products WHERE Name = 'Wireless Mouse');

INSERT INTO acme.Products (Name, Description, Price, CategoryId)
SELECT
    'Programming in C#',
    'Updated guide to modern C#',
    49.95,
    (SELECT Id FROM acme.Categories WHERE Name = 'Books')
WHERE EXISTS (SELECT 1 FROM acme.Categories WHERE Name = 'Books')
  AND NOT EXISTS (SELECT 1 FROM acme.Products WHERE Name = 'Programming in C#');

INSERT INTO acme.Products (Name, Description, Price, CategoryId)
SELECT
    'Camping Lantern',
    'Rechargeable LED lantern',
    35.00,
    (SELECT Id FROM acme.Categories WHERE Name = 'Outdoor')
WHERE EXISTS (SELECT 1 FROM acme.Categories WHERE Name = 'Outdoor')
  AND NOT EXISTS (SELECT 1 FROM acme.Products WHERE Name = 'Camping Lantern');

INSERT INTO acme.Companies (Name, Address, City, State, PostalCode, Country, Email, Phone, Website)
SELECT
    'TechCorp Industries',
    '123 Innovation Drive',
    'San Francisco',
    'CA',
    '94105',
    'USA',
    'contact@techcorp.com',
    '(415) 555-0100',
    'www.techcorp.com'
WHERE NOT EXISTS (SELECT 1 FROM acme.Companies WHERE Name = 'TechCorp Industries');

INSERT INTO acme.Companies (Name, Address, City, State, PostalCode, Country, Email, Phone, Website)
SELECT
    'Global Books Publishing',
    '456 Library Lane',
    'New York',
    'NY',
    '10001',
    'USA',
    'info@globalbooks.com',
    '(212) 555-0200',
    'www.globalbooks.com'
WHERE NOT EXISTS (SELECT 1 FROM acme.Companies WHERE Name = 'Global Books Publishing');

INSERT INTO acme.Companies (Name, Address, City, State, PostalCode, Country, Email, Phone, Website)
SELECT
    'Outdoor Adventures Inc',
    '789 Nature Path',
    'Denver',
    'CO',
    '80202',
    'USA',
    'sales@outdooradventures.com',
    '(720) 555-0300',
    'www.outdooradventures.com'
WHERE NOT EXISTS (SELECT 1 FROM acme.Companies WHERE Name = 'Outdoor Adventures Inc');

INSERT INTO acme.CompanyProducts (CompanyId, ProductId)
SELECT
    (SELECT Id FROM acme.Companies WHERE Name = 'TechCorp Industries'),
    (SELECT Id FROM acme.Products WHERE Name = 'Wireless Mouse')
WHERE EXISTS (SELECT 1 FROM acme.Companies WHERE Name = 'TechCorp Industries')
  AND EXISTS (SELECT 1 FROM acme.Products WHERE Name = 'Wireless Mouse')
  AND NOT EXISTS (
    SELECT 1 FROM acme.CompanyProducts
    WHERE CompanyId = (SELECT Id FROM acme.Companies WHERE Name = 'TechCorp Industries')
      AND ProductId = (SELECT Id FROM acme.Products WHERE Name = 'Wireless Mouse')
  );

INSERT INTO acme.CompanyProducts (CompanyId, ProductId)
SELECT
    (SELECT Id FROM acme.Companies WHERE Name = 'Global Books Publishing'),
    (SELECT Id FROM acme.Products WHERE Name = 'Programming in C#')
WHERE EXISTS (SELECT 1 FROM acme.Companies WHERE Name = 'Global Books Publishing')
  AND EXISTS (SELECT 1 FROM acme.Products WHERE Name = 'Programming in C#')
  AND NOT EXISTS (
    SELECT 1 FROM acme.CompanyProducts
    WHERE CompanyId = (SELECT Id FROM acme.Companies WHERE Name = 'Global Books Publishing')
      AND ProductId = (SELECT Id FROM acme.Products WHERE Name = 'Programming in C#')
  );

INSERT INTO acme.CompanyProducts (CompanyId, ProductId)
SELECT
    (SELECT Id FROM acme.Companies WHERE Name = 'Outdoor Adventures Inc'),
    (SELECT Id FROM acme.Products WHERE Name = 'Camping Lantern')
WHERE EXISTS (SELECT 1 FROM acme.Companies WHERE Name = 'Outdoor Adventures Inc')
  AND EXISTS (SELECT 1 FROM acme.Products WHERE Name = 'Camping Lantern')
  AND NOT EXISTS (
    SELECT 1 FROM acme.CompanyProducts
    WHERE CompanyId = (SELECT Id FROM acme.Companies WHERE Name = 'Outdoor Adventures Inc')
      AND ProductId = (SELECT Id FROM acme.Products WHERE Name = 'Camping Lantern')
  );

INSERT INTO acme.CompanyProducts (CompanyId, ProductId)
SELECT
    (SELECT Id FROM acme.Companies WHERE Name = 'TechCorp Industries'),
    (SELECT Id FROM acme.Products WHERE Name = 'Programming in C#')
WHERE EXISTS (SELECT 1 FROM acme.Companies WHERE Name = 'TechCorp Industries')
  AND EXISTS (SELECT 1 FROM acme.Products WHERE Name = 'Programming in C#')
  AND NOT EXISTS (
    SELECT 1 FROM acme.CompanyProducts
    WHERE CompanyId = (SELECT Id FROM acme.Companies WHERE Name = 'TechCorp Industries')
      AND ProductId = (SELECT Id FROM acme.Products WHERE Name = 'Programming in C#')
  );
