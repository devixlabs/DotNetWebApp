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

-- Create initech schema
CREATE SCHEMA initech;

-- Initech schema tables
CREATE TABLE initech.Companies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CompanyName NVARCHAR(200) NOT NULL,
    Industry NVARCHAR(100) NOT NULL,
    HeadquartersCity NVARCHAR(100) NULL,
    HeadquartersState NVARCHAR(50) NULL,
    HeadquartersCountry NVARCHAR(100) NULL,
    EmployeeCount INT NULL,
    AnnualRevenue DECIMAL(15,2) NULL,
    Website NVARCHAR(200) NULL,
    FoundedYear INT NULL,
    StockTicker NVARCHAR(10) NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE()
);

CREATE TABLE initech.Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,
    DateOfBirth DATE NULL,
    Address NVARCHAR(200) NULL,
    City NVARCHAR(100) NULL,
    State NVARCHAR(50) NULL,
    PostalCode NVARCHAR(20) NULL,
    Country NVARCHAR(100) NULL,
    SSN NVARCHAR(20) NULL,
    EmploymentStatus NVARCHAR(50) NULL,
    Citizenship NVARCHAR(100) NULL,
    BackgroundCheckDate DATETIME2 NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME2 NULL DEFAULT GETDATE()
);

CREATE TABLE initech.Employers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CompanyId INT NOT NULL,
    JobTitle NVARCHAR(150) NOT NULL,
    Department NVARCHAR(100) NULL,
    SalaryRangeMin DECIMAL(12,2) NULL,
    SalaryRangeMax DECIMAL(12,2) NULL,
    Description NVARCHAR(500) NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (CompanyId) REFERENCES initech.Companies(Id)
);

CREATE TABLE initech.UserEmployer (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    EmployerId INT NOT NULL,
    StartDate DATE NULL,
    EndDate DATE NULL,
    CurrentlyEmployed BIT NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES initech.Users(Id),
    FOREIGN KEY (EmployerId) REFERENCES initech.Employers(Id)
);

CREATE TABLE initech.CriminalRecords (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    ChargeDescription NVARCHAR(300) NOT NULL,
    ChargeDate DATE NULL,
    ConvictionDate DATE NULL,
    Offense NVARCHAR(150) NULL,
    Severity NVARCHAR(50) NULL,
    Sentence NVARCHAR(200) NULL,
    Status NVARCHAR(50) NULL,
    ArrestingAgency NVARCHAR(200) NULL,
    CourtName NVARCHAR(200) NULL,
    CaseNumber NVARCHAR(50) NULL,
    Notes NVARCHAR(500) NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES initech.Users(Id)
);
