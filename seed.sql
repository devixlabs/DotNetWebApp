
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

-- ============================================================================
-- INITECH SCHEMA SEED DATA
-- ============================================================================

-- Companies (20 records)
INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'Initech Corporation', 'Software Development', 'Austin', 'TX', 'USA', 1500, 250000000.00, 'www.initech.com', 1998, 'INIT'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'Initech Corporation');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'DataFlow Systems', 'Data Analytics', 'Seattle', 'WA', 'USA', 800, 180000000.00, 'www.dataflow.com', 2005, 'DFLW'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'DataFlow Systems');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'CloudVault Inc', 'Cloud Infrastructure', 'San Jose', 'CA', 'USA', 600, 175000000.00, 'www.cloudvault.io', 2010, 'CLVT'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'CloudVault Inc');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'SecureNet Solutions', 'Cybersecurity', 'Boston', 'MA', 'USA', 450, 125000000.00, 'www.securenet.com', 2008, 'SECN'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'SecureNet Solutions');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'InnovateTech Labs', 'Artificial Intelligence', 'San Francisco', 'CA', 'USA', 350, 95000000.00, 'www.innovatetech.ai', 2015, 'INNO'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'InnovateTech Labs');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'FinanceCore LLC', 'Financial Services', 'New York', 'NY', 'USA', 1200, 420000000.00, 'www.financecore.com', 2000, 'FINC'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'FinanceCore LLC');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'MediHealth Group', 'Healthcare Technology', 'Chicago', 'IL', 'USA', 700, 210000000.00, 'www.medihealth.com', 2006, 'MEDH'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'MediHealth Group');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'RetailMax Distribution', 'Retail Operations', 'Atlanta', 'GA', 'USA', 2500, 680000000.00, 'www.retailmax.com', 1995, 'RMAX'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'RetailMax Distribution');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'LogisticsPro Networks', 'Logistics', 'Memphis', 'TN', 'USA', 1100, 320000000.00, 'www.logisticspro.net', 2002, 'LOGI'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'LogisticsPro Networks');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'EnergyTech Solutions', 'Renewable Energy', 'Denver', 'CO', 'USA', 550, 155000000.00, 'www.energytech.com', 2009, 'ENRG'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'EnergyTech Solutions');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'MediaStream Productions', 'Media & Entertainment', 'Los Angeles', 'CA', 'USA', 400, 85000000.00, 'www.mediastream.com', 2012, 'MSTR'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'MediaStream Productions');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'EducationHub Online', 'Education Technology', 'Boston', 'MA', 'USA', 320, 65000000.00, 'www.educationhub.edu', 2014, 'EDUH'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'EducationHub Online');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'RealEstate Digital', 'Real Estate Tech', 'Miami', 'FL', 'USA', 480, 140000000.00, 'www.realestated.com', 2011, 'RELD'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'RealEstate Digital');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'TravelHub Global', 'Travel Technology', 'San Francisco', 'CA', 'USA', 290, 58000000.00, 'www.travelhub.com', 2016, 'TRVL'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'TravelHub Global');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'FoodTech Innovations', 'Food & Beverage', 'Austin', 'TX', 'USA', 380, 78000000.00, 'www.foodtech.com', 2013, 'FOOD'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'FoodTech Innovations');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'AutomotiveX Labs', 'Automotive Technology', 'Detroit', 'MI', 'USA', 920, 285000000.00, 'www.automotivex.com', 2004, 'AUTX'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'AutomotiveX Labs');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'BioPharma Research', 'Pharmaceuticals', 'Cambridge', 'MA', 'USA', 1050, 380000000.00, 'www.biopharma.com', 2001, 'BIOP'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'BioPharma Research');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'ManufacturePlus Solutions', 'Manufacturing', 'Cleveland', 'OH', 'USA', 1800, 425000000.00, 'www.manufacturepplus.com', 1992, 'MNFG'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'ManufacturePlus Solutions');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'TelecommTech Services', 'Telecommunications', 'Dallas', 'TX', 'USA', 2200, 595000000.00, 'www.telecommtech.com', 1999, 'TCOM'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'TelecommTech Services');

INSERT INTO initech.Companies (CompanyName, Industry, HeadquartersCity, HeadquartersState, HeadquartersCountry, EmployeeCount, AnnualRevenue, Website, FoundedYear, StockTicker)
SELECT 'ConsultantsPro Group', 'Business Consulting', 'New York', 'NY', 'USA', 650, 195000000.00, 'www.consultantspro.com', 2007, 'CPRO'
WHERE NOT EXISTS (SELECT 1 FROM initech.Companies WHERE CompanyName = 'ConsultantsPro Group');

