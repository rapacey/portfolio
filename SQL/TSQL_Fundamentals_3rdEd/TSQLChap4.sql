USE TSQLV4;

-  T-SQL Fundamentals, 3rd Edition
-- Chapter 4 Exercises - Subqueries

-- 1. Write a query that returns all orders placed on the last day of 
-- activity that can be found in the Orders table

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = (SELECT MAX(O.orderdate) FROM Sales.Orders AS O);

-- 1b Alternate solution to same query

DECLARE @maxdate AS DATE = (SELECT MAX(orderdate) FROM Sales.Orders);

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = @maxdate;

-- 2. Write a query that returns all orders placed by the customer(s)
-- who placed the highest number of orders. More than 1 customer may have
-- the same number of orders.

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders
WHERE custid IN (SELECT TOP (1) WITH TIES O.custid
                FROM Sales.Orders AS O
                GROUP BY O.custid
                ORDER BY COUNT(*) DESC);

-- 2b Alternate Solution using CTE

WITH RankedCustomers AS (
    SELECT custid, orderid, orderdate, empid,
           DENSE_RANK() OVER(ORDER BY COUNT(*) OVER(PARTITION BY custid) DESC) AS RankOrder
    FROM Sales.Orders
)
SELECT custid, orderid, orderdate, empid
FROM RankedCustomers
WHERE RankOrder = 1;

-- 3. Write a query that returns employees who did not place orders 
-- on or after May 1, 2016

SELECT E.empid, E.firstname, E.lastname
FROM HR.employees AS E
WHERE E.empid NOT IN (SELECT O.empid
                 FROM Sales.Orders AS O
                 WHERE O.orderdate >= '20160501')
ORDER BY E.empid;

-- 4. Write a query that returns countries where there are customers but 
-- not employees.

SELECT DISTINCT C.country
FROM Sales.Customers AS C
WHERE NOT EXISTS
        (SELECT * FROM HR.Employees AS E
         WHERE E.country = C.country)
ORDER BY C.country ASC;

-- 5. Write a query that returns for each customer all orders placed on 
-- the customer's last day of activity.

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1
WHERE orderdate = 
    (SELECT MAX(O2.orderdate)
    FROM Sales.Orders AS O2
    WHERE O2.custid = O1.custid);

-- 6. Write a query that returns customers who placed orders in 2015
-- but not in 2016

SELECT C.custid, C.companyname
FROM Sales.Customers AS C
WHERE C.custid IN   
    (SELECT O.custid FROM Sales.Orders AS O 
    WHERE O.orderdate >= '20150101' AND O.orderdate < '20160101')
    AND C.custid NOT IN
    (SELECT O.custid FROM Sales.Orders AS O 
    WHERE O.orderdate >= '20160101' AND O.orderdate < '20170101');

-- 6 Alternate Solution using Set Operators

SELECT C.custid, C.companyname
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O ON C.custid = O.custid
WHERE O.orderdate >= '20150101' AND O.orderdate < '20160101'

EXCEPT 

SELECT C.custid, C.companyname
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O ON C.custid = O.custid
WHERE O.orderdate >= '20160101' AND O.orderdate < '20170101';

-- 7. Write a query that returns customers who ordered product 12.

SELECT C.custid, C.companyname
FROM Sales.Customers AS C
WHERE C.custid IN
    (SELECT O.custid
    FROM Sales.Orders AS O
    WHERE O.orderid IN
        (SELECT OD.orderid
        FROM Sales.OrderDetails AS OD
        WHERE OD.productid = 12));

-- 8. Write a query that calculates a running total quantity for each
-- customer and month.

SELECT custid, ordermonth, qty, 
    (SELECT SUM(CO2.qty)
    FROM Sales.CustOrders AS CO2
    WHERE CO2.custid = CO1.custid
    AND CO2.ordermonth <= CO1.ordermonth)
    AS runqty
FROM Sales.CustOrders AS CO1
ORDER BY custid, ordermonth;

-- Running Total Quantities with Aggregate Window Function

SELECT custid, ordermonth, qty,
       SUM(qty) OVER(PARTITION BY custid 
                     ORDER BY ordermonth 
                     ROWS UNBOUNDED PRECEDING) AS runqty
FROM Sales.CustOrders;

-- 10. Write a query that returns for each order the number of days that 
-- passed since the same customer's previous order. To determine recency
-- among orders, use orderdate as the primary sort element and orderid
-- as the tiebreaker.

SELECT custid, orderdate, orderid,
    DATEDIFF(day,
        (SELECT MAX(O2.orderdate)
         FROM Sales.Orders AS O2
         WHERE O2.custid = O1.custid
           AND (O2.orderdate < O1.orderdate
                OR (O2.orderdate = O1.orderdate AND O2.orderid < O1.orderid))),
        orderdate) AS diff 
FROM Sales.Orders AS O1
ORDER BY custid, orderdate, orderid; 

-- Alternate Solution using SQL built-in function LAG()

WITH OrderOffsets AS (
    SELECT custid, orderdate, orderid,
           LAG(orderdate) OVER(PARTITION BY custid 
                               ORDER BY orderdate, orderid) AS prev_orderdate
    FROM Sales.Orders
)
SELECT custid, orderdate, orderid,
       DATEDIFF(day, prev_orderdate, orderdate) AS diff
FROM OrderOffsets
ORDER BY custid, orderdate, orderid;

