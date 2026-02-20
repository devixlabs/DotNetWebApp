-- Create GAI database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'GAI')
BEGIN
  CREATE DATABASE GAI;
  PRINT 'Created database GAI';
END
ELSE
BEGIN
  PRINT 'Database GAI already exists';
END
GO

-- Create GAIMisc database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'GAIMisc')
BEGIN
  CREATE DATABASE GAIMisc;
  PRINT 'Created database GAIMisc';
END
ELSE
BEGIN
  PRINT 'Database GAIMisc already exists';
END
GO
