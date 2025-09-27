/*
=============================================================
Database and Schema Initialization Script
=============================================================
Overview:
    This script provisions a new database named 'DataWarehouse'. 
    If an existing 'DataWarehouse' database is detected, it will be 
    dropped and recreated to ensure a clean environment. 

    Within the newly created database, three schemas are established:
        - bronze: for raw/ingested data
        - silver: for cleansed and standardized data
        - gold: for curated, business-ready data

Important Notice:
    Executing this script will permanently drop the existing 'DataWarehouse' 
    database along with all associated objects and data. 
    Ensure proper backups and validation are completed prior to execution.
*/


USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