-- Users (75 records)
INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Michael', 'Johnson', 'mjohnson@initech.com', '512-555-0101', '1980-03-15', '101 Tech Way', 'Austin', 'TX', '78701', 'USA', '123-45-6789', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'mjohnson@initech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Sarah', 'Williams', 'swilliams@dataflow.com', '206-555-0102', '1985-07-22', '202 Data St', 'Seattle', 'WA', '98101', 'USA', '987-65-4321', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'swilliams@dataflow.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'James', 'Brown', 'jbrown@cloudvault.io', '408-555-0103', '1978-11-08', '303 Cloud Ave', 'San Jose', 'CA', '95110', 'USA', '456-78-9012', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'jbrown@cloudvault.io');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Emily', 'Davis', 'edavis@securenet.com', '617-555-0104', '1992-05-30', '404 Security Ln', 'Boston', 'MA', '02101', 'USA', '234-56-7890', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'edavis@securenet.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'David', 'Miller', 'dmiller@innovatetech.ai', '415-555-0105', '1988-09-14', '505 AI Blvd', 'San Francisco', 'CA', '94103', 'USA', '345-67-8901', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'dmiller@innovatetech.ai');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Jessica', 'Wilson', 'jwilson@financecore.com', '212-555-0106', '1982-01-25', '606 Finance Dr', 'New York', 'NY', '10001', 'USA', '567-89-0123', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'jwilson@financecore.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Robert', 'Moore', 'rmoore@medihealth.com', '312-555-0107', '1979-04-11', '707 Health Way', 'Chicago', 'IL', '60601', 'USA', '678-90-1234', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'rmoore@medihealth.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Lisa', 'Taylor', 'ltaylor@retailmax.com', '404-555-0108', '1991-08-19', '808 Retail St', 'Atlanta', 'GA', '30303', 'USA', '789-01-2345', 'Inactive', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'ltaylor@retailmax.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Christopher', 'Anderson', 'canderson@logisticspro.net', '901-555-0109', '1986-12-03', '909 Logistics Ln', 'Memphis', 'TN', '38103', 'USA', '890-12-3456', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'canderson@logisticspro.net');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Jennifer', 'Thomas', 'jthomas@energytech.com', '303-555-0110', '1989-06-27', '1010 Energy Ave', 'Denver', 'CO', '80202', 'USA', '901-23-4567', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'jthomas@energytech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Daniel', 'Jackson', 'djackson@mediastream.com', '323-555-0111', '1984-10-09', '1111 Media Blvd', 'Los Angeles', 'CA', '90001', 'USA', '012-34-5678', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'djackson@mediastream.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Amanda', 'White', 'awhite@educationhub.edu', '617-555-0112', '1993-02-14', '1212 Education Dr', 'Boston', 'MA', '02115', 'USA', '123-45-6701', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'awhite@educationhub.edu');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Matthew', 'Harris', 'mharris@realestated.com', '305-555-0113', '1981-07-20', '1313 Real Estate Ln', 'Miami', 'FL', '33101', 'USA', '234-56-7802', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'mharris@realestated.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Nicole', 'Martin', 'nmartin@travelhub.com', '415-555-0114', '1995-03-05', '1414 Travel St', 'San Francisco', 'CA', '94111', 'USA', '345-67-8903', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'nmartin@travelhub.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Kevin', 'Garcia', 'kgarcia@foodtech.com', '512-555-0115', '1987-11-18', '1515 Food Ave', 'Austin', 'TX', '78704', 'USA', '456-78-9004', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'kgarcia@foodtech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Rachel', 'Rodriguez', 'rrodriguez@automotivex.com', '313-555-0116', '1990-09-25', '1616 Auto Way', 'Detroit', 'MI', '48201', 'USA', '567-89-0105', 'Retired', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'rrodriguez@automotivex.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Steven', 'Martinez', 'smartinez@biopharma.com', '617-555-0117', '1983-05-12', '1717 BioTech Blvd', 'Cambridge', 'MA', '02138', 'USA', '678-90-1206', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'smartinez@biopharma.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Ashley', 'Lopez', 'alopez@manufacturepplus.com', '216-555-0118', '1994-01-08', '1818 Manufacturing Dr', 'Cleveland', 'OH', '44101', 'USA', '789-01-2307', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'alopez@manufacturepplus.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Brandon', 'Gonzalez', 'bgonzalez@telecommtech.com', '214-555-0119', '1986-08-30', '1919 Telecom Ln', 'Dallas', 'TX', '75201', 'USA', '890-12-3408', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'bgonzalez@telecommtech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Megan', 'Wilson', 'mwilson@consultantspro.com', '212-555-0120', '1988-04-16', '2020 Consulting St', 'New York', 'NY', '10010', 'USA', '901-23-4509', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'mwilson@consultantspro.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Eric', 'Lee', 'elee@initech.com', '512-555-0121', '1981-06-22', '2121 Tech Drive', 'Austin', 'TX', '78702', 'USA', '012-34-5680', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'elee@initech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Sophia', 'Chen', 'schen@dataflow.com', '206-555-0122', '1992-09-11', '2222 Data Center', 'Seattle', 'WA', '98102', 'USA', '123-45-6791', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'schen@dataflow.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Andrew', 'Kim', 'akim@cloudvault.io', '408-555-0123', '1979-12-28', '2323 Cloud Park', 'San Jose', 'CA', '95111', 'USA', '234-56-7892', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'akim@cloudvault.io');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Olivia', 'Patel', 'opatel@securenet.com', '617-555-0124', '1993-03-17', '2424 Security Plaza', 'Boston', 'MA', '02102', 'USA', '345-67-8993', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'opatel@securenet.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Justin', 'Singh', 'jsingh@innovatetech.ai', '415-555-0125', '1989-07-06', '2525 AI Park', 'San Francisco', 'CA', '94104', 'USA', '456-78-9094', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'jsingh@innovatetech.ai');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Isabella', 'Kumar', 'ikumar@financecore.com', '212-555-0126', '1985-11-13', '2626 Finance Tower', 'New York', 'NY', '10002', 'USA', '567-89-0195', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'ikumar@financecore.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'William', 'Huang', 'whuang@medihealth.com', '312-555-0127', '1980-08-25', '2727 Healthcare Blvd', 'Chicago', 'IL', '60602', 'USA', '678-90-1296', 'Inactive', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'whuang@medihealth.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Ava', 'Jackson', 'ajackson@retailmax.com', '404-555-0128', '1994-05-31', '2828 Retail Center', 'Atlanta', 'GA', '30304', 'USA', '789-01-2397', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'ajackson@retailmax.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Ryan', 'Martinez', 'rmartinez@logisticspro.net', '901-555-0129', '1987-02-09', '2929 Logistics Hub', 'Memphis', 'TN', '38104', 'USA', '890-12-3498', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'rmartinez@logisticspro.net');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Emma', 'Garcia', 'egarcia@energytech.com', '303-555-0130', '1991-10-21', '3030 Energy Center', 'Denver', 'CO', '80203', 'USA', '901-23-4599', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'egarcia@energytech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Jason', 'Rodriguez', 'jrodriguez@mediastream.com', '323-555-0131', '1986-04-14', '3131 Media Complex', 'Los Angeles', 'CA', '90002', 'USA', '012-34-5670', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'jrodriguez@mediastream.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Sophia', 'Lopez', 'slopez@educationhub.edu', '617-555-0132', '1996-01-19', '3232 Education Center', 'Boston', 'MA', '02116', 'USA', '123-45-6681', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'slopez@educationhub.edu');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Mark', 'Gonzalez', 'mgonzalez@realestated.com', '305-555-0133', '1982-09-07', '3333 Realty Drive', 'Miami', 'FL', '33102', 'USA', '234-56-7782', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'mgonzalez@realestated.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Grace', 'Wilson', 'gwilson@travelhub.com', '415-555-0134', '1997-06-24', '3434 Travel Center', 'San Francisco', 'CA', '94112', 'USA', '345-67-8883', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'gwilson@travelhub.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Tyler', 'Lee', 'tlee@foodtech.com', '512-555-0135', '1988-03-03', '3535 Food Court', 'Austin', 'TX', '78705', 'USA', '456-78-8984', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'tlee@foodtech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Charlotte', 'Harris', 'charris@automotivex.com', '313-555-0136', '1992-11-11', '3636 Auto Plaza', 'Detroit', 'MI', '48202', 'USA', '567-89-0085', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'charris@automotivex.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Nathan', 'Martin', 'nmartin@biopharma.com', '617-555-0137', '1984-07-29', '3737 Pharma Park', 'Cambridge', 'MA', '02139', 'USA', '678-90-1186', 'Retired', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'nmartin@biopharma.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Amelia', 'Anderson', 'aanderson@manufacturepplus.com', '216-555-0138', '1995-12-15', '3838 Manufacturing Zone', 'Cleveland', 'OH', '44102', 'USA', '789-01-2287', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'aanderson@manufacturepplus.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Jacob', 'Thomas', 'jthomas@telecommtech.com', '214-555-0139', '1987-10-02', '3939 Telecom Hub', 'Dallas', 'TX', '75202', 'USA', '890-12-3388', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'jthomas@telecommtech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Avery', 'Jackson', 'ajackson@consultantspro.com', '212-555-0140', '1989-05-20', '4040 Consulting Hub', 'New York', 'NY', '10011', 'USA', '901-23-4489', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'ajackson@consultantspro.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Ethan', 'White', 'ewhite@initech.com', '512-555-0141', '1983-09-08', '4141 Tech Complex', 'Austin', 'TX', '78703', 'USA', '012-34-5580', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'ewhite@initech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Madison', 'Brown', 'mbrown@dataflow.com', '206-555-0142', '1994-04-26', '4242 Data Hub', 'Seattle', 'WA', '98103', 'USA', '123-45-6691', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'mbrown@dataflow.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Logan', 'Davis', 'ldavis@cloudvault.io', '408-555-0143', '1980-08-16', '4343 Cloud Zone', 'San Jose', 'CA', '95112', 'USA', '234-56-7792', 'Inactive', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'ldavis@cloudvault.io');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Harper', 'Miller', 'hmiller@securenet.com', '617-555-0144', '1991-02-22', '4444 Security Hub', 'Boston', 'MA', '02103', 'USA', '345-67-8893', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'hmiller@securenet.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Mason', 'Wilson', 'mwilson@innovatetech.ai', '415-555-0145', '1986-01-10', '4545 AI Center', 'San Francisco', 'CA', '94105', 'USA', '456-78-9894', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'mwilson@innovatetech.ai');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Evelyn', 'Moore', 'emoore@financecore.com', '212-555-0146', '1988-06-18', '4646 Finance Hub', 'New York', 'NY', '10003', 'USA', '567-89-0995', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'emoore@financecore.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Lucas', 'Taylor', 'ltaylor@medihealth.com', '312-555-0147', '1982-12-05', '4747 Health Center', 'Chicago', 'IL', '60603', 'USA', '678-90-1096', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'ltaylor@medihealth.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Abigail', 'Anderson', 'aanderson@retailmax.com', '404-555-0148', '1996-07-30', '4848 Retail Hub', 'Atlanta', 'GA', '30305', 'USA', '789-01-2197', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'aanderson@retailmax.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Benjamin', 'Thomas', 'bthomas@logisticspro.net', '901-555-0149', '1985-03-14', '4949 Logistics Center', 'Memphis', 'TN', '38105', 'USA', '890-12-3298', 'Retired', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'bthomas@logisticspro.net');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Elizabeth', 'Jackson', 'ejackson@energytech.com', '303-555-0150', '1993-11-02', '5050 Energy Hub', 'Denver', 'CO', '80204', 'USA', '901-23-4399', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'ejackson@energytech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Alexander', 'White', 'awhite@mediastream.com', '323-555-0151', '1987-01-24', '5151 Media Hub', 'Los Angeles', 'CA', '90003', 'USA', '012-34-5570', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'awhite@mediastream.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Mia', 'Harris', 'mharris@educationhub.edu', '617-555-0152', '1998-08-19', '5252 Education Hub', 'Boston', 'MA', '02117', 'USA', '123-45-6671', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'mharris@educationhub.edu');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Daniel', 'Brown', 'dbrown@realestated.com', '305-555-0153', '1981-04-07', '5353 Realty Hub', 'Miami', 'FL', '33103', 'USA', '234-56-7772', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'dbrown@realestated.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Charlotte', 'Davis', 'cdavis@travelhub.com', '415-555-0154', '1997-10-12', '5454 Travel Hub', 'San Francisco', 'CA', '94113', 'USA', '345-67-8873', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'cdavis@travelhub.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Samuel', 'Miller', 'smiller@foodtech.com', '512-555-0155', '1989-02-28', '5555 Food Hub', 'Austin', 'TX', '78706', 'USA', '456-78-8974', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'smiller@foodtech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Amelia', 'Wilson', 'awilson@automotivex.com', '313-555-0156', '1990-09-06', '5656 Auto Hub', 'Detroit', 'MI', '48203', 'USA', '567-89-0075', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'awilson@automotivex.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Joseph', 'Garcia', 'jgarcia@biopharma.com', '617-555-0157', '1986-03-16', '5757 Biotech Hub', 'Cambridge', 'MA', '02140', 'USA', '678-90-1176', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'jgarcia@biopharma.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Harper', 'Rodriguez', 'hrodriguez@manufacturepplus.com', '216-555-0158', '1994-06-23', '5858 Mfg Hub', 'Cleveland', 'OH', '44103', 'USA', '789-01-2277', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'hrodriguez@manufacturepplus.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Michael', 'Lee', 'mlee@telecommtech.com', '214-555-0159', '1988-11-11', '5959 Telecom Center', 'Dallas', 'TX', '75203', 'USA', '890-12-3378', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'mlee@telecommtech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Evelyn', 'Chen', 'echen@consultantspro.com', '212-555-0160', '1985-07-09', '6060 Consulting Center', 'New York', 'NY', '10012', 'USA', '901-23-4479', 'Inactive', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'echen@consultantspro.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'David', 'Patel', 'dpatel@initech.com', '512-555-0161', '1984-12-20', '6161 Tech Hub', 'Austin', 'TX', '78704', 'USA', '012-34-5670', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'dpatel@initech.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'Sophia', 'Kumar', 'skumar@dataflow.com', '206-555-0162', '1995-05-15', '6262 Data Hub', 'Seattle', 'WA', '98104', 'USA', '123-45-6681', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'skumar@dataflow.com');

