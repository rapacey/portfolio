-- Practice SQL Problems: Automobile Database

-- 1. Inventory Check: Retrieve the make, model, and year of all cars currently located at the 'Irvine Toyota Sales' dealership.

SELECT c.make, c.model, c.year
FROM car AS c
JOIN inventory As i ON c.vin = i.vin
JOIN dealership AS d ON i.dealership_id = d.dealership_id
WHERE d.dealership_name = 'Irvine Toyota Sales';

-- 2. Sales Performance: List the names of all salespersons who have sold at least one car with a sale_price greater than $30,000.

SELECT DISTINCT sp.salesperson_name
FROM salesperson AS sp
JOIN sale AS sal ON sp.salesperson_id = sal.salesperson_id
WHERE sal.sale_price > 30000;

-- 3. Customer Geography: Find the names of all customers who live in the same state as the dealership where they purchased their car.

SELECT c.customer_name, c.customer_state, d.dealership_state
FROM customer AS c
JOIN sale AS s ON c.social_security_number = s.social_security_number
JOIN dealership AS d ON s.dealership_id = d.dealership_id
WHERE c.customer_state = d.dealership_state;

-- 4. Managerial Oversight: List the names of all salespersons who report to 'Angela Manager'.

-- Define the logical instance of managers first
WITH ManagerList AS (
    SELECT 
        salesperson_id AS m_id,
        salesperson_name AS m_name
    FROM salesperson
)
-- Run the main query using that CTE
SELECT s.salesperson_name AS Employee_Name
FROM salesperson AS s
JOIN reports_to AS r ON s.salesperson_id = r.salesperson_id
JOIN ManagerList AS m ON r.managing_salesperson_id = m.m_id
WHERE m.m_name = 'Angela Manager';

-- 5. Low-Mileage Deals: Find the vin, make, and model of all cars that have less than 5,000 miles and are listed with an asking_price under $25,000.

SELECT
    c.vin AS vin,
    c.make AS make,
    c.model AS model
FROM car AS c
WHERE c.mileage < 5000 AND c.asking_price < 25000;

-- 6. Profitability Analysis: For every completed sale, display the vin and the difference between the sale_price and the invoice_price.

SELECT
    s.vin,
    (s.sale_price - c.invoice_price) AS profit
FROM sale AS s
JOIN car AS c ON s.vin = c.vin;

-- 7. Personnel Locations: List the names of all salespersons and the name of the dealership where they worked during the month of January 2026.

SELECT 
    s.salesperson_name,
    d.dealership_name
FROM salesperson AS s
JOIN works_at AS w ON s.salesperson_id = w.salesperson_id 
JOIN dealership AS d ON w.dealership_id = d.dealership_id
WHERE w.month_worked = '2026-01-01';

-- 8. Unsold Inventory: Identify all cars (display vin, make, and model) that are currently in the inventory table but do not have a corresponding entry in the sale table.

SELECT
    c.vin,
    c.make,
    c.model
FROM car AS c
-- Inventory tabe is the list of what we should have
JOIN inventory AS i ON c.vin = i.vin
-- All rows from inventory, even if no matching sale
LEFT JOIN sale AS s ON c.vin = s.vin
-- Find the unsold cars
WHERE s.vin IS NULL;

-- 9. Regional Sales Volume: Count how many total sales were made at dealerships located in the state of 'CA'.

SELECT COUNT(*) AS total_ca_sales
FROM sale AS s
JOIN dealership AS d ON s.dealership_id = d.dealership_id
WHERE d.dealership_state = 'CA';

-- 10. Salary High-Rollers: Retrieve the names of salespersons who had a base_salary_for_month greater than $4,000 in any month.

SELECT 
    s.salesperson_name,
    w.base_salary_for_month
FROM salesperson AS s
JOIN works_at AS w ON s.salesperson_id = w.salesperson_id
WHERE w.base_salary_for_month > 4000;