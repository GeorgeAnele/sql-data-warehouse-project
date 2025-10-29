# 🧭 Gold Layer Data Catalog

## **Overview**

The **Gold Layer** represents the **curated, business-ready layer** of the data warehouse.
It serves as the **single source of truth (SSOT)** for analytics, dashboards, and reporting — built from cleansed and conformed data in the Silver Layer.

This layer is modeled using a **star schema**, consisting of **dimension tables** that describe business entities and **fact tables** that record measurable business events.

---

##  1. `gold.dim_customers`

**Purpose:**
Stores enriched customer profile data, integrating demographic, geographic, and transactional insights to support customer segmentation, retention, and lifetime value analysis.

| **Column Name**   | **Data Type**  | **Description**                                                                   |
| ----------------- | -------------- | --------------------------------------------------------------------------------- |
| `customer_key`    | `INT`          | Surrogate key uniquely identifying each customer record in the dimension table.   |
| `customer_id`     | `INT`          | Source system identifier assigned to each customer.                               |
| `customer_number` | `NVARCHAR(50)` | Alphanumeric customer reference code used for tracking and external integrations. |
| `first_name`      | `NVARCHAR(50)` | Customer’s first name as recorded in the operational source.                      |
| `last_name`       | `NVARCHAR(50)` | Customer’s last or family name.                                                   |
| `country`         | `NVARCHAR(50)` | Customer’s country of residence (e.g., *Australia*).                              |
| `marital_status`  | `NVARCHAR(50)` | Marital status classification (e.g., *Married*, *Single*).                        |
| `gender`          | `NVARCHAR(50)` | Gender identifier (e.g., *Male*, *Female*, *n/a*).                                |
| `birthdate`       | `DATE`         | Customer’s date of birth (`YYYY-MM-DD`).                                          |
| `create_date`     | `DATE`         | Timestamp when the record was created in the system.                              |

**Notes:**

* Primary Key: `customer_key`
* Slowly Changing Dimension (SCD Type 1) applied for customer updates.
* Used by: `gold.fact_sales`

---

##  2. `gold.dim_products`

**Purpose:**
Captures product catalog information and metadata, supporting product-level analytics such as sales by category, margin analysis, and inventory forecasting.

| **Column Name**        | **Data Type**  | **Description**                                                              |
| ---------------------- | -------------- | ---------------------------------------------------------------------------- |
| `product_key`          | `INT`          | Surrogate key uniquely identifying each product record.                      |
| `product_id`           | `INT`          | Source identifier for product records.                                       |
| `product_number`       | `NVARCHAR(50)` | Internal SKU or alphanumeric code used to categorize or reference a product. |
| `product_name`         | `NVARCHAR(50)` | Official name or description of the product.                                 |
| `category_id`          | `NVARCHAR(50)` | Identifier linking each product to its category.                             |
| `category`             | `NVARCHAR(50)` | High-level classification of the product (e.g., *Bikes*, *Components*).      |
| `subcategory`          | `NVARCHAR(50)` | More granular classification within the main category.                       |
| `maintenance_required` | `NVARCHAR(50)` | Indicates if the product requires maintenance (`Yes`/`No`).                  |
| `cost`                 | `INT`          | Standard cost or manufacturing cost of the product.                          |
| `product_line`         | `NVARCHAR(50)` | Product series or family (e.g., *Road*, *Mountain*).                         |
| `start_date`           | `DATE`         | Launch or availability date of the product.                                  |

**Notes:**

* Primary Key: `product_key`
* Category hierarchy enables roll-up analysis for reporting.
* Used by: `gold.fact_sales`

---

##  3. `gold.fact_sales`

**Purpose:**
Contains transaction-level sales data that links to both customer and product dimensions.
This table supports key business metrics like revenue, order volume, average sales price, and customer-product interactions.

| **Column Name** | **Data Type**  | **Description**                                                        |
| --------------- | -------------- | ---------------------------------------------------------------------- |
| `order_number`  | `NVARCHAR(50)` | Unique alphanumeric identifier for each sales order (e.g., *SO54496*). |
| `product_key`   | `INT`          | Foreign key referencing `gold.dim_products`.                           |
| `customer_key`  | `INT`          | Foreign key referencing `gold.dim_customers`.                          |
| `order_date`    | `DATE`         | Date when the sales order was placed.                                  |
| `shipping_date` | `DATE`         | Date when the order was shipped to the customer.                       |
| `due_date`      | `DATE`         | Payment due date for the sales order.                                  |
| `sales_amount`  | `INT`          | Total monetary value of the sales line item.                           |
| `quantity`      | `INT`          | Quantity of items sold in the order line.                              |
| `price`         | `INT`          | Unit price of the item in the sales order.                             |

**Notes:**

* Primary Grain: One row per *sales order line item*.
* Fact table joins:

  * `product_key` → `gold.dim_products`
  * `customer_key` → `gold.dim_customers`
* Measures: `sales_amount`, `quantity`, `price`
* Supports analysis by product, customer, time, and geography.

---

##  Summary

| **Table Name**       | **Type**  | **Primary Key**                        | **Joins To**                    | **Purpose Summary**                                 |
| -------------------- | --------- | -------------------------------------- | ------------------------------- | --------------------------------------------------- |
| `gold.dim_customers` | Dimension | `customer_key`                         | `fact_sales.customer_key`       | Stores customer profiles and demographics.          |
| `gold.dim_products`  | Dimension | `product_key`                          | `fact_sales.product_key`        | Holds detailed product metadata and classification. |
| `gold.fact_sales`    | Fact      | Composite (order_number + product_key) | `dim_customers`, `dim_products` | Tracks all sales transactions and related measures. |

---