INSERT INTO initech.Users (FirstName, LastName, Email, PhoneNumber, DateOfBirth, Address, City, State, PostalCode, Country, SSN, EmploymentStatus, Citizenship)
SELECT 'William', 'Huang', 'whuang@cloudvault.io', '408-555-0163', '1979-10-01', '6363 Cloud Hub', 'San Jose', 'CA', '95113', 'USA', '234-56-7782', 'Active', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM initech.Users WHERE Email = 'whuang@cloudvault.io');

-- Employers (60 records - ~3 per company)
INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'Initech Corporation'), 'Senior Software Engineer', 'Engineering', 120000.00, 160000.00, 'Lead development of core platform features'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Senior Software Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'Initech Corporation'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'Initech Corporation'), 'Product Manager', 'Product', 110000.00, 150000.00, 'Manage product roadmap and releases'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Product Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'Initech Corporation'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'Initech Corporation'), 'QA Engineer', 'Quality Assurance', 80000.00, 120000.00, 'Test and validate software quality'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'QA Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'Initech Corporation'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'DataFlow Systems'), 'Data Scientist', 'Analytics', 130000.00, 170000.00, 'Build machine learning models and analysis pipelines'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Data Scientist' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'DataFlow Systems'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'DataFlow Systems'), 'Data Engineer', 'Analytics', 115000.00, 155000.00, 'Design data warehouse and ETL pipelines'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Data Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'DataFlow Systems'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'DataFlow Systems'), 'Business Analyst', 'Business', 85000.00, 125000.00, 'Analyze business requirements and metrics'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Business Analyst' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'DataFlow Systems'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'CloudVault Inc'), 'Cloud Architect', 'Infrastructure', 140000.00, 180000.00, 'Design cloud infrastructure and solutions'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Cloud Architect' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'CloudVault Inc'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'CloudVault Inc'), 'DevOps Engineer', 'Infrastructure', 110000.00, 150000.00, 'Manage deployment and infrastructure automation'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'DevOps Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'CloudVault Inc'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'CloudVault Inc'), 'Support Engineer', 'Support', 70000.00, 100000.00, 'Provide technical customer support'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Support Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'CloudVault Inc'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'SecureNet Solutions'), 'Security Engineer', 'Security', 130000.00, 170000.00, 'Design and implement security measures'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Security Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'SecureNet Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'SecureNet Solutions'), 'Penetration Tester', 'Security', 120000.00, 160000.00, 'Identify security vulnerabilities'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Penetration Tester' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'SecureNet Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'SecureNet Solutions'), 'Security Analyst', 'Security', 90000.00, 130000.00, 'Monitor and analyze security threats'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Security Analyst' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'SecureNet Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'InnovateTech Labs'), 'Machine Learning Engineer', 'AI Research', 135000.00, 175000.00, 'Develop AI and ML solutions'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Machine Learning Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'InnovateTech Labs'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'InnovateTech Labs'), 'AI Researcher', 'AI Research', 125000.00, 165000.00, 'Research advanced AI methodologies'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'AI Researcher' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'InnovateTech Labs'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'InnovateTech Labs'), 'Junior AI Developer', 'AI Research', 80000.00, 110000.00, 'Support AI development projects'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Junior AI Developer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'InnovateTech Labs'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'FinanceCore LLC'), 'Senior Analyst', 'Finance', 130000.00, 170000.00, 'Lead financial analysis and planning'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Senior Analyst' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'FinanceCore LLC'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'FinanceCore LLC'), 'Risk Manager', 'Risk Management', 115000.00, 155000.00, 'Manage financial risk and compliance'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Risk Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'FinanceCore LLC'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'FinanceCore LLC'), 'Trader', 'Trading', 100000.00, 250000.00, 'Execute trading strategies'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Trader' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'FinanceCore LLC'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediHealth Group'), 'Clinical Data Manager', 'Clinical', 100000.00, 140000.00, 'Manage clinical trial data'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Clinical Data Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediHealth Group'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediHealth Group'), 'Compliance Officer', 'Compliance', 105000.00, 145000.00, 'Ensure regulatory compliance'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Compliance Officer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediHealth Group'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediHealth Group'), 'IT Support Specialist', 'IT', 65000.00, 95000.00, 'Provide IT support services'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'IT Support Specialist' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediHealth Group'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'RetailMax Distribution'), 'Store Manager', 'Retail', 70000.00, 100000.00, 'Manage retail operations'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Store Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'RetailMax Distribution'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'RetailMax Distribution'), 'Inventory Manager', 'Logistics', 85000.00, 125000.00, 'Manage inventory levels'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Inventory Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'RetailMax Distribution'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'RetailMax Distribution'), 'District Manager', 'Management', 95000.00, 140000.00, 'Oversee multiple store locations'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'District Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'RetailMax Distribution'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'LogisticsPro Networks'), 'Logistics Coordinator', 'Operations', 75000.00, 110000.00, 'Coordinate logistics operations'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Logistics Coordinator' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'LogisticsPro Networks'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'LogisticsPro Networks'), 'Route Planner', 'Operations', 80000.00, 120000.00, 'Plan efficient delivery routes'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Route Planner' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'LogisticsPro Networks'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'LogisticsPro Networks'), 'Warehouse Manager', 'Warehouse', 85000.00, 125000.00, 'Manage warehouse operations'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Warehouse Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'LogisticsPro Networks'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'EnergyTech Solutions'), 'Energy Analyst', 'Analytics', 100000.00, 140000.00, 'Analyze energy consumption patterns'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Energy Analyst' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'EnergyTech Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'EnergyTech Solutions'), 'Project Manager', 'Projects', 110000.00, 150000.00, 'Manage renewable energy projects'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Project Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'EnergyTech Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'EnergyTech Solutions'), 'Installation Technician', 'Field', 65000.00, 95000.00, 'Install energy systems'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Installation Technician' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'EnergyTech Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediaStream Productions'), 'Content Creator', 'Content', 75000.00, 110000.00, 'Create digital media content'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Content Creator' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediaStream Productions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediaStream Productions'), 'Video Producer', 'Production', 85000.00, 125000.00, 'Produce video content'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Video Producer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediaStream Productions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediaStream Productions'), 'Editor', 'Post-Production', 70000.00, 105000.00, 'Edit video and audio content'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Editor' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'MediaStream Productions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'EducationHub Online'), 'Course Developer', 'Development', 85000.00, 125000.00, 'Develop online courses'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Course Developer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'EducationHub Online'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'EducationHub Online'), 'Instructional Designer', 'Design', 90000.00, 130000.00, 'Design learning experiences'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Instructional Designer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'EducationHub Online'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'EducationHub Online'), 'Instructor', 'Teaching', 65000.00, 95000.00, 'Teach online courses'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Instructor' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'EducationHub Online'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'RealEstate Digital'), 'Real Estate Agent', 'Sales', 70000.00, 150000.00, 'Sell real estate properties'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Real Estate Agent' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'RealEstate Digital'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'RealEstate Digital'), 'Property Manager', 'Management', 80000.00, 120000.00, 'Manage properties'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Property Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'RealEstate Digital'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'RealEstate Digital'), 'Market Analyst', 'Research', 85000.00, 125000.00, 'Analyze real estate markets'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Market Analyst' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'RealEstate Digital'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'TravelHub Global'), 'Travel Agent', 'Sales', 60000.00, 90000.00, 'Book travel arrangements'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Travel Agent' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'TravelHub Global'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'TravelHub Global'), 'Tour Operator', 'Operations', 70000.00, 105000.00, 'Manage tour operations'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Tour Operator' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'TravelHub Global'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'TravelHub Global'), 'Reservations Manager', 'Customer Service', 65000.00, 95000.00, 'Manage reservations'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Reservations Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'TravelHub Global'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'FoodTech Innovations'), 'Chef', 'Culinary', 70000.00, 105000.00, 'Create culinary innovations'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Chef' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'FoodTech Innovations'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'FoodTech Innovations'), 'Food Safety Manager', 'Quality', 80000.00, 120000.00, 'Ensure food safety compliance'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Food Safety Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'FoodTech Innovations'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'FoodTech Innovations'), 'Supply Chain Manager', 'Operations', 85000.00, 125000.00, 'Manage food supply chain'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Supply Chain Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'FoodTech Innovations'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'AutomotiveX Labs'), 'Mechanical Engineer', 'Engineering', 105000.00, 145000.00, 'Design automotive components'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Mechanical Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'AutomotiveX Labs'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'AutomotiveX Labs'), 'Software Engineer', 'Software', 110000.00, 150000.00, 'Develop automotive software'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Software Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'AutomotiveX Labs'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'AutomotiveX Labs'), 'Test Engineer', 'Quality', 90000.00, 130000.00, 'Test automotive systems'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Test Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'AutomotiveX Labs'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'BioPharma Research'), 'Research Scientist', 'Research', 120000.00, 160000.00, 'Conduct pharmaceutical research'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Research Scientist' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'BioPharma Research'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'BioPharma Research'), 'Regulatory Affairs Specialist', 'Regulatory', 100000.00, 140000.00, 'Handle regulatory submissions'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Regulatory Affairs Specialist' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'BioPharma Research'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'BioPharma Research'), 'Clinical Trials Manager', 'Clinical', 110000.00, 150000.00, 'Manage clinical trial programs'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Clinical Trials Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'BioPharma Research'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'ManufacturePlus Solutions'), 'Plant Manager', 'Operations', 115000.00, 155000.00, 'Manage manufacturing facility'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Plant Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'ManufacturePlus Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'ManufacturePlus Solutions'), 'Process Engineer', 'Engineering', 100000.00, 140000.00, 'Optimize manufacturing processes'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Process Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'ManufacturePlus Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'ManufacturePlus Solutions'), 'Maintenance Supervisor', 'Maintenance', 85000.00, 125000.00, 'Supervise equipment maintenance'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Maintenance Supervisor' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'ManufacturePlus Solutions'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'TelecommTech Services'), 'Network Engineer', 'Infrastructure', 110000.00, 150000.00, 'Design telecom networks'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Network Engineer' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'TelecommTech Services'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'TelecommTech Services'), 'Customer Service Manager', 'Customer Service', 95000.00, 135000.00, 'Manage customer service operations'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Customer Service Manager' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'TelecommTech Services'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'TelecommTech Services'), 'Solutions Architect', 'Solutions', 120000.00, 160000.00, 'Design telecom solutions'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Solutions Architect' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'TelecommTech Services'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'ConsultantsPro Group'), 'Senior Consultant', 'Consulting', 130000.00, 170000.00, 'Lead consulting engagements'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Senior Consultant' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'ConsultantsPro Group'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'ConsultantsPro Group'), 'Management Consultant', 'Consulting', 110000.00, 150000.00, 'Provide management consulting'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Management Consultant' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'ConsultantsPro Group'));

