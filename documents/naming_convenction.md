# 🧭 **Data Warehouse Naming Conventions**

This document defines the standardized naming conventions used across all schemas, tables, columns, and stored procedures in the enterprise data warehouse.
Adhering to these conventions ensures consistency, readability, maintainability, and interoperability across all layers (Bronze, Silver, and Gold).

---

## **Table of Contents**

1. [General Principles](#general-principles)
2. [Schema & Table Naming Conventions](#schema--table-naming-conventions)

   * [Bronze Layer](#bronze-layer)
   * [Silver Layer](#silver-layer)
   * [Gold Layer](#gold-layer)
3. [Column Naming Conventions](#column-naming-conventions)

   * [Surrogate Keys](#surrogate-keys)
   * [Technical Columns](#technical-columns)
4. [Stored Procedure Naming Conventions](#stored-procedure-naming-conventions)

---

## **General Principles**

| **Rule**           | **Description**                                                                    |
| ------------------ | ---------------------------------------------------------------------------------- |
| **Naming Style**   | Use `snake_case` for all database objects (lowercase letters with underscores).    |
| **Language**       | All object names must be in **English** to ensure global team consistency.         |
| **Length**         | Keep names concise yet descriptive (≤ 30 characters when possible).                |
| **Reserved Words** | Avoid SQL reserved keywords (e.g., `table`, `user`, `order`).                      |
| **Clarity First**  | Names should describe purpose — prioritize readability over brevity.               |
| **Pluralization**  | Use plural nouns for tables representing entities (e.g., `customers`, `products`). |

---

## **Schema & Table Naming Conventions**

### **Bronze Layer**

The Bronze Layer contains raw, untransformed data ingested directly from source systems.
It serves as the immutable data foundation for all downstream processing.

| **Pattern**                      | **Description**                                                                                       | **Example**                             |
| -------------------------------- | ----------------------------------------------------------------------------------------------------- | --------------------------------------- |
| `<sourcesystem>_<entity>`        | Prefix tables with the source system identifier, followed by the entity name (as-is from the source). | `crm_customer_info`, `erp_sales_orders` |
| **Do Not Rename Source Columns** | Maintain the original structure and naming for traceability.                                          |                                         |
| **Purpose**                      | Enable full auditability and data lineage tracking from source to report.                             |                                         |

---

### **Silver Layer**

The Silver Layer represents **cleaned, conformed, and standardized data**.
It integrates multiple sources, applies business rules, and ensures data quality.

| **Pattern**                  | **Description**                                                                                  | **Example**                              |
| ---------------------------- | ------------------------------------------------------------------------------------------------ | ---------------------------------------- |
| `<sourcesystem>_<entity>`    | Retain source identifier but apply light standardization (e.g., normalize data types or naming). | `crm_customer_info`, `erp_sales_details` |
| **Data Quality Enforcement** | Null handling, deduplication, and data type consistency are applied here.                        |                                          |
| **Purpose**                  | Provide harmonized and analysis-ready data for transformation into the Gold Layer.               |                                          |

---

### **Gold Layer**

The Gold Layer is the **business-facing semantic layer**, optimized for reporting, dashboards, and analytics.
It consists of **dimension**, **fact**, and **aggregate** tables.

| **Pattern**           | **Description**                                                             | **Example**                                        |
| --------------------- | --------------------------------------------------------------------------- | -------------------------------------------------- |
| `<category>_<entity>` | Prefix the table with its functional role (`dim`, `fact`, `agg`, `report`). | `dim_customers`, `fact_sales`, `agg_sales_monthly` |
| **Naming Style**      | Use clear, business-aligned terminology that is intuitive for analysts.     |                                                    |
| **Purpose**           | Support BI, ML models, and KPI-driven analytics.                            |                                                    |

#### **Category Prefix Glossary**

| **Prefix** | **Meaning**                                       | **Example(s)**                  |
| ---------- | ------------------------------------------------- | ------------------------------- |
| `dim_`     | Dimension table (descriptive attributes)          | `dim_customers`, `dim_products` |
| `fact_`    | Fact table (transactional or measurable events)   | `fact_sales`, `fact_invoices`   |
| `agg_`     | Aggregated table for performance or summarization | `agg_monthly_sales`             |
| `report_`  | Reporting views or curated data marts             | `report_sales_summary`          |

---

## **Column Naming Conventions**

### **Surrogate Keys**

| **Pattern**    | **Description**                                                                                | **Example**                                |
| -------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------ |
| `<entity>_key` | Used for primary keys in dimension and fact tables. Always integer-based and system-generated. | `customer_key`, `product_key`, `sales_key` |
| **Purpose**    | Provides a consistent and surrogate link between dimensions and facts.                         |                                            |
| **Rule**       | Never reuse or repurpose surrogate keys; they must remain stable once assigned.                |                                            |

---

### **Technical Columns**

| **Pattern**                   | **Description**                                                                      | **Example**                                        |
| ----------------------------- | ------------------------------------------------------------------------------------ | -------------------------------------------------- |
| `dwh_<column_name>`           | Prefix all system-generated metadata columns with `dwh_`.                            | `dwh_load_date`, `dwh_update_ts`, `dwh_created_by` |
| **Purpose**                   | Track data lineage, audit trails, and ETL metadata.                                  |                                                    |
| **Data Type Standardization** | - Dates → `DATETIME2` <br> - Booleans → `BIT` <br> - Identifiers → `INT` or `BIGINT` |                                                    |

---

## **Stored Procedure Naming Conventions**

Stored procedures are used to orchestrate data loading, transformation, and quality checks across the data layers.

| **Pattern**              | **Description**                                                 | **Example**                                    |
| ------------------------ | --------------------------------------------------------------- | ---------------------------------------------- |
| `load_<layer>`           | Used for core ETL/ELT processes that populate a specific layer. | `load_bronze`, `load_silver`, `load_gold`      |
| `validate_<layer>`       | Used for data validation or quality checks per layer.           | `validate_gold`                                |
| `sp_<function>_<entity>` | For utility or supporting functions.                            | `sp_refresh_dim_customers`, `sp_sync_metadata` |

**Best Practices:**

* Always include comments describing the purpose, logic, and dependencies.
* Use transaction control (`BEGIN TRAN`, `COMMIT`, `ROLLBACK`) for data safety.
* Store all procedural scripts under `/sql/stored_procedures/` for version control.

---

## ✅ **Summary**

| **Layer** | **Naming Focus**               | **Example Pattern**       | **Primary Goal**                |
| --------- | ------------------------------ | ------------------------- | ------------------------------- |
| Bronze    | Raw data, source fidelity      | `<sourcesystem>_<entity>` | Preserve original source schema |
| Silver    | Cleansed and standardized      | `<sourcesystem>_<entity>` | Harmonize data across systems   |
| Gold      | Business-friendly presentation | `<category>_<entity>`     | Enable analytics and reporting  |

---

