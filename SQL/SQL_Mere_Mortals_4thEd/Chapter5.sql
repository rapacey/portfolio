-- SQL Queries for Mere Mortals, 4th Edition
-- Chapter 5 - Getting More Than Simple Columns

USE SalesOrdersExample
GO

-- 1. What if we adjusted each product price by reducing it 5 percent?

SELECT ProductName, RetailPrice * 0.95 AS FivePercentDiscount
FROM Products;

-- 2. Show me a list of orders made by each customer in descending date order

SELECT OrderNumber, CustomerID, OrderDate
FROM Orders
ORDER BY OrderDate DESC;

-- 3. Compile a list of vendor names and addresses in vendor name order

SELECT VendName, VendStreetAddress, VendCity, VendState, VendZipCode
FROM Vendors
ORDER BY VendName ASC;

USE EntertainmentAgencyExample
GO

-- 1. Give me the names of all our customers by city. 

SELECT CustFirstName, CustLastName, CustCity
FROM Customers
ORDER BY CustCity ASC;

-- 2. List all of the entertainers and their websites

SELECT EntStageName, EntWebPage
FROM Entertainers
ORDER BY EntStageName ASC;

-- 3. Show the date of each agent's first six-month performance review

SELECT AgtFirstName, AgtLastName, 
	DATEADD(day, 180, DateHired) AS ReviewDate
FROM Agents
ORDER BY ReviewDate DESC;

USE SchoolSchedulingExample
GO

-- 1. Give me a list of staff members and show them in descending order of salary

SELECT StfFirstName, StfLastName, Salary
FROM Staff
ORDER BY Salary DESC;

-- 2. Can you give me a staff member phone list?

SELECT StfFirstName, StfLastName, StfPhoneNumber
FROM Staff
ORDER BY StfLastName ASC;

-- 3. List the names of all our students, and order them by the cities they live in

SELECT StudFirstName, StudLastName, StudCity
FROM Students
ORDER BY StudCity ASC;

USE BowlingLeagueExample
GO

-- 1. Show next year's tournament date for each tournament location

SELECT DATEADD(day, 364, TourneyDate) AS DateNextYear
FROM Tournaments;

-- 2. List the name and phone number for each member of the league

SELECT BowlerFirstName, BowlerLastName, BowlerPhoneNumber
FROM Bowlers
ORDER BY BowlerLastName ASC;

-- 3. Give me a listing of each team's lineup

SELECT BowlerFirstName, BowlerLastName, TeamID
FROM Bowlers
ORDER BY TeamID;

