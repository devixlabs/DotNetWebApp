-- Create schema
CREATE SCHEMA acme;

-- Tables in acme schema
CREATE TABLE acme.Categories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE acme.Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,
    Price DECIMAL(18,2) NULL,
    CategoryId INT NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (CategoryId) REFERENCES acme.Categories(Id)
);

CREATE TABLE acme.Companies (
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

CREATE TABLE acme.CompanyProducts (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CompanyId INT NOT NULL,
    ProductId INT NOT NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (CompanyId) REFERENCES acme.Companies(Id),
    FOREIGN KEY (ProductId) REFERENCES acme.Products(Id)
);
