
CREATE TABLE staging_books(
    ISBN TEXT,
    Book_title TEXT,
    Category TEXT,
    Rental_Price TEXT,
    Status TEXT,
    Author TEXT,
    Publisher TEXT
);

COPY staging_books FROM 'E:\SQL\Staging Tables Librarysystem\Books.csv'
CSV HEADER
DELIMITER ';';

CREATE TABLE staging_customers(
	Customer_id TEXT,
	Customer_name TEXT,
	Customer_address TEXT,
	Reg_date TEXT
);

COPY staging_customers FROM 'E:\SQL\Staging Tables Librarysystem\Customers.csv'
CSV HEADER
DELIMITER ';';

CREATE TABLE staging_branches(
	Branch_no TEXT,
	Manager_id TEXT,
	Branch_address TEXT,
	Contact_no TEXT
);

COPY staging_branches FROM 'E:\SQL\Staging Tables Librarysystem\Branch.csv'
CSV HEADER
DELIMITER ';';

CREATE TABLE staging_employee(
	Emp_id TEXT,
	Emp_name TEXT,
    Position TEXT,
	Salary TEXT,
	branch_no TEXT
);

COPY staging_employee FROM 'E:\SQL\Staging Tables Librarysystem\Employee.csv'
CSV HEADER
DELIMITER ';';

CREATE TABLE staging_Issue_Status(
	Issue_id TEXT,
	Issued_cust TEXT,
	Issued_book_name TEXT,
	Issue_date TEXT,
	Isbn_book TEXT
);

COPY staging_issue_status FROM 'E:\SQL\Staging Tables Librarysystem\Issue_status.csv'
CSV HEADER
DELIMITER ';';

CREATE TABLE staging_Return_Status(
	Return_id TEXT,
	Return_cust TEXT,
	Return_book_name TEXT,
	Return_date TEXT,
	isbn_book2 TEXT
);

COPY staging_Return_status FROM 'E:\SQL\Staging Tables Librarysystem\Return_status.csv'
CSV HEADER
DELIMITER ';';






INSERT INTO authors(name)
SELECT DISTINCT Author
FROM staging_books
WHERE Author IS NOT NULL;

INSERT INTO publishers(name)
SELECT DISTINCT Publisher
FROM staging_books
WHERE Publisher IS NOT NULL;

INSERT INTO categories(name)
SELECT DISTINCT Category
FROM staging_books
WHERE Category IS NOT NULL;

INSERT INTO books(isbn, title, author_id, publisher_id, category_id, rental_price, status)
SELECT
	sb.isbn,
	sb.book_title,
	a.author_id,
	p.publishers_id,
	c.category_id,
	CAST(sb.rental_price AS NUMERIC(10,2)),
	sb.status
FROM staging_books sb
JOIN authors a ON sb.author = a.name
JOIN publishers p ON sb.publisher = p.name
JOIN categories c ON sb.category = c.name;

INSERT INTO members(name, address, registration_date)
SELECT
	customer_name,
	customer_address,
	TO_DATE(reg_date, 'DD-MM-YYYY')
FROM staging_customers;

INSERT INTO branches(branch_number, address, contact)
SELECT DISTINCT
	branch_no,
	branch_address,
	contact_no
FROM staging_branches;

INSERT INTO employees(name, position, salary, branch_id)
SELECT	
	e.emp_name,
	e.position, 
	CAST(e.salary AS NUMERIC(10,2)),
	b.branch_id
FROM staging_employee e
JOIN branches b ON e.branch_no = b.branch_number;

INSERT INTO rentals(customer_id, rental_date, due_date, return_date)
SELECT 
    m.customer_id,
    TO_DATE(i.Issue_date, 'YYYY-MM-DD') AS rental_date,
    TO_DATE(i.Issue_date, 'YYYY-MM-DD') + INTERVAL '14 days' AS due_date,
    TO_DATE(r.Return_date, 'YYYY-MM-DD') AS return_date
FROM staging_issue_status i
JOIN members m ON i.Issued_cust = m.name
LEFT JOIN staging_return_status r ON i.Issue_id = r.Return_id;

-- Generate sample rentals data

INSERT INTO rentals (customer_id, copy_id, rental_date, due_date, return_date)
SELECT 
    m.customer_id,
    bc.copy_id,
    CURRENT_DATE - (RANDOM() * 365)::int AS rental_date,
    CURRENT_DATE - (RANDOM() * 365)::int + 14 AS due_date,
    CASE 
        WHEN RANDOM() > 0.3 
        THEN CURRENT_DATE - (RANDOM() * 365)::int + 10
        ELSE NULL
    END AS return_date
FROM generate_series(1, 300)
CROSS JOIN LATERAL (
    SELECT customer_id FROM members ORDER BY RANDOM() LIMIT 1
) m
CROSS JOIN LATERAL (
    SELECT copy_id FROM book_copies ORDER BY RANDOM() LIMIT 1
) bc;


-- Added Employees
INSERT INTO employees (name, position, salary, branch_id) VALUES
('Alice Smith', 'Librarian', 55000, 1),
('Bob Johnson', 'Assistant', 40000, 1),
('Carol Davis', 'Librarian', 60000, 2),
('David Wilson', 'Assistant', 42000, 2),
('Eve Thompson', 'Manager', 75000, 3);

-- Added Customers
INSERT INTO members (name, registration_date) 
SELECT 
    'Member ' || gs,
    CURRENT_DATE - (RANDOM() * 1000)::int
FROM generate_series(1, 200) gs;

-- Added Book Copies
INSERT INTO book_copies (book_id) 
SELECT book_id
FROM books, generate_series(1, 10) gs;


-- Added Rentals

INSERT INTO rentals (customer_id, copy_id, rental_date, due_date, return_date)
SELECT
    (SELECT customer_id FROM members ORDER BY RANDOM() LIMIT 1) AS customer_id,
    bc.copy_id,
    CURRENT_DATE - (RANDOM() * 365)::int AS rental_date,
    CURRENT_DATE - (RANDOM() * 365)::int + 14 AS due_date,
    CASE 
        WHEN RANDOM() > 0.3 THEN CURRENT_DATE - (RANDOM() * 365)::int + 10
        ELSE NULL
    END AS return_date
FROM book_copies bc
JOIN books b ON bc.book_id = b.book_id
JOIN generate_series(1, CASE 
    WHEN b.title = 'The Histories' THEN 1000
    WHEN b.title = 'A People''s History of the United States' THEN 300
    ELSE 50
END) gs(i) ON TRUE;

-- Clean rentals before reloading sample data
TRUNCATE TABLE penalties, rentals RESTART IDENTITY CASCADE;

-- Generate sample rentals data
INSERT INTO rentals (customer_id, copy_id, rental_date, due_date, return_date)
SELECT
    m.customer_id,
    bc.copy_id,
    CURRENT_DATE - (RANDOM() * 365)::int,
    CURRENT_DATE - (RANDOM() * 365)::int + 14,
    CASE
        WHEN RANDOM() < 0.2 THEN NULL
        ELSE CURRENT_DATE - (RANDOM() * 365)::int + 7
    END
FROM generate_series(1, 5000) gs
JOIN LATERAL (
    SELECT customer_id
    FROM members
    ORDER BY RANDOM()
    LIMIT 1
) m ON TRUE
JOIN LATERAL (
    SELECT copy_id
    FROM book_copies
    ORDER BY RANDOM()
    LIMIT 1
) bc ON TRUE;