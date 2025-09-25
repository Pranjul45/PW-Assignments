-- =============================================
-- SQL Basics Assignment
-- =============================================

-- Question 1: Create employees table with constraints
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email TEXT UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000
);

-- Question 2: Purpose of constraints
/*
Constraints are rules enforced on data columns in a database table to maintain data integrity and accuracy.
They help ensure that data follows specific business rules and relationships.

Common types of constraints:
1. PRIMARY KEY - Uniquely identifies each record in a table
2. FOREIGN KEY - Ensures referential integrity between tables
3. NOT NULL - Ensures a column cannot have NULL values
4. UNIQUE - Ensures all values in a column are unique
5. CHECK - Ensures all values in a column satisfy a specific condition
6. DEFAULT - Sets a default value when no value is specified

Example: A CHECK constraint on age >= 18 prevents underage employees from being added to the system.
*/

-- Question 3: NOT NULL constraint and primary key
/*
The NOT NULL constraint ensures that a column must always contain a value and cannot be left empty.
This is important for critical data like employee names, IDs, or other mandatory fields.

A primary key cannot contain NULL values because its purpose is to uniquely identify each record in a table.
If NULL values were allowed, we wouldn't be able to reliably identify specific records, which would violate
the fundamental purpose of a primary key.
*/

-- Question 4: Adding/removing constraints
/*
Steps to add constraints to an existing table:
1. Use ALTER TABLE statement
2. Specify ADD CONSTRAINT clause
3. Define the constraint type and conditions

Steps to remove constraints:
1. Use ALTER TABLE statement
2. Specify DROP CONSTRAINT clause
3. Provide the constraint name
*/

-- Example: Adding a constraint
ALTER TABLE employees ADD CONSTRAINT chk_salary CHECK (salary > 0);

-- Example: Removing a constraint
ALTER TABLE employees DROP CONSTRAINT chk_salary;

-- Question 5: Consequences of constraint violations
/*
When attempting to insert, update, or delete data that violates constraints, the database system will reject
the operation and return an error. This prevents inconsistent or invalid data from entering the database.

Example error message when violating a UNIQUE constraint:
Error Code: 1062. Duplicate entry 'john@email.com' for key 'email'

Example error message when violating a CHECK constraint:
Error Code: 3819. Check constraint 'chk_age' is violated.
*/

-- Question 6: Adding constraints to products table
-- First, correct the table creation syntax (there were errors in the original)
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Add primary key constraint
ALTER TABLE products MODIFY product_id INT PRIMARY KEY;

-- Add default value for price
ALTER TABLE products ALTER price SET DEFAULT 50.00;

-- Question 7: INNER JOIN between Students and Classes
SELECT s.student_name, c.class_name
FROM Students s
INNER JOIN Classes c ON s.class_id = c.class_id;

-- Question 8: Multiple joins to show all products
SELECT o.order_id, c.customer_name, p.product_name
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
LEFT JOIN Products p ON o.order_id = p.order_id OR p.order_id IS NULL;

-- Question 9: Total sales amount per product
SELECT p.product_name, SUM(s.amount) as total_sales
FROM Sales s
INNER JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name;

-- Question 10: Three-table INNER JOIN
SELECT o.order_id, c.customer_name, SUM(od.quantity) as total_quantity
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY o.order_id, c.customer_name;

-- =============================================
-- SQL Commands Section
-- =============================================

-- 1. Primary keys and foreign keys in maven movies db
/*
Primary Key: A column or set of columns that uniquely identifies each row in a table.
Foreign Key: A column that establishes a relationship between two tables by referencing the primary key of another table.

Difference:
- Primary keys must contain unique values and cannot be NULL
- Foreign keys can contain duplicate values and NULL values
- A table can have only one primary key but multiple foreign keys
- Primary keys uniquely identify records, foreign keys maintain referential integrity
*/

-- 2. List all details of actors
SELECT * FROM actor;

-- 3. List all customer information from DB
SELECT * FROM customer;

-- 4. List different countries
SELECT DISTINCT country FROM country;

-- 5. Display all active customers
SELECT * FROM customer WHERE active = 1;

-- 6. List of all rental IDs for customer with ID 1
SELECT rental_id FROM rental WHERE customer_id = 1;

-- 7. Display films with rental duration greater than 5
SELECT title FROM film WHERE rental_duration > 5;

-- 8. Total films with replacement cost between $15 and $20
SELECT COUNT(*) FROM film WHERE replacement_cost BETWEEN 15 AND 20;

-- 9. Count of unique first names of actors
SELECT COUNT(DISTINCT first_name) FROM actor;

-- 10. First 10 records from customer table
SELECT * FROM customer LIMIT 10;

-- 11. First 3 customers whose first name starts with 'b'
SELECT * FROM customer WHERE first_name LIKE 'b%' LIMIT 3;

-- 12. First 5 movies rated as 'G'
SELECT title FROM film WHERE rating = 'G' LIMIT 5;

-- 13. Customers whose first name starts with "a"
SELECT * FROM customer WHERE first_name LIKE 'a%';

-- 14. Customers whose first name ends with "a"
SELECT * FROM customer WHERE first_name LIKE '%a';

-- 15. First 4 cities which start and end with 'a'
SELECT city FROM city WHERE city LIKE 'a%a' LIMIT 4;

-- 16. Customers whose first name have "NI" in any position
SELECT * FROM customer WHERE first_name LIKE '%ni%';

-- 17. Customers whose first name have "r" in the second position
SELECT * FROM customer WHERE first_name LIKE '_r%';

-- 18. Customers whose first name starts with "a" and at least 5 characters
SELECT * FROM customer WHERE first_name LIKE 'a____%';

