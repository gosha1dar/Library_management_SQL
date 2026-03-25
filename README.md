# Library Management System (SQL)

This project is a SQL-based library management system that includes database schema, staging data loading, and analytical queries to extract insights from library operations. 

## Project Structure

- **schema.sql** – Defines the database tables, relationships, and constraints.  
- **load_data.sql** – Loads data from CSV files into staging tables and populates the main tables.  
- **queries.sql** – Contains analytical queries for extracting insights from the library data.

## Analytical Queries Included

1. Retrieve the book title, category, and rental price of all available books.  
2. List employee names and their respective salaries in descending order.  
3. Retrieve book titles and corresponding customers who have issued those books.  
4. Display the total count of books in each category.  
5. Retrieve employee names and positions for employees with salaries above Rs.50,000.  
6. List customer names who registered before 2022-01-01 and have not issued any books yet.  
7. Display branch numbers and the total count of employees in each branch.  
8. Display names of customers who have issued books in June 2023.  
9. Retrieve book titles in the "History" category.  
10. Retrieve branch numbers with more than 5 employees.

## How to Use

1. Run `schema.sql` to create the database structure.  
2. Run `load_data.sql` to populate the tables with staging data.  
3. Run `queries.sql` to perform analytics and view results.

## Technologies Used

- PostgreSQL (or any SQL-compatible database)  
- SQL scripts for schema definition, data loading, and queries

## Author

Heorhi Darechkin

## Acknowledgements

This project is based on the original [Library Management System](https://github.com/lijesh010/LibraryManagementSystem/tree/main) by lijesh010.