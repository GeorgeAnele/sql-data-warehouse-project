/*
==============================================================================
Procedure: bronze.load_bronze
Purpose:   
    This stored procedure automates the ingestion of raw data from external 
    CSV files into the Bronze Layer of the data warehouse. 

    Key Features:
    - Each Bronze table is truncated before reload to avoid duplication.
    - Data is ingested via BULK INSERT from defined source file paths.
    - Execution time is logged for each individual table load.
    - Overall total load duration across all tables is calculated and displayed.
    - Basic error handling is included for monitoring and debugging.

Usage Notes:
    - Ensure that the file paths referenced in BULK INSERT are accessible 
      to the SQL Server instance and have the correct permissions.
    - The Bronze layer represents the raw ingestion zone of the data pipeline; 
      data is expected to be in its original, untransformed state.
    - Review and update file paths if environment or directory structure changes.
==============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @proc_start DATETIME, @proc_end DATETIME;
    DECLARE @total_seconds INT, @minutes INT, @seconds INT;

    -- Start overall timer
    SET @proc_start = GETDATE();

    BEGIN TRY
        PRINT '======================================';
        PRINT 'Loading Bronze Layer';
        PRINT '======================================';

        PRINT '---------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '---------------------------------------';

        -- Load CRM: cust_info
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> crm_cust_info Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';

        -- Load CRM: prd_info
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> crm_prd_info Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';

        -- Load CRM: sales_details
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> crm_sales_details Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';


        PRINT '---------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '---------------------------------------';

        -- Load ERP: cust_az12
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> erp_cust_az12 Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';

        -- Load ERP: loc_a101
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> erp_loc_a101 Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';

        -- Load ERP: px_cat_g1v2
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> erp_px_cat_g1v2 Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';

        -- End overall timer
        SET @proc_end = GETDATE();
        SET @total_seconds = DATEDIFF(SECOND, @proc_start, @proc_end);

        -- Convert total load time into minutes and seconds
        SET @minutes = @total_seconds / 60;
        SET @seconds = @total_seconds % 60;

        PRINT '======================================';
        PRINT 'TOTAL LOAD DURATION (All Tables): ' 
              + CAST(@minutes AS NVARCHAR(10)) + ' minutes ' 
              + CAST(@seconds AS NVARCHAR(10)) + ' seconds';
        PRINT '======================================';

    END TRY
    BEGIN CATCH
        PRINT '============================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
        PRINT '============================================';
    END CATCH
END;
