# Library Management System (SQL)

This repository contains a SQL-based Library Management System designed as a portfolio project to demonstrate database design, data loading, and analytical querying skills.

If you are reviewing this project as a recruiter or hiring manager, this repository shows how I approach a data problem end to end: from schema design and data preparation to business-style analysis.

---

## Project Overview

The project models a small library environment with core entities such as books, members, employees, branches, rentals, authors, publishers, and categories.

It includes:

- a normalized relational database schema
- staging tables for CSV data import
- data loading and transformation logic
- basic and advanced analytical SQL queries

---

## What This Project Demonstrates

This project highlights practical SQL skills, including:

- database normalization
- foreign key relationships
- staging-to-target data loading workflow
- `JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`
- `CTE` usage
- window functions such as `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, and `LAG()`
- analytical thinking through business-oriented queries

---

## Project Structure

- `schema.sql` — creates the database structure, relationships, and constraints
- `load_data.sql` — creates staging tables, loads CSV data, and transfers it into the main schema
- `queries.sql` — contains basic and advanced analytical SQL queries
- `README.md` — project documentation

---

## Analytical Topics Covered

The SQL queries in this project cover topics such as:

- available books and book pricing
- employee salary analysis
- book issuance and customer activity
- category-level book counts
- inactive customers
- branch-level staffing
- monthly rental trends
- top rented books
- customer segmentation
- overdue rentals
- category rental share
- most recent rental per customer

---

## Data Workflow

The data pipeline used in this project follows a simple and practical approach:

1. CSV files are loaded into staging tables
2. staging data is cleaned and mapped to the final schema
3. reference tables are populated first
4. transactional tables are filled using joins and transformations
5. analytical queries are run on the final normalized structure

---

## How to Use

1. Create a PostgreSQL database.
2. Run `schema.sql` to create the database structure.
3. Run `load_data.sql` to load and transform the data.
4. Run `queries.sql` to explore the analytical results.

---

## Technologies Used

- PostgreSQL
- SQL
- CSV data import workflow
- Data normalization and analytical querying

---

## Notes

This project was built as a learning and portfolio piece, with the goal of demonstrating practical SQL skills in a realistic library-management scenario.

The database design was based on an original public project and extended with additional structure, data loading logic, and more advanced analysis.

---

## Author

**Heorhi Darechkin**  
GitHub: [gosha1dar](https://github.com/gosha1dar)

---

## Acknowledgements

This project is based on the original [Library Management System](https://github.com/lijesh010/LibraryManagementSystem/tree/main) by lijesh010.