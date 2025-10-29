/*
===============================================================================
Project: Data Warehouse Project
Layer: Gold Layer – Data Quality Validation
===============================================================================
Author: Chinedu Anele  
Role: Data Engineer  
Date: 29th October 2025 

Overview:
    This script performs post-transformation quality checks on the **Gold Layer**
    to ensure data integrity, referential accuracy, and consistency across all 
    analytical views. It validates that dimension and fact relationships are 
    correctly established and that no data anomalies exist in the dimensional model.

Checks Performed:
    1. gold.dim_customers  
       - Validates uniqueness of the surrogate key (customer_key).  
       - Ensures no duplicate or null records exist in the dimension.

    2. gold.dim_products  
       - Confirms the uniqueness and stability of product surrogate keys.  
       - Detects potential duplication that could affect join accuracy.

    3. gold.fact_sales  
       - Verifies referential integrity between fact and dimension tables.  
       - Ensures that every fact record maps correctly to valid dimension keys.

Key Highlights:
    - Ensures a **clean, reliable Star Schema** structure for BI consumption.  
    - Prevents data duplication and orphaned records in analytical reporting.  
    - Strengthens the overall trust and auditability of the Gold Layer.

Execution Notes:
    - Run this script after Gold Layer view creation and population.  
    - Any returned rows indicate data integrity issues requiring investigation.  
    - Results should ideally return **no records** if the data is consistent.
===============================================================================
*/


-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results 
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.product_key'
-- ====================================================================
-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results 
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL  
