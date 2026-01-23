
INSERT INTO Categories (Name)
SELECT 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM Categories WHERE Name = 'Electronics');

INSERT INTO Categories (Name)
SELECT 'Books'
WHERE NOT EXISTS (SELECT 1 FROM Categories WHERE Name = 'Books');

INSERT INTO Categories (Name)
SELECT 'Outdoor'
WHERE NOT EXISTS (SELECT 1 FROM Categories WHERE Name = 'Outdoor');

INSERT INTO Products (Name, Description, Price, CategoryId)
SELECT 
    'Wireless Mouse', 
    'Ergonomic Bluetooth mouse', 
    29.99, 
    (SELECT Id FROM Categories WHERE Name = 'Electronics')
WHERE EXISTS (SELECT 1 FROM Categories WHERE Name = 'Electronics')
  AND NOT EXISTS (SELECT 1 FROM Products WHERE Name = 'Wireless Mouse');

INSERT INTO Products (Name, Description, Price, CategoryId)
SELECT 
    'Programming in C#', 
    'Updated guide to modern C#', 
    49.95, 
    (SELECT Id FROM Categories WHERE Name = 'Books')
WHERE EXISTS (SELECT 1 FROM Categories WHERE Name = 'Books')
  AND NOT EXISTS (SELECT 1 FROM Products WHERE Name = 'Programming in C#');

INSERT INTO Products (Name, Description, Price, CategoryId)
SELECT 
    'Camping Lantern', 
    'Rechargeable LED lantern', 
    35.00, 
    (SELECT Id FROM Categories WHERE Name = 'Outdoor')
WHERE EXISTS (SELECT 1 FROM Categories WHERE Name = 'Outdoor')
  AND NOT EXISTS (SELECT 1 FROM Products WHERE Name = 'Camping Lantern');
