USE TSQLV4;

-  T-SQL Fundamentals, 3rd Edition
-- Chapter 3 Exercises

-- 1-1 Write a query that generates 5 copies of each employee row.

SELECT
    E.empid, E.firstname, E.lastname, N.n
FROM HR.Employees AS E
CROSS JOIN dbo.Nums AS N
WHERE N.n <=5
ORDER BY N.n, empid; 

-- 1-2 Write a query that returns a row for each employee and day in the range June 12, 2016 through June 16, 2016

SELECT E.empid, DATEADD(day, D.n-1, CAST('20160612' AS DATE)) AS dt 
FROM HR.Employees AS E
CROSS JOIN dbo.Nums AS D
WHERE D.n <= DATEDIFF(day, '20160612', '20160616') +1
ORDER BY empid, dt; 

-- Exercise 1-2 Advanced using Tally Table

-- Generates a virtual Nums table of 10,000 numbers entirely in memory
WITH 
  L0 AS (SELECT c FROM (VALUES(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS Table1(c)), -- 10 rows
  L1 AS (SELECT 1 AS c FROM L0 AS A CROSS JOIN L0 AS B), -- 100 rows
  L2 AS (SELECT 1 AS c FROM L1 AS A CROSS JOIN L1 AS B), -- 10,000 rows
  Nums AS (SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n FROM L2)

-- Exercise 1-2 rewritten using the virtual Tally Table
SELECT E.empid, DATEADD(day, N.n - 1, CAST('20160612' AS DATE)) AS dt 
FROM HR.Employees AS E
CROSS JOIN Nums AS N
WHERE N.n <= DATEDIFF(day, '20160612', '20160616') + 1
ORDER BY empid, dt;

-- 3. Return U.S. customers and for each customer return the total number of orders and total quantities

SELECT 
    C.custid, 
    COUNT(DISTINCT O.orderid) AS numorders,
    SUM(OD.qty) AS totalqty
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
    ON C.custid = O.custid
INNER JOIN Sales.OrderDetails AS OD
    ON O.orderid = OD.orderid
WHERE C.country = N'USA'
GROUP BY C.custid;

-- Excercise 3 Advanced: Window Aggregates

WITH AggregatedDetails AS (
    SELECT orderid, SUM(qty) AS totalqty
    FROM Sales.OrderDetails
    GROUP BY orderid
)
SELECT DISTINCT 
    C.custid,
    COUNT(O.orderid) OVER(PARTITION BY C.custid) AS numorders,
    SUM(AD.totalqty) OVER(PARTITION BY C.custid) AS totalqty
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O ON O.custid = C.custid
INNER JOIN AggregatedDetails AS AD ON AD.orderid = O.orderid
WHERE C.country = N'USA';

-- 4. Return customers and their orders, including customers who placed no orders.

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
    ON C.custid = O.custid
ORDER BY O.orderid ASC;

-- 5. Return customers who placed no orders

SELECT C.custid, C.companyname
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
        ON C.custid = O.custid
WHERE O.orderid IS NULL;

-- 6. Return customers with orders placed on Februrary 12, 2016 along with their orders

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
    INNER JOIN Sales.Orders AS O
        ON C.custid = O.custid
WHERE O.orderdate = '20160212';

-- 7. Write a query that returns all customers in the output, but matches
-- them with their respective orders only if they were placed on Feburary 12, 2016.

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
    LEFT JOIN Sales.Orders AS O
        ON C.custid = O.custid
        AND O.orderdate = '20160212';

-- 9. Return all customers, and for each return a Yes/No value depending 
-- on whether the customer placed orders on February 12, 2016.

SELECT C.custid, C.companyname,
    CASE
    WHEN EXISTS (
        SELECT 1
        FROM Sales.Orders AS O
        WHERE O.custid = C.custid
            AND O.orderdate = '20160212'
    ) THEN 'Yes'
    ELSE 'No'
    END AS HasOrderOn20160212
FROM Sales.Customers AS C
    ORDER BY C.custid;

-- Exercise 9 Advanced using Outer Apply

SELECT C.custid, C.companyname,
       ISNULL(O.HasOrder, 'No') AS HasOrderOn20160212
FROM Sales.Customers AS C
OUTER APPLY (
    SELECT TOP (1) 'Yes' AS HasOrder
    FROM Sales.Orders AS Ord
    WHERE Ord.custid = C.custid 
      AND Ord.orderdate = '20160212'
) AS O
ORDER BY C.custid;