INSERT INTO initech.Employers (CompanyId, JobTitle, Department, SalaryRangeMin, SalaryRangeMax, Description)
SELECT (SELECT Id FROM initech.Companies WHERE CompanyName = 'ConsultantsPro Group'), 'Associate Consultant', 'Consulting', 75000.00, 110000.00, 'Support consulting projects'
WHERE NOT EXISTS (SELECT 1 FROM initech.Employers WHERE JobTitle = 'Associate Consultant' AND CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'ConsultantsPro Group'));

-- UserEmployer (90 many-to-many relationships)
-- This creates a many-to-many relationship between users and employers
INSERT INTO initech.UserEmployers (UserId, EmployerId, StartDate, EndDate, CurrentlyEmployed)
SELECT u.Id, e.Id, DATEADD(YEAR, -3, CAST(GETDATE() AS DATE)), NULL, 1
FROM (SELECT Id FROM initech.Users ORDER BY Id OFFSET 0 ROWS FETCH NEXT 15 ROWS ONLY) u
CROSS JOIN (SELECT TOP 6 Id FROM initech.Employers WHERE CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'Initech Corporation')) e
WHERE NOT EXISTS (
  SELECT 1 FROM initech.UserEmployers
  WHERE UserId = u.Id AND EmployerId = e.Id
);

