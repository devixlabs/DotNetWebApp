CREATE TABLE Categories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,
    Price DECIMAL(18,2) NULL,
    CategoryId INT NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

CREATE TABLE Companies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(200) NOT NULL,
    Address NVARCHAR(500) NULL,
    City NVARCHAR(100) NULL,
    State NVARCHAR(50) NULL,
    PostalCode NVARCHAR(20) NULL,
    Country NVARCHAR(100) NULL,
    Email NVARCHAR(100) NULL,
    Phone NVARCHAR(20) NULL,
    Website NVARCHAR(200) NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE()
);

CREATE TABLE CompanyProducts (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CompanyId INT NOT NULL,
    ProductId INT NOT NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (CompanyId) REFERENCES Companies(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);
