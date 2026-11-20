-- SQL Queries for Mere Mortals, 4th Edition
-- Chapter 8 - Inner Joins

USE SalesOrdersExample
GO

-- 1. List customers and the dats they placed an order, sorted in order date sequence.

SELECT c.CustFirstName + ' ' + c.CustLastName AS CustFullName, o.OrderDate
FROM Customers AS c
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate DESC;

-- 2. List employees and the customers for whom they booked an order.

SELECT DISTINCT
	e.EmpFirstName + ' ' + e.EmpLastName AS EmpFullName,
	c.CustFirstName + ' ' + c.CustLastName AS CustFullName
FROM Employees AS e
INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID;

-- 3. Display all orders, the products in each order,
-- and the amount owed for each product, in order number sequence.

SELECT o.OrderNumber, p.ProductName, 
	od.QuotedPrice * od.QuantityOrdered AS AmountOwed
FROM Orders as o
INNER JOIN Order_Details AS od ON o.OrderNumber = od.OrderNumber
INNER JOIN Products AS p ON od.ProductNumber = p.ProductNumber
ORDER BY o.OrderNumber ASC;

-- 4. Show me the vendors and the products they supply to us for products that cost less than $100.

SELECT v.VendName, p.ProductName, pv.WholesalePrice
FROM Vendors AS v
INNER JOIN Product_Vendors AS pv ON v.VendorID = pv.VendorID
INNER JOIN Products AS p ON pv.ProductNumber = p.ProductNumber
WHERE pv.WholesalePrice < 100
ORDER BY v.VendName ASC;

-- 5. Show me customers and employees who have the same last name.

SELECT
	c.CustLastName, c.CustLastName,
	e.EmpFirstName, e.EmpLastName
FROM Customers AS c
INNER JOIN Employees AS e ON c.CustLastName = e.EmpLastName;

-- 6. Show me customers and employees who live in the same city.

SELECT c.CustCity, e.EmpCity
FROM Customers AS c
INNER JOIN Employees AS e ON c.CustCity = e.EmpCity;

USE EntertainmentAgencyExample
GO

-- 1. Display agents and the engagement dates they booked, sorted by booking start date.

SELECT a.AgtFirstName, a.AgtLastName, e.StartDate, e.EndDate
FROM Agents AS a
INNER JOIN Engagements AS e ON a.AgentID = e.AgentID
ORDER BY e.StartDate ASC;

-- 2. List customers and the entertainers they booked.

SELECT DISTINCT
	c.CustFirstName, c.CustLastName, ent.EntStageName
FROM Customers AS c
INNER JOIN Engagements AS eng ON c.CustomerID = eng.CustomerID
INNER JOIN Entertainers AS ent ON eng.EntertainerID = ent.EntertainerID
ORDER BY c.CustLastName, ent.EntStageName;

-- 3. Find the agents and entertainers who live in the same postal code.

SELECT a.AgtFirstName, a.AgtlastName, a.AgtZipCode,
	ent.EntStageName, ent.EntZipCode
FROM Agents AS a
INNER JOIN Entertainers AS ent ON a.AgtZipCode = ent.EntZipCode;

USE SchoolSchedulingExample
GO

-- 1. Display buildings and all the classrooms in each building.

SELECT b.BuildingName, c.ClassRoomID
FROM Buildings AS b 
INNER JOIN Class_Rooms AS c ON b.BuildingCode = c.BuildingCode
ORDER BY b.BuildingName;

-- 2. List students and all the classes in which they are currently enrolled.

SELECT s.StudFirstName, s.StudLastName, sub.SubjectName
FROM Students AS s
INNER JOIN Student_Schedules AS sch ON s.StudentID = sch.StudentID
INNER JOIN Classes AS c ON sch.ClassID = c.ClassID
INNER JOIN Subjects AS sub ON c.SubjectID = sub.SubjectID
WHERE sch.ClassStatus = 1	-- Currently enrolled
ORDER BY s.StudLastName, s.StudFirstName;

-- 3. List the faculty staff and the subject each teaches

SELECT 
	st.StfFirstName + ' ' + st.StfLastName AS StaffMember,
	st.Position, sub.SubjectName
