# Data Warehouse and Analytics Project

**Author:** Dragomir Alin – Ciprian

Welcome to the Data Warehouse and Analytics Project repository! 🚀  
This project demonstrates a complete data warehousing and analytics solution — from building a warehouse to generating business insights. It follows best practices in data engineering and serves as a strong portfolio project.

---

## 🏗️ Data Architecture

The project uses the **Medallion Architecture**, divided into three layers:

- **Bronze Layer:** Raw data storage from source files (CSV into SQL Server).
- **Silver Layer:** Cleaned, standardized, and normalized data ready for analysis.
- **Gold Layer:** Business-friendly analytical data models using a star schema.

---

## 📖 Project Overview

The project includes the following steps:

1. **Data Architecture Design** using Medallion Layers.
2. **ETL Pipelines** to extract, transform, and load source data.
3. **Data Modeling** with fact & dimension tables.
4. **Analytics & Reporting** using SQL queries and dashboards.

---

## 🎯 Skills Demonstrated

This repository is ideal for showcasing your expertise in:

- SQL Development  
- Data Engineering  
- ETL Design  
- Data Modeling  
- Business Data Analytics  

---

## 🛠️ Tools & Resources

All tools used are free:

- **Datasets:** CSV files
- **SQL Server Express:** Free SQL server
- **SSMS:** GUI tool for database management
- **Git:** Version control and collaboration
- **DrawIO:** Diagrams and data models
- **Notion:** Project templates and organization

---

## 🚀 Project Requirements

**Build the Data Warehouse (Data Engineering)**  
**Goal:** Centralize ERP and CRM data into a SQL data warehouse for analytics.

**Specs:**  
- Source: two CSV files (ERP and CRM)  
- Quality: clean and normalize data  
- Integration: unified model for analysis  
- Scope: most recent data only (no historization)  
- Documentation: clear, simple, and helpful for stakeholders  

**Analytics & Reporting (Data Analysis)**  
**Goal:** SQL-based analytics to answer business questions:

- Customer behavior  
- Product performance  
- Sales trends  

The outcome should support informed business decisions.

---

## 📂 Repository Structure

```text
datasets/           # raw ERP and CRM data
docs/               # documentation and diagrams
scripts/
  ├── bronze/       # load raw data
  ├── silver/       # cleaning and transforming
  └── gold/         # building analytical models
tests/              # data validation
README.md           # project description
LICENSE             # MIT license
.gitignore
requirements.txt
