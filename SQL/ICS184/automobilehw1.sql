-- ICS 184 Summer 2006
-- Assignment #1

USE automobile;
GO

-- 1. Find the names of all salespeople who have ever worked for the company at any dealership.

SELECT DISTINCT s.salesperson_name
FROM salesperson AS s
JOIN works_at AS w ON s.salesperson_id = w.salesperson_id
WHERE w.month_worked IS NOT NULL;

-- 2. Find the names of all salespeople who are managed by a salesperson named "Joe Jones".

SELECT s.salesperson_name AS Salesperson_Name
FROM salesperson AS s
JOIN reports_to AS r ON s.salesperson_id = r.salesperson_id
JOIN salesperson AS m ON r.managing_salesperson_id = m.salesperson_id
WHERE m.salesperson_name = 'Joe Jones';

-- 3. List the VIN, make, model, year, and mileage of all cars in the inventory of the dealership named "Irvine Toyota Sales".

SELECT c.vin, c.make, c.model, c.year, c.mileage
FROM car AS c
JOIN inventory AS i ON c.vin = i.vin
JOIN dealership AS d ON i.dealership_id = d.dealership_id
WHERE d.dealership_name = 'Irvine Toyota Sales';

-- 4. List the VIN, year, and mileage of all Toyota Camrys in the inventory of the dealership named "Irvine Toyota Sales". (Note that a Toyota Camry is indicated by the make being "Toyota" and the model being "Camry".)

SELECT c.vin, c.year, c.mileage
FROM car AS c
JOIN inventory AS i ON c.vin = i.vin
JOIN dealership AS d ON i.dealership_id = d.dealership_id
WHERE d.dealership_name = 'Irvine Toyota Sales' AND c.make = 'Toyota' AND c.model = 'Camry';

-- 5. Find the name and Social Security Number of all customers who bought a car at a dealership located in a state other than the state in which they live.

SELECT c.customer_name, c.social_security_number
FROM customer AS c
JOIN sale AS s ON c.social_security_number = s.social_security_number
JOIN dealership AS d ON s.dealership_id = d.dealership_id
WHERE d.dealership_state <> c.customer_state;

-- 6. Find the names of all salespeople who do not have a manager.

SELECT s.salesperson_name AS Salesperson_Name
FROM salesperson AS s
LEFT JOIN reports_to AS r ON s.salesperson_id = r.salesperson_id
WHERE r.managing_salesperson_id IS NULL;

-- 7. Find the name of the salesperson that made the largest base salary working at the dealership named "Irvine Toyota Sales" during January 2026.

SELECT TOP 1 s.salesperson_name
FROM salesperson AS s
JOIN works_at AS w ON s.salesperson_id = w.salesperson_id
JOIN dealership AS d ON w.dealership_id = d.dealership_id
WHERE d.dealership_name = 'Irvine Toyota Sales' 
    AND w.month_worked = '2026-01-01'
ORDER BY w.base_salary_for_month DESC;

-- 8. Find the salesperson ID and name of all salespeople who have worked at each one of the company's dealerships at some point in time.

SELECT s.salesperson_name, s.salesperson_id
FROM salesperson AS s
JOIN works_at AS w ON s.salesperson_id = w.salesperson_id
GROUP BY s.salesperson_id, s.salesperson_name
HAVING COUNT(DISTINCT w.dealership_id) = (SELECT COUNT(*) FROM dealership);

-- 9. List the name, salesperson ID, and total sales amount for each salesperson who has ever sold at least one car. The total sales amount for a salesperson is the sum of the sale prices of all cars ever sold by that salesperson.

SELECT 
    s.salesperson_id, 
    s.salesperson_name, 
    SUM(sa.sale_price) AS Total_Sales
FROM salesperson AS s
JOIN sale sa ON s.salesperson_id = sa.salesperson_id
GROUP BY s.salesperson_id, s.salesperson_name;

-- 10. Find the name and salesperson ID of the salesperson who sold the most cars for the company at dealerships located in California between March 1, 2006 and March 31, 2006.

SELECT TOP 1 WITH TIES 
    s.salesperson_id, 
    s.salesperson_name,
    COUNT(sa.vin) AS Cars_Sold
FROM sale AS sa
JOIN salesperson AS s ON sa.salesperson_id = s.salesperson_id
JOIN dealership AS d ON sa.dealership_id = d.dealership_id
WHERE d.dealership_state = 'CA'
    AND sa.sale_date BETWEEN '2026-01-01' AND '2026-03-01'
GROUP BY s.salesperson_id, s.salesperson_name
ORDER BY COUNT(*) DESC;

-- 11. Calculate the payroll for the month of January 2026.
-- The payroll consists of the name, salesperson ID, and gross pay for each salesperson who worked that month.
-- The gross pay is calculated as the base salary at each dealership employing the salesperson that month, along with the total commission for the salesperson that month.
-- The total commission for a salesperson in a month is calculated as 7% of the profit made on all cars sold by the salesperson that month.
-- The profit made on a car is the difference between the sale price and the invoice price of the car. (Assume, for simplicity, that cars are never sold for less than the invoice price

WITH MonthlySalary AS (
    -- Calculate total base salary per person for January 2026
    SELECT salesperson_id, SUM(base_salary_for_month) AS total_base
    FROM works_at
    WHERE month_worked = '2026-01-01'
    GROUP BY salesperson_id
),
MonthlyCommission AS (
    -- Calculate total commission for March 2006
    SELECT sa.salesperson_id,
        SUM((sa.sale_price - c.invoice_price) * 0.07) AS total_comm
    FROM sale sa
    JOIN car c ON sa.vin = c.vin
    WHERE sa.sale_date BETWEEN '2006-01-01' AND '2006-01-31'
    GROUP BY sa.salesperson_id
)
SELECT
    s.salesperson_name,
    s.salesperson_id,
    CAST(ISNULL(ms.total_base, 0) + ISNULL(mc.total_comm, 0) AS DECIMAL(18,2)) AS gross_pay
FROM salesperson AS s
LEFT JOIN MonthlySalary AS ms ON s.salesperson_id = ms.salesperson_id
LEFT JOIN MonthlyCommission AS mc ON s.salesperson_id = mc.salesperson_id
WHERE ms.total_base IS NOT NULL OR mc.total_comm IS NOT NULL;
