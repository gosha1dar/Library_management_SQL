CREATE TABLE authors (
    author_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE publishers(
	publishers_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name TEXT NOT NULL	UNIQUE
);

CREATE TABLE categories(
    category_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE branches(
	branch_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	branch_number TEXT NOT NULL UNIQUE,
	address TEXT,
	contact TEXT
);
-- Employees
CREATE TABLE employees(
	employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name TEXT NOT NULL,
	position TEXT,
	salary NUMERIC(10,2),
	branch_id INT REFERENCES branches(branch_id) ON DELETE SET NULL
);

-- Customers
CREATE TABLE members(
	Customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name TEXT NOT NULL,
	address TEXT,
	email TEXT,
	registration_date DATE
);

-- Book Catalogs
CREATE TABLE books(
	book_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	isbn TEXT NOT NULL UNIQUE,
	title TEXT NOT NULL,
	author_id INT REFERENCES authors(author_id) ON DELETE SET NULL,
	publisher_id INT REFERENCES publishers(publishers_id) ON DELETE SET NULL,
	category_id INT REFERENCES categories(category_id) ON DELETE SET NULL,
	rental_price NUMERIC(10,2) DEFAULT 0,
	status TEXT DEFAULT 'available'
);

-- Physical copies (each copy is a separate line)
CREATE TABLE book_copies(
	copy_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	book_id INT NOT NULL references books(book_id) ON DELETE CASCADE,
	barcode TEXT,
	copy_number INT NOT NULL DEFAULT 1,
	status TEXT NOT NULL DEFAULT 'available',
	shelf_location TEXT
);

-- Issue/return transactions
CREATE TABLE rentals(
	rental_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	copy_id INT NOT NULL REFERENCES book_copies(copy_id) ON DELETE RESTRICT,
	customer_id INT NOT NULL REFERENCES members(customer_id) ON DELETE RESTRICT,
	employee_id INT REFERENCES employee(employee_id) ON DELETE SET NULL,
	rental_date DATE NOT NULL,
	due_date DATE,
	return_date DATE
);

-- Penalties
CREATE TABLE Penalties(
	penalty_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	rental_id INT NOT NULL REFERENCES rentals(rental_id) ON DELETE CASCADE,
	amount NUMERIC(10,2) NOT NULL,
	paid BOOLEAN DEFAULT FALSE
);