-- 19. Customers whose first name starts with "a" and ends with "o"
SELECT * FROM customer WHERE first_name LIKE 'a%o';

-- 20. Films with PG and PG-13 rating using IN operator
SELECT title FROM film WHERE rating IN ('PG', 'PG-13');

-- 21. Films with length between 50 to 100 using BETWEEN
SELECT title FROM film WHERE length BETWEEN 50 AND 100;

-- 22. Top 50 actors using LIMIT
SELECT * FROM actor LIMIT 50;

-- 23. Distinct film IDs from inventory table
SELECT DISTINCT film_id FROM inventory;

-- =============================================
-- Functions Section
-- =============================================

-- Question 1: Total number of rentals
SELECT COUNT(*) as total_rentals FROM rental;

-- Question 2: Average rental duration
SELECT AVG(rental_duration) as avg_rental_duration FROM film;

-- Question 3: Customer names in uppercase
SELECT UPPER(first_name), UPPER(last_name) FROM customer;

-- Question 4: Month from rental date
SELECT rental_id, MONTH(rental_date) as rental_month FROM rental;

-- Question 5: Rental count per customer
SELECT customer_id, COUNT(*) as rental_count 
FROM rental 
GROUP BY customer_id;

-- Question 6: Total revenue per store
SELECT s.store_id, SUM(p.amount) as total_revenue
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id;

-- Question 7: Rental count per category
SELECT c.name as category, COUNT(r.rental_id) as rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Question 8: Average rental rate per language
SELECT l.name as language, AVG(f.rental_rate) as avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

-- =============================================
-- Joins Section
-- =============================================

-- Question 9: Movie title with customer who rented it
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

-- Question 10: Actors in "Gone with the Wind"
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

-- Question 11: Customer names with total amount spent
SELECT c.first_name, c.last_name, SUM(p.amount) as total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Question 12: Movies rented by customers in a specific city
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ct.city = 'London'
GROUP BY c.customer_id, f.film_id;

-- Question 13: Top 5 rented movies
SELECT f.title, COUNT(r.rental_id) as rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;

-- Question 14: Customers who rented from both stores
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

-- =============================================
-- Window Functions Section
-- =============================================

-- 1. Rank customers by total amount spent
SELECT 
    customer_id,
    first_name,
    last_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) as spending_rank
FROM (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) as total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) customer_spending;

-- 2. Cumulative revenue per film over time
SELECT 
    f.title,
    p.payment_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) as cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id;

-- 3. Average rental duration for films with similar lengths
SELECT 
    film_id,
    title,
    length,
    AVG(rental_duration) OVER (PARTITION BY length) as avg_rental_duration_similar_length
FROM film;

-- 4. Top 3 films in each category by rental count
WITH film_rentals AS (
    SELECT 
        f.film_id,
        f.title,
        c.name as category,
        COUNT(r.rental_id) as rental_count,
        ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) as rank_in_category
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY f.film_id, f.title, c.name
)
SELECT film_id, title, category, rental_count
FROM film_rentals
WHERE rank_in_category <= 3;

-- 5. Difference from average rentals per customer
SELECT 
    customer_id,
    rental_count,
    rental_count - AVG(rental_count) OVER () as difference_from_avg
FROM (
    SELECT customer_id, COUNT(*) as rental_count
    FROM rental
    GROUP BY customer_id
) customer_rentals;

-- =============================================
-- Normalization & CTE Section
-- =============================================

-- 1. First Normal Form (1NF)
/*
Table that might violate 1NF: film_actor table if it stores multiple actor IDs in a single column
Normalization: Create a proper junction table with one actor per row per film
*/

-- 2. Second Normal Form (2NF)
/*
Check if a table has partial dependencies. For example, in the film table, if we had director details
that depend only on director_id but not on the entire primary key, it would violate 2NF.
*/

-- 3. Third Normal Form (3NF)
/*
The address table might violate 3NF if it contains city names that depend on city_id which depends on address_id.
We already have proper normalization with separate city and country tables.
*/

-- 5. CTE Basics: Actors and their film count
WITH actor_film_count AS (
    SELECT 
        a.actor_id,
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) as film_count
    FROM actor a
    LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT * FROM actor_film_count;

-- 6. CTE with Joins: Film and language info
WITH film_language_info AS (
    SELECT 
        f.title,
        l.name as language_name,
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_language_info;

-- 7. CTE for Aggregation: Customer revenue
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) as total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM customer_revenue;

-- 8. CTE with Window Functions: Film ranking by rental duration
WITH film_ranking AS (
    SELECT 
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) as duration_rank
    FROM film
)
SELECT * FROM film_ranking;

-- 9. CTE and Filtering: Customers with more than 2 rentals
WITH frequent_customers AS (
    SELECT customer_id, COUNT(*) as rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 2
)
SELECT c.*, fc.rental_count
FROM customer c
JOIN frequent_customers fc ON c.customer_id = fc.customer_id;

-- 10. CTE for Date Calculations: Monthly rentals
WITH monthly_rentals AS (
    SELECT 
        YEAR(rental_date) as year,
        MONTH(rental_date) as month,
        COUNT(*) as rental_count
    FROM rental
    GROUP BY YEAR(rental_date), MONTH(rental_date)
)
SELECT * FROM monthly_rentals ORDER BY year, month;

-- 11. CTE and Self-Join: Actor pairs in same films
WITH actor_pairs AS (
    SELECT 
        fa1.actor_id as actor1_id,
        fa2.actor_id as actor2_id,
        f.title as film_title
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
    JOIN film f ON fa1.film_id = f.film_id
)
SELECT * FROM actor_pairs LIMIT 10;

