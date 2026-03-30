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

-- 11. Top 10 most rented books
SELECT
	b.title,
	COUNT(r.rental_id) AS amount_of_rents,
    RANK() OVER (ORDER BY COUNT(r.rental_id) DESC) AS rank
FROM books b
JOIN book_copies bc ON b.book_id = bc.book_id
JOIN rentals r ON bc.copy_id = r.copy_id
GROUP BY b.book_id, b.title
ORDER BY amount_of_rents DESC
LIMIT 10;

-- 12. Rank customers by number of rentals
WITH number_of_rentals AS(
SELECT
	m.customer_id,
	m.name,
	COUNT(r.rental_id) AS rental_amount
FROM members m
JOIN rentals r ON m.customer_id = r.customer_id
GROUP BY m.customer_id, m.name
)

SELECT 
	customer_id,
	name,
	rental_amount,
	DENSE_RANK() OVER(ORDER BY rental_amount DESC) AS customer_rank
FROM number_of_rentals nor
 
 -- 13. Monthly rentals trend
WITH monthly_rentals AS (
    SELECT 
        DATE_TRUNC('month', rental_date) AS month,
        COUNT(*) AS rentals_count
    FROM rentals
    GROUP BY month
)
SELECT 
    month,
    rentals_count,
    LAG(rentals_count) OVER (ORDER BY month) AS previous_month,
    rentals_count - LAG(rentals_count) OVER (ORDER BY month) AS growth
FROM monthly_rentals
ORDER BY month

-- 14. Running total of rentals

SELECT 
	DATE_TRUNC('month', rental_date) AS month,
	COUNT(*) AS monthly_rentals,
	SUM(COUNT(*)) OVER (ORDER BY DATE_TRUNC('month', rental_date)) AS running_total
FROM rentals
GROUP BY month
ORDER BY month

-- 15. Top categories by rentals

SELECT
	c.category_id,
	c.name,
	COUNT(r.rental_id) AS rents_amount
FROM categories c
JOIN books b ON c.category_id = b.category_id
JOIN book_copies bc ON b.book_id = bc.book_id
JOIN rentals r ON bc.copy_id = r.copy_id
GROUP BY c.category_id, c.name
ORDER BY rents_amount DESC
LIMIT 10

-- 16. Overdue rentals
SELECT 
    m.name,
    r.rental_date,
    r.due_date,
    r.return_date,
    (r.return_date - r.due_date) AS delay
FROM rentals r
JOIN members m ON r.customer_id = m.customer_id
WHERE r.return_date > r.due_date

-- 17. Branch performance (rentals count)
SELECT 
	b.branch_id,
	COUNT(r.rental_id) AS rentals_amount,
	RANK() OVER(ORDER BY COUNT(r.rental_id) DESC) AS rank
FROM branches b
JOIN employees e ON b.branch_id = e.branch_id
JOIN rentals r ON e.employee_id = r.employee_id
GROUP BY b.branch_id

-- 18. Customer segmentation
SELECT
	m.name,
	COUNT(r.rental_id) AS rentals_amount,
	CASE
		WHEN COUNT(r.rental_id) >= 10 THEN 'High Activity'
		WHEN COUNT(r.rental_id) >= 5 THEN 'Medium Activity'
		ELSE 'Low Activity'
	END AS segment
FROM members m
LEFT JOIN rentals r ON m.customer_id = r.customer_id
GROUP BY m.name

-- 19. Percentage of rentals by category
WITH category_counts AS (
    SELECT 
        c.name,
        COUNT(*) AS rentals_amount
    FROM rentals r
    JOIN book_copies bc ON r.copy_id = bc.copy_id
    JOIN books b ON bc.book_id = b.book_id
    JOIN categories c ON b.category_id = c.category_id
    GROUP BY c.name
)
SELECT 
    name,
    rentals_amount,
    ROUND(100.0 * rentals_amount / SUM(rentals_amount) OVER (), 2) AS percentage
FROM category_counts

-- 20. Most recent rental per customer
SELECT *
FROM (
    SELECT 
        m.name,
        r.rental_date,
        ROW_NUMBER() OVER (PARTITION BY m.customer_id ORDER BY r.rental_date DESC) AS recent_rental
    FROM members m
    JOIN rentals r ON m.customer_id = r.customer_id
) t
WHERE recent_rental = 1