INSERT INTO initech.UserEmployers (UserId, EmployerId, StartDate, EndDate, CurrentlyEmployed)
SELECT u.Id, e.Id, DATEADD(YEAR, -2, CAST(GETDATE() AS DATE)), NULL, 1
FROM (SELECT Id FROM initech.Users ORDER BY Id OFFSET 15 ROWS FETCH NEXT 12 ROWS ONLY) u
CROSS JOIN (SELECT TOP 6 Id FROM initech.Employers WHERE CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'DataFlow Systems')) e
WHERE NOT EXISTS (
  SELECT 1 FROM initech.UserEmployers
  WHERE UserId = u.Id AND EmployerId = e.Id
);

INSERT INTO initech.UserEmployers (UserId, EmployerId, StartDate, EndDate, CurrentlyEmployed)
SELECT u.Id, e.Id, DATEADD(YEAR, -1, CAST(GETDATE() AS DATE)), NULL, 1
FROM (SELECT Id FROM initech.Users ORDER BY Id OFFSET 27 ROWS FETCH NEXT 12 ROWS ONLY) u
CROSS JOIN (SELECT TOP 6 Id FROM initech.Employers WHERE CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'CloudVault Inc')) e
WHERE NOT EXISTS (
  SELECT 1 FROM initech.UserEmployers
  WHERE UserId = u.Id AND EmployerId = e.Id
);

