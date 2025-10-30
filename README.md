---

# 🧠 Data Warehouse & Analytics Project

Welcome to the **Data Warehouse and Analytics Project** — a full-scale enterprise-grade solution designed to demonstrate **data engineering excellence** across the entire data lifecycle.

This repository represents the **design, development, and implementation** of a modern **data warehouse and analytics platform**, built to ensure data consistency, scalability, and actionable insights.

It reflects my commitment to **engineering data systems that are efficient, auditable, and business-aligned**.

---

## 🏗️ Data Architecture

This project adopts the **Medallion Architecture** (Bronze → Silver → Gold), a modern best-practice framework used by enterprise data teams for **data reliability, lineage, and scalability**.

| **Layer**     | **Purpose**         | **Description**                                                                        |
| ------------- | ------------------- | -------------------------------------------------------------------------------------- |
| 🥉 **Bronze** | Raw Data            | Ingests unaltered source data from ERP and CRM systems (CSV → SQL Server).             |
| 🥈 **Silver** | Cleansed Data       | Applies data transformations, standardization, and business validation rules.          |
| 🥇 **Gold**   | Business-Ready Data | Curated and modeled into star schemas for high-performance analytics and BI reporting. |

📊 *Architecture Diagram: `docs/data_architecture.drawio`*

---

## 📖 Project Overview

This project integrates **data engineering**, **data modeling**, and **analytics development** into a cohesive ecosystem.

### 🔹 Core Deliverables

1. **Data Architecture Design:**
   Implemented a scalable Medallion structure for seamless ingestion and transformation workflows.

2. **ETL Pipeline Development:**
   Designed modular SQL-based pipelines for **extraction, cleansing, transformation**, and **loading** across all layers.

3. **Data Modeling:**
   Developed a **Star Schema** structure (Fact & Dimension tables) for optimized analytical queries and reporting.

4. **Data Quality Assurance:**
   Embedded validation checkpoints, audit columns, and referential integrity controls for reliability.

5. **Business Analytics:**
   Delivered data-driven insights on **Customer Behavior**, **Product Trends**, and **Sales Performance** through SQL analytics.

---
---

## ⚙️ Tools & Technologies

| **Category**                 | **Tools / Technologies**           |
| ---------------------------- | ---------------------------------- |
| **Database & Querying**      | Microsoft SQL Server, SSMS         |
| **Data Modeling**            | Draw.io               |
| **Version Control**          | Git & GitHub                       |
| **Data Sources**             | ERP and CRM (CSV files)            |
| **Documentation & Tracking** | Notion                   |
| **Architecture Framework**   | Medallion (Bronze → Silver → Gold) |

---

## 📂 Repository Structure

```
data-warehouse-project/
│
├── datasets/                     # Raw source data (ERP & CRM)
├── docs/                         # Documentation & diagrams
│   ├── data_architecture.drawio
│   ├── data_models.drawio
│   ├── naming-conventions.md
│   ├── data_catalog.md
│
├── scripts/                      # SQL scripts for ETL
│   ├── bronze/                   # Extraction & raw load
│   ├── silver/                   # Cleansing & transformation
│   ├── gold/                     # Data modeling & analytics
│
├── tests/                        # Data validation & QA scripts
├── README.md                     # Main project overview
├── LICENSE                       # License file
└── .gitignore                    # Ignore unnecessary files
```

---

## 🔍 Data Quality Validation

| **Validation Type**       | **Purpose**                   | **Example / Implementation**            |
| ------------------------- | ----------------------------- | --------------------------------------- |
| **Null Value Check**      | Ensures completeness          | `WHERE customer_id IS NULL`             |
| **Data Type Validation**  | Confirms schema consistency   | Convert date strings → DATE             |
| **Duplicate Detection**   | Detects redundant records     | `SELECT COUNT(DISTINCT id)`             |
| **Referential Integrity** | Enforces FK–PK relationships  | Sales table → Customer table linkage    |
| **Business Rule Check**   | Validates logical constraints | `sales_amount > 0`, `date <= GETDATE()` |
| **Audit Columns**         | Tracks ETL process & lineage  | `dwh_load_date`, `dwh_created_by`       |

Each layer (Bronze → Silver → Gold) includes **automated quality gates** before promotion, ensuring that **no corrupted or incomplete data** enters production.

---

## 📘 Documentation Highlights

* **`naming-conventions.md`** → Enterprise-standard naming convention for schemas, tables, and columns.
* **`data_catalog.md`** → Metadata definitions for each dataset and field.
* **`data_models.drawio`** → Logical and physical schema diagrams.


---

## 👨🏽‍💻 About Me

Hi, I’m **Chinedu Anele**, a **Medical Laboratory Scientist** turned **Data Engineer** with a passion for building **scalable, reliable, and insightful data systems** that drive decision-making in healthcare and business intelligence.

I specialize in:

* Data Warehousing & Architecture Design
* SQL & Data Modeling (OLAP/OLTP)
* ETL Pipeline Development
* Data Governance & Quality Management
* Analytics Engineering

I bring a unique blend of **analytical precision** from my medical background and **engineering discipline** from my data practice — bridging technical rigor with real-world business impact.

📍 Based in **Nigeria** | 🌍 Delivering global data solutions

---

## 🔗 Connect with Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/chinedu-anele-b46464194)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/GeorgeAnele)
[![WhatsApp](https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white)](https://wa.me/2348123001381)
[![Call](https://img.shields.io/badge/Call-007AFF?style=for-the-badge&logo=apple&logoColor=white)](tel:+2349031811486)

---

## 🛡️ License

This project is licensed under the **MIT License**.
You are free to use, modify, and reference this work with proper attribution.

---
🙏 Appreciation

Special appreciation goes to Baraa Khatib Salkini, whose educational resources and open-source content served as a foundational guide for the design and implementation of this data warehouse project. His dedication to sharing practical data engineering knowledge is invaluable to learners and professionals across the globe.

---
## 🌟 Closing Note

This project is a reflection of how I approach **data engineering as both a science and an art** — combining **technical depth, architectural discipline, and business empathy** to transform data into strategic value.

> “Great data engineering isn’t just about moving data — it’s about moving organizations toward better decisions.”

---