FROM Staff AS st
INNER JOIN Faculty_Subjects AS fac ON st.StaffID = fac.StaffID
INNER JOIN Subjects AS sub ON fac.SubjectID = sub.SubjectID
ORDER BY StaffMember ASC;

-- 4. Show me the students who have a grade of 85 or better in art
-- and who also have a grade of 85 or better in any computer course.

-- Query for Art Students
SELECT s.StudentID, s.StudFirstName, s.StudLastName
FROM Students AS s
JOIN Student_Schedules AS ss ON s.StudentID = ss.StudentID
JOIN Classes AS c ON ss.ClassID = c.ClassID
JOIN Subjects AS sub ON c.SubjectID = sub.SubjectID
WHERE sub.SubjectCode LIKE 'ART%' AND ss.Grade >= 85

INTERSECT

-- Query for CIS Students
SELECT s.StudentID, s.StudFirstName, s.StudLastName
FROM Students AS s
JOIN Student_Schedules AS ss ON s.StudentID = ss.StudentID
JOIN Classes AS c ON ss.ClassID = c.ClassID
JOIN Subjects AS sub ON c.SubjectID = sub.SubjectID
WHERE sub.SubjectCode LIKE 'CIS%' AND ss.Grade >= 85;

USE BowlingLeagueExample
GO

-- 1. List the bowling teams and all the team members.

SELECT b.BowlerFirstName, b.BowlerLastName, t.TeamName
FROM Bowlers AS b
INNER JOIN Teams AS t ON b.TeamID = t.TeamID
ORDER BY t.TeamName;

-- 2. Display the bowlers, the matches they played in, and the bowler game scores.

SELECT b.BowlerFirstName, b.BowlerLastName, s.MatchID, s.RawScore, s.HandicapScore
FROM Bowlers AS b
INNER JOIN Bowler_Scores AS s ON b.BowlerID = s.BowlerID
ORDER BY s.MatchID;

-- 3. Find the bowlers who live in the same ZIP Code.

-- Treat the table as two separate lists and find the matches
SELECT 
	b1.BowlerFirstName + ' ' + b1.BowlerLastName AS Bowler1,
	b2.BowlerFirstName + ' ' + b2.BowlerLastName AS Bowler2,
	b1.BowlerZip
FROM Bowlers AS b1
INNER JOIN Bowlers AS b2 ON b1.BowlerZip = b2.BowlerZip
WHERE b1.BowlerID <> b2.BowlerID  -- <> is Not Equal To
ORDER BY b1.BowlerZip;

USE RecipesExample
GO

-- 1. List all the recipes for salads.

SELECT r.RecipeTitle, c.RecipeClassDescription
FROM Recipes AS r
INNER JOIN Recipe_Classes AS c ON r.RecipeClassID = c.RecipeClassID
WHERE c.RecipeClassDescription LIKE '%Salad%';

-- 2. List all recipes that contain a dairy ingredient.

SELECT DISTINCT r.RecipeTitle
FROM Recipes AS r
INNER JOIN Recipe_Ingredients AS ri ON r.RecipeID = ri.RecipeID
INNER JOIN Ingredients AS i ON ri.IngredientID = i.IngredientClassID
INNER JOIN Ingredient_Classes AS ic ON i.IngredientClassID = ic.IngredientClassID
WHERE ic.IngredientClassDescription = 'Dairy';

-- 3. Find the ingredients that use the same default measurement amount.

SELECT
	i1.IngredientName AS Ingredient1,
	i2.IngredientName AS Ingredient2
FROM Ingredients AS i1
-- Self Join
INNER JOIN Ingredients AS i2 ON i1.MeasureAmountID = i2.MeasureAmountID
-- Prevent an ingredient from matching with itselft
WHERE i1.IngredientName <> i2.IngredientName	
ORDER BY i1.IngredientName

-- 4. Show me the recipes that have beef and garlic.

SELECT r.RecipeTitle
FROM Recipes AS r
-- First "copy" of the ingredients list to find Beef
INNER JOIN Recipe_Ingredients AS ri1 ON r.RecipeID = ri1.RecipeID
-- Second "copy" of the ingredients list to find Garlic
INNER JOIN Recipe_Ingredients AS ri2 ON r.RecipeID = ri2.RecipeID
WHERE ri1.IngredientID = 1  -- Beef
  AND ri2.IngredientID = 9; -- Garlic