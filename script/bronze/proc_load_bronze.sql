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

-- NOTE: This first line executes the procedure when run as a script. Keep it
-- if you intend to run the load immediately. If you're only inspecting the
-- procedure, you can ignore this line. The script below also defines the
-- procedure so it can be executed later via EXEC bronze.load_bronze.

EXEC bronze.load_bronze 

-- CREATE OR ALTER ensures the procedure is created if missing or updated if it exists.
-- The procedure performs staged "bronze" layer data ingestion using BULK INSERT.
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	-- Timing variables used to track per-table and total load durations.
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	-- TRY/CATCH block: TRY contains the main load logic; CATCH prints error details.
	BEGIN TRY
		-- Mark the beginning of the batch load and note the start time.
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		-- -----------------------------
		-- CRM TABLES SECTION
		-- -----------------------------
		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		-- PER-TABLE PATTERN (repeated for each table):
		-- 1. Set @start_time
		-- 2. TRUNCATE the target bronze table to remove previous runs' data
		-- 3. BULK INSERT from a CSV file into the bronze table
		-- 4. Set @end_time and PRINT duration

		-- Timing starts here for crm_cust_info
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;  -- removes all rows quickly; cannot be rolled back outside transaction

		-- IMPORTANT: BULK INSERT reads the CSV from the SQL Server host machine
		-- (not your local machine unless SQL Server runs as your account). Ensure
		-- the SQL Server service account has READ permission for the file path.
		PRINT '>>Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,            -- skip header row
			FIELDTERMINATOR = ',',   -- CSV uses comma as field separator
			TABLOCK                 -- take table-level lock for performance
		);
		-- Note: If your CSV uses quoted fields or has UTF-8 BOM, consider using
		-- FORMAT='CSV' (SQL Server 2017+) or specify CODEPAGE. Also consider
		-- using ERRORFILE to capture problematic rows.
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>--------------'

		-- --- Next CRM table: crm_prd_info ---
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>--------------'

		-- --- Next CRM table: crm_sales_details ---
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>--------------'


		-- -----------------------------
		-- ERP TABLES SECTION
		-- -----------------------------
		PRINT '------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------';
		
		-- --- ERP table: erp_loc_a101 ---
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>--------------'

		-- --- ERP table: erp_cust_az12 ---
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>--------------'

		-- --- ERP table: erp_px_cat_g1v2 ---
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\user\Desktop\DATA ENGR\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>--------------';

		-- Finalize batch timing and print summary. DATEDIFF returns seconds here.
		SET @batch_end_time = GETDATE();
		PRINT '================================================'
		PRINT 'Loading Bronze Layer is Completed';
		PRINT ' - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	END TRY

	BEGIN CATCH
		-- CATCH prints error info when any statement inside TRY fails.
		-- Note: Consider including ERROR_LINE() here for precise line number in future.
		PRINT '========================================'
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================================'
	END CATCH
END

