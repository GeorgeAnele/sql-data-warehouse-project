/*
===============================================================================================
Script Name:    Silver Layer Table Definitions
Author:         Anele Chinedu George
Project:        Data Warehouse ETL - Silver Layer (Refined Data)
Date Created:   26TH October, 2025
Last Modified:  26TH October, 2025

Description:
    This script creates all necessary tables in the 'silver' schema of the data warehouse.
    The Silver Layer represents the *cleansed and structured* zone within the ETL pipeline,
    designed to store refined data sourced from the Bronze Layer (raw data).

    Each table in this layer standardizes business entities across multiple source systems,
    enabling consistent analytics and downstream transformations into the Gold Layer.

Tables Created:
    1. silver.crm_cust_info        - Customer master information (CRM system)
    2. silver.crm_prd_info         - Product master data and attributes
    3. silver.crm_sales_details    - Transactional sales details (CRM system)
    4. silver.erp_loc_a101         - Location mapping data (ERP system)
    5. silver.erp_cust_az12        - Customer demographic details (ERP system)
    6. silver.erp_px_cat_g1v2      - Product category and maintenance reference data (ERP system)

Notes:
    - Existing tables with the same names are dropped before recreation to ensure schema consistency.
    - Each table includes a 'dwh_create_date' column populated with the current system timestamp
      to track record creation in the warehouse.
    - Script is intended to be executed in the context of a valid database containing the 'silver' schema.

Usage:
    Execute in SQL Server Management Studio (SSMS) or via automated ETL job scheduler.
    Ensure the 'silver' schema exists before running this script:
        IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
            EXEC('CREATE SCHEMA silver');
===============================================================================================
*/


IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info (
    cst_id             INT,
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    cst_lastname       NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr           NVARCHAR(50),
    cst_create_date    DATE,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info (
    prd_id          INT,
    cat_id          NVARCHAR(50),
    prd_key         NVARCHAR(50),
    prd_nm          NVARCHAR(50),
    prd_cost        INT,
    prd_line        NVARCHAR(50),
    prd_start_dt    DATE,
    prd_end_dt      DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO

CREATE TABLE silver.crm_sales_details (
    sls_ord_num     NVARCHAR(50),
    sls_prd_key     NVARCHAR(50),
    sls_cust_id     INT,
    sls_order_dt    DATE,
    sls_ship_dt     DATE,
    sls_due_dt      DATE,
    sls_sales       INT,
    sls_quantity    INT,
    sls_price       INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
GO

CREATE TABLE silver.erp_loc_a101 (
    cid             NVARCHAR(50),
    cntry           NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;
GO

CREATE TABLE silver.erp_cust_az12 (
    cid             NVARCHAR(50),
    bdate           DATE,
    gen             NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;
GO

CREATE TABLE silver.erp_px_cat_g1v2 (
    id              NVARCHAR(50),
    cat             NVARCHAR(50),
    subcat          NVARCHAR(50),
    maintenance     NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
