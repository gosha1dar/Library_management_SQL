-- 1.Retrieve the book title, category, and rental price of all available books.
SELECT
	b.title,
	c.name AS category,
	b.rental_price
FROM books b
JOIN categories c ON b.category_id = c.category_id
WHERE b.status = 'Yes';

-- 2.List the employee names and their respective salaries in descending order of salary.
SELECT
	e.name,
	e.salary
FROM employees e
ORDER BY e.salary DESC;

-- 3.Retrieve the book titles and the corresponding customers who have issued those books.
SELECT 
    b.title,
    m.name AS customer_name,
    r.rental_date
FROM rentals r
JOIN book_copies bc ON bc.copy_id = r.copy_id
JOIN books b ON bc.book_id = b.book_id
JOIN members m ON r.customer_id = m.customer_id;

-- 4.Display the total count of books in each category.
SELECT 
	c.name,
	COUNT(b.book_id) AS book_amount
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
GROUP BY c.name
ORDER BY book_amount DESC;

-- 5.Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT 
	e.name,
	e.position
FROM employees e
WHERE e.salary > 50000
ORDER BY e.salary DESC;

-- 6.List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT 
	m.name,
	m.registration_date
FROM members m
LEFT JOIN rentals r ON m.customer_id = r.customer_id
WHERE m.registration_date < '2022-01-01' 
AND r.customer_id IS NULL;

-- 7.Display the branch numbers and the total count of employees in each branch.
SELECT 
	b.branch_number,
	COUNT(e.employee_id) AS employee_amount
FROM branches b
LEFT JOIN employees e ON b.branch_id = e.branch_id
GROUP BY b.branch_number
ORDER BY employee_amount DESC;

-- 8.Display the names of customers who have issued books in the month of June 2023.
SELECT
	m.name
FROM members m
JOIN rentals r ON m.customer_id = r.customer_id
WHERE r.rental_date >= '2023-06-01'
	AND r.rental_date < '2023-07-01';

-- 9.Retrieve book titles from the book table containing the category "history".
SELECT 
	b.title,
	c.name
FROM books b
JOIN categories c ON b.category_id = c.category_id 
WHERE c.name ILIKE 'History';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT 
	b.branch_number,
	COUNT(e.employee_id) AS employee_amount
FROM branches b
JOIN employees e ON b.branch_id = e.branch_id
GROUP BY b.branch_number
HAVING COUNT(e.employee_id) > 5;