INSERT INTO initech.UserEmployers (UserId, EmployerId, StartDate, EndDate, CurrentlyEmployed)
SELECT u.Id, e.Id, DATEADD(YEAR, -4, CAST(GETDATE() AS DATE)), DATEADD(YEAR, -1, CAST(GETDATE() AS DATE)), 0
FROM (SELECT Id FROM initech.Users ORDER BY Id OFFSET 39 ROWS FETCH NEXT 12 ROWS ONLY) u
CROSS JOIN (SELECT TOP 6 Id FROM initech.Employers WHERE CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'SecureNet Solutions')) e
WHERE NOT EXISTS (
  SELECT 1 FROM initech.UserEmployers
  WHERE UserId = u.Id AND EmployerId = e.Id
);

INSERT INTO initech.UserEmployers (UserId, EmployerId, StartDate, EndDate, CurrentlyEmployed)
SELECT u.Id, e.Id, DATEADD(YEAR, -5, CAST(GETDATE() AS DATE)), DATEADD(YEAR, -2, CAST(GETDATE() AS DATE)), 0
FROM (SELECT Id FROM initech.Users ORDER BY Id OFFSET 51 ROWS FETCH NEXT 12 ROWS ONLY) u
CROSS JOIN (SELECT TOP 6 Id FROM initech.Employers WHERE CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'InnovateTech Labs')) e
WHERE NOT EXISTS (
  SELECT 1 FROM initech.UserEmployers
  WHERE UserId = u.Id AND EmployerId = e.Id
);

INSERT INTO initech.UserEmployers (UserId, EmployerId, StartDate, EndDate, CurrentlyEmployed)
SELECT u.Id, e.Id, DATEADD(YEAR, -2, CAST(GETDATE() AS DATE)), NULL, 1
FROM (SELECT Id FROM initech.Users ORDER BY Id OFFSET 63 ROWS FETCH NEXT 14 ROWS ONLY) u
CROSS JOIN (SELECT TOP 6 Id FROM initech.Employers WHERE CompanyId = (SELECT Id FROM initech.Companies WHERE CompanyName = 'FinanceCore LLC')) e
WHERE NOT EXISTS (
  SELECT 1 FROM initech.UserEmployers
  WHERE UserId = u.Id AND EmployerId = e.Id
);

-- CriminalRecords (35 records - some users have multiple records)
INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'ltaylor@retailmax.com'), 'Shoplifting', '2018-05-15', '2018-08-20', 'Theft', 'Misdemeanor', 'Probation 1 year', 'Convicted', 'Atlanta PD', 'Fulton County Court', '2018-06789'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'ltaylor@retailmax.com') AND ChargeDescription = 'Shoplifting');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'whuang@medihealth.com'), 'Drug Possession', '2019-03-10', '2019-07-15', 'Drug Offense', 'Felony', '2 years incarceration', 'Convicted', 'Chicago PD', 'Cook County Court', '2019-12345'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'whuang@medihealth.com') AND ChargeDescription = 'Drug Possession');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'ldavis@cloudvault.io'), 'Assault', '2017-11-22', '2018-02-10', 'Assault', 'Misdemeanor', 'Anger management, 6 months probation', 'Convicted', 'San Jose PD', 'Santa Clara County Court', '2017-54321'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'ldavis@cloudvault.io') AND ChargeDescription = 'Assault');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'rrodriguez@automotivex.com'), 'DUI', '2016-09-30', '2016-12-12', 'Driving Under Influence', 'Misdemeanor', 'License suspension, $1500 fine', 'Convicted', 'Detroit PD', 'Wayne County Court', '2016-98765'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'rrodriguez@automotivex.com') AND ChargeDescription = 'DUI');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'nmartin@biopharma.com'), 'Fraud', '2015-04-18', '2016-01-20', 'Financial Fraud', 'Felony', '3 years incarceration', 'Convicted', 'Cambridge PD', 'Middlesex County Court', '2015-11111'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'nmartin@biopharma.com') AND ChargeDescription = 'Fraud');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'bthomas@logisticspro.net'), 'Burglary', '2014-07-25', '2014-11-15', 'Burglary', 'Felony', '5 years incarceration', 'Convicted', 'Memphis PD', 'Shelby County Court', '2014-22222'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'bthomas@logisticspro.net') AND ChargeDescription = 'Burglary');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'echen@consultantspro.com'), 'Disorderly Conduct', '2020-01-12', NULL, 'Disorderly Conduct', 'Misdemeanor', 'Pending trial', 'Pending', 'New York PD', 'Manhattan Criminal Court', '2020-33333'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'echen@consultantspro.com') AND ChargeDescription = 'Disorderly Conduct');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'rrodriguez@automotivex.com'), 'Traffic Violation', '2018-06-05', '2018-08-10', 'Reckless Driving', 'Misdemeanor', 'Driving school, $750 fine', 'Convicted', 'Detroit PD', 'Wayne County Court', '2018-44444'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'rrodriguez@automotivex.com') AND ChargeDescription = 'Traffic Violation');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'mjohnson@initech.com'), 'Simple Assault', '2021-02-14', '2021-05-20', 'Assault', 'Misdemeanor', 'Anger management course', 'Convicted', 'Austin PD', 'Travis County Court', '2021-55555'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'mjohnson@initech.com') AND ChargeDescription = 'Simple Assault');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'swilliams@dataflow.com'), 'Trespassing', '2019-08-18', '2019-10-25', 'Trespassing', 'Misdemeanor', 'Trespassing charge dismissed', 'Acquitted', 'Seattle PD', 'King County Court', '2019-66666'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'swilliams@dataflow.com') AND ChargeDescription = 'Trespassing');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'jbrown@cloudvault.io'), 'Vandalism', '2017-12-08', '2018-03-15', 'Property Damage', 'Misdemeanor', 'Restitution $2000, 6 months probation', 'Convicted', 'San Jose PD', 'Santa Clara County Court', '2017-77777'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'jbrown@cloudvault.io') AND ChargeDescription = 'Vandalism');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'edavis@securenet.com'), 'Identity Theft', '2020-06-22', '2021-01-10', 'Identity Theft', 'Felony', '2 years incarceration', 'Convicted', 'Boston PD', 'Suffolk County Court', '2020-88888'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'edavis@securenet.com') AND ChargeDescription = 'Identity Theft');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'dmiller@innovatetech.ai'), 'Forgery', '2016-05-30', '2016-09-20', 'Forgery', 'Felony', '18 months incarceration', 'Convicted', 'San Francisco PD', 'San Francisco Superior Court', '2016-99999'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'dmiller@innovatetech.ai') AND ChargeDescription = 'Forgery');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'jwilson@financecore.com'), 'Money Laundering', '2013-11-15', '2014-06-20', 'Money Laundering', 'Felony', '4 years incarceration', 'Convicted', 'New York PD', 'Federal Court SDNY', '2013-00001'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'jwilson@financecore.com') AND ChargeDescription = 'Money Laundering');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'rmoore@medihealth.com'), 'Embezzlement', '2015-03-25', '2015-09-10', 'Embezzlement', 'Felony', '3 years incarceration, restitution $50000', 'Convicted', 'Chicago PD', 'Cook County Court', '2015-00002'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'rmoore@medihealth.com') AND ChargeDescription = 'Embezzlement');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'ltaylor@retailmax.com'), 'Theft from Employer', '2016-10-12', '2017-01-18', 'Theft', 'Felony', '1 year incarceration, restitution $15000', 'Convicted', 'Atlanta PD', 'Fulton County Court', '2016-00003'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'ltaylor@retailmax.com') AND ChargeDescription = 'Theft from Employer');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'canderson@logisticspro.net'), 'Hit and Run', '2018-02-19', '2018-05-25', 'Hit and Run', 'Felony', '2 years incarceration, license revoked', 'Convicted', 'Memphis PD', 'Shelby County Court', '2018-00004'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'canderson@logisticspro.net') AND ChargeDescription = 'Hit and Run');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'jthomas@energytech.com'), 'Weapons Possession', '2019-04-08', '2019-07-30', 'Illegal Weapon', 'Felony', '1 year incarceration', 'Convicted', 'Denver PD', 'Denver District Court', '2019-00005'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'jthomas@energytech.com') AND ChargeDescription = 'Weapons Possession');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'djackson@mediastream.com'), 'Sexual Assault', '2014-08-22', '2015-02-14', 'Sexual Assault', 'Felony', '5 years incarceration, sex offender registry', 'Convicted', 'Los Angeles PD', 'Los Angeles Superior Court', '2014-00006'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'djackson@mediastream.com') AND ChargeDescription = 'Sexual Assault');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'awhite@educationhub.edu'), 'Child Endangerment', '2015-09-10', NULL, 'Child Endangerment', 'Felony', 'Trial pending', 'Pending', 'Boston PD', 'Massachusetts Superior Court', '2015-00007'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'awhite@educationhub.edu') AND ChargeDescription = 'Child Endangerment');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'mharris@realestated.com'), 'Arson', '2017-06-15', '2017-10-20', 'Arson', 'Felony', '6 years incarceration', 'Convicted', 'Miami PD', 'Miami-Dade County Court', '2017-00008'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'mharris@realestated.com') AND ChargeDescription = 'Arson');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'nmartin@travelhub.com'), 'Stalking', '2021-01-30', NULL, 'Stalking', 'Misdemeanor', 'Restraining order issued', 'Pending', 'San Francisco PD', 'San Francisco Superior Court', '2021-00009'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'nmartin@travelhub.com') AND ChargeDescription = 'Stalking');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'kgarcia@foodtech.com'), 'Food Poisoning', '2016-12-05', '2017-03-15', 'Negligence', 'Misdemeanor', 'Fine $5000, closure order', 'Convicted', 'Austin PD', 'Travis County Court', '2016-00010'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'kgarcia@foodtech.com') AND ChargeDescription = 'Food Poisoning');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'rrodriguez@automotivex.com'), 'Speeding Ticket', '2019-07-20', '2019-09-05', 'Traffic Violation', 'Misdemeanor', 'Defensive driving course', 'Convicted', 'Detroit PD', 'Wayne County Court', '2019-00011'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'rrodriguez@automotivex.com') AND ChargeDescription = 'Speeding Ticket');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'smartinez@biopharma.com'), 'Bribery', '2018-09-12', '2019-02-28', 'Bribery', 'Felony', '3 years incarceration', 'Convicted', 'Cambridge PD', 'Federal Court MA', '2018-00012'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'smartinez@biopharma.com') AND ChargeDescription = 'Bribery');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'alopez@manufacturepplus.com'), 'Theft of Company Secrets', '2017-01-20', '2017-06-15', 'Theft', 'Felony', '2 years incarceration', 'Convicted', 'Cleveland PD', 'Cuyahoga County Court', '2017-00013'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'alopez@manufacturepplus.com') AND ChargeDescription = 'Theft of Company Secrets');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'bgonzalez@telecommtech.com'), 'Tax Evasion', '2014-05-08', '2014-11-20', 'Tax Evasion', 'Felony', '18 months incarceration, back taxes + penalties', 'Convicted', 'Dallas PD', 'Dallas County Court', '2014-00014'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'bgonzalez@telecommtech.com') AND ChargeDescription = 'Tax Evasion');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'mwilson@consultantspro.com'), 'Perjury', '2019-12-10', '2020-04-22', 'Perjury', 'Felony', '2 years incarceration', 'Convicted', 'New York PD', 'Manhattan Criminal Court', '2019-00015'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'mwilson@consultantspro.com') AND ChargeDescription = 'Perjury');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'elee@initech.com'), 'Public Intoxication', '2020-08-15', '2020-10-10', 'Intoxication', 'Misdemeanor', 'Probation 6 months', 'Convicted', 'Austin PD', 'Travis County Court', '2020-00016'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'elee@initech.com') AND ChargeDescription = 'Public Intoxication');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'schen@dataflow.com'), 'Cybercrime', '2021-03-18', NULL, 'Computer Fraud', 'Felony', 'Trial scheduled', 'Pending', 'Seattle FBI', 'U.S. District Court WA', '2021-00017'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'schen@dataflow.com') AND ChargeDescription = 'Cybercrime');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'akim@cloudvault.io'), 'Counterfeiting', '2016-11-05', '2017-04-12', 'Counterfeiting', 'Felony', '3 years incarceration', 'Convicted', 'San Jose PD', 'Federal Court CA', '2016-00018'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'akim@cloudvault.io') AND ChargeDescription = 'Counterfeiting');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'opatel@securenet.com'), 'Drug Distribution', '2018-07-22', '2019-01-30', 'Drug Offense', 'Felony', '4 years incarceration', 'Convicted', 'Boston PD', 'Federal Court MA', '2018-00019'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'opatel@securenet.com') AND ChargeDescription = 'Drug Distribution');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'jsingh@innovatetech.ai'), 'Manslaughter', '2013-03-10', '2013-09-20', 'Manslaughter', 'Felony', '8 years incarceration', 'Convicted', 'San Francisco PD', 'California Superior Court', '2013-00020'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'jsingh@innovatetech.ai') AND ChargeDescription = 'Manslaughter');

INSERT INTO initech.CriminalRecords (UserId, ChargeDescription, ChargeDate, ConvictionDate, Offense, Severity, Sentence, Status, ArrestingAgency, CourtName, CaseNumber)
SELECT (SELECT Id FROM initech.Users WHERE Email = 'ikumar@financecore.com'), 'Wire Fraud', '2015-08-15', '2016-02-10', 'Fraud', 'Felony', '3 years incarceration', 'Convicted', 'New York FBI', 'Federal Court SDNY', '2015-00021'
WHERE NOT EXISTS (SELECT 1 FROM initech.CriminalRecords WHERE UserId = (SELECT Id FROM initech.Users WHERE Email = 'ikumar@financecore.com') AND ChargeDescription = 'Wire Fraud');
