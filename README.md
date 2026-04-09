# Library Analytics Project (SQL + Power BI)

This repository contains an end-to-end data analytics project based on a Library Management System.

It demonstrates a full workflow: from database design and data preparation in SQL to building an interactive dashboard in Power BI.

If you are reviewing this project as a recruiter or hiring manager, this repository shows how I approach a data problem end to end: from schema design and data preparation to business-oriented analysis and visualization.

---

## Project Overview

The project models a small library environment with core entities such as books, members, employees, branches, rentals, authors, publishers, and categories.

It includes:

- a normalized relational database schema  
- staging tables for CSV data import  
- data loading and transformation logic  
- analytical SQL queries  
- an interactive Power BI dashboard  

---

## Power BI Dashboard

### Overview
![Overview](powerbi/screenshots/overview.png)

### Customer Insights
![Customer Insights](powerbi/screenshots/customer_insights.png)

### Operations
![Operations](powerbi/screenshots/operations.png)

The dashboard includes:

- rental trends and running totals  
- customer segmentation and ranking  
- activity vs recency analysis (scatter plot)  
- overdue and unreturned rentals tracking  
- operational performance metrics  

---

## What This Project Demonstrates

This project highlights practical data analytics skills, including:

### SQL
- database normalization  
- foreign key relationships  
- staging-to-target data loading workflow  
- `JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`  
- `CTE` usage  
- window functions: `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `LAG()`  

### Power BI & DAX
- data modeling and relationships  
- calculated columns and measures  
- customer segmentation logic  
- running totals and time intelligence  
- interactive dashboards and visual storytelling  


---

## Analytical Topics Covered

The project covers a range of business-oriented analysis:

- customer segmentation (activity-based)  
- top customers and ranking  
- rental trends and running totals  
- overdue and unreturned rentals  
- most recent rental per customer  
- category-level rental distribution  
- operational metrics and KPIs  

---

## Data Workflow

The data pipeline used in this project:

1. CSV files are loaded into staging tables  
2. staging data is cleaned and transformed  
3. reference tables are populated  
4. transactional tables are built using joins  
5. analytical SQL queries are applied  
6. data is visualized in Power BI  

---

## How to Use

### SQL
1. Create a PostgreSQL database  
2. Run `schema.sql`  
3. Run `load_data.sql`  
4. Run `queries.sql`  

### Power BI
1. Open `powerbi/library_dashboard.pbix`  
2. Explore the report pages  

---

## Technologies Used

- PostgreSQL  
- SQL  
- Power BI  
- DAX  
- CSV data workflow  

---

## Notes

This project was built as a portfolio piece to demonstrate practical, job-relevant data analytics skills.

The database design is based on an existing public project and was extended with additional structure, data processing logic, and business-focused analysis.

---

## Author

**Heorhi Darechkin**  
GitHub: https://github.com/gosha1dar  

---

## Acknowledgements

This project is based on the original Library Management System by lijesh010:  
https://github.com/lijesh010/LibraryManagementSystem/tree/main