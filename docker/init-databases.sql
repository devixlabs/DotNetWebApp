-- Create WEBAPP database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'WEBAPP')
BEGIN
  CREATE DATABASE WEBAPP;
  PRINT 'Created database WEBAPP';
END
ELSE
BEGIN
  PRINT 'Database WEBAPP already exists';
END
GO

-- Create WEBAPPMisc database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'WEBAPPMisc')
BEGIN
  CREATE DATABASE WEBAPPMisc;
  PRINT 'Created database WEBAPPMisc';
END
ELSE
BEGIN
  PRINT 'Database WEBAPPMisc already exists';
END
GO
