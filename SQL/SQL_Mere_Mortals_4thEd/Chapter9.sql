-- SQL Queries for Mere Mortals, 4th Edition
-- Chapter 9: Outer Joins

--- Sales Orders Questions ---

USE SalesOrdersExample; 

-- 1. Show me customers who have never ordered a helmet.

SELECT c.CustFirstName, c.CustLastName
FROM dbo.Customers AS c

LEFT JOIN (
	SELECT o.CustomerID
	FROM dbo.Orders AS o
	INNER JOIN dbo.Order_Details AS od ON o.OrderNumber = od.OrderNumber
	INNER JOIN dbo.Products AS p ON od.ProductNumber = p.ProductNumber
	WHERE p.ProductName LIKE '%Helmet%'
) AS CustWithHelmets ON c.CustomerID = CustWithHelmets.CustomerID

WHERE CustWithHelmets.CustomerID IS NULL;

-- Alternative query with Not Exists

SELECT c.CustFirstName, c.CustLastName
FROM dbo.Customers AS c
WHERE NOT EXISTS (
	SELECT 1
	FROM dbo.Orders AS o
	INNER JOIN dbo.Order_Details as od ON o.OrderNumber = od.OrderNumber
	INNER JOIN dbo.Products AS p ON od.ProductNumber = p.ProductNumber
	WHERE o.CustomerID = c.CustomerID
		AND p.ProductName LIKE '%Helmet%'
	);

-- Alternative with NOT IN

SELECT c.CustFirstName, c.CustLastName
FROM dbo.Customers AS c
WHERE c.CustomerID NOT IN (
    SELECT o.CustomerID
    FROM dbo.Orders AS o
    INNER JOIN dbo.Order_Details AS od ON o.OrderNumber = od.OrderNumber
    INNER JOIN dbo.Products AS p ON od.ProductNumber = p.ProductNumber
    WHERE p.ProductName LIKE '%Helmet%'
);

-- 2. Display customers who have no sales rep (employees0 in the same ZIP Code.

SELECT c.CustFirstName, c.CustLastName
FROM dbo.Customers AS c
LEFT JOIN dbo.Employees AS e ON c.CustZipCode = e.EmpZipCode
WHERE e.EmployeeID IS NULL;

-- 3. List all products and the dates for any orders.

SELECT DISTINCT p.ProductName, o.OrderDate
FROM dbo.Products AS p
LEFT JOIN dbo.Order_Details AS od ON p.ProductNumber = od.ProductNumber
LEFT JOIN dbo.Orders AS o ON od.OrderNumber = o.OrderNumber;


--- Entertainment Agency Questions ---

USE EntertainmentAgencyExample;

-- 1. Display agents who haven't booked an entertainer.

SELECT a.AgtFirstName, a.AgtLastName
FROM Agents AS a
LEFT JOIN Engagements AS e ON a.agentID = e.AgentID
WHERE e.EngagementNumber IS NULL;

-- 2. List customers with no bookings.

SELECT c.CustFirstName, c.CustLastName
FROM Customers AS c
LEFT JOIN Engagements AS e ON c.CustomerID = e.CustomerID
WHERE e.EngagementNumber IS NULL;

-- 3. List all entertainers and any engagements they have booked.

SELECT ent.EntStageName, eng.EngagementNumber
FROM Entertainers AS ent
LEFT JOIN Engagements AS eng ON ent.EntertainerID = eng.EntertainerID;

--- School Scheduling Questions ---

USE SchoolSchedulingExample;

-- 1. Show me classes that have no students enrolled. 

SELECT c.ClassID
FROM Classes AS c
LEFT JOIN Student_Schedules AS ss ON c.ClassID = ss.ClassID
	AND ss.ClassStatus = 1		-- only join actively enrolled students
WHERE ss.ClassID IS NULL;

-- Alternative: NOT EXISTS

SELECT c.ClassID
FROM Classes AS c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Student_Schedules AS ss 
    WHERE ss.ClassID = c.ClassID
		AND ss.ClassStatus = 1
);

-- 2. Display subjects with no faculty assigned.

SELECT s.SubjectName, fs.StaffID 
FROM dbo.Subjects AS s
LEFT JOIN dbo.Faculty_Subjects AS fs ON s.SubjectID = fs.SubjectID
WHERE fs.StaffID IS NULL;

-- 3. List students not currently enrolled in any classes.

SELECT stu.StudFirstName, stu.StudLastName
FROM Students AS stu
LEFT JOIN Student_Schedules AS sch 
	ON stu.StudentID = sch.StudentID
	AND sch.ClassStatus = 1
WHERE sch.StudentID IS NULL;

-- Cleaner standard approach w/ Not Exists

SELECT stu.StudFirstName, stu.StudLastName
FROM Students AS stu
WHERE NOT EXISTS (
	SELECT 1
	FROM Student_Schedules AS sch
	WHERE sch.StudentID = stu.StudentID
		AND sch.ClassStatus = 1
);

-- 4. List all faculty and the classes they are scheduled to teach.

SELECT s.StfFirstName, s.stfLastname, c.ClassID
FROM Staff AS s
LEFT JOIN Faculty AS f
	ON s.staffID = f.StaffID
LEFT JOIN Faculty_Classes AS fc
	ON f.StaffID = fc.StaffID
LEFT JOIN Classes AS c
	ON fc.ClassID = c.ClassID;

--- Bowling League Questions ---

USE BowlingLeagueExample;

-- 1. Dislplay matches with no game data.

SELECT tm.MatchID
FROM Tourney_Matches AS tm
LEFT JOIN Match_Games AS mg ON tm.MatchID = mg.MatchID
WHERE mg.MatchID IS NULL;

SELECT tm.MatchID
FROM Tourney_Matches AS tm
WHERE NOT EXISTS (
	 SELECT 1
	 FROM Match_Games AS mg
	 WHERE mg.MatchID = tm.MatchID
);

-- 2. Display all tournaments and any matches that have been played.

SELECT t.TourneyID, t.TourneyDate, t.TourneyLocation, tm.MatchID
FROM Tournaments AS t
LEFT JOIN Tourney_Matches AS tm ON t.TourneyID = tm.TourneyID
LEFT JOIN Match_Games AS mg ON tm.MatchID = mg.MatchID;

-- Use Common Table Expression

WITH MatchDetails AS (
    SELECT tm.TourneyID, tm.MatchID, mg.GameNumber
    FROM Tourney_Matches AS tm
    LEFT JOIN Match_Games AS mg ON tm.MatchID = mg.MatchID
)
SELECT t.TourneyID, t.TourneyDate, t.TourneyLocation, md.MatchID
FROM Tournaments AS t
LEFT JOIN MatchDetails AS md ON t.TourneyID = md.TourneyID;

--- Recipes Questions ---

USE RecipesExample;

-- 1. Display missing types of recipes.

SELECT rc.RecipeClassDescription 
FROM Recipe_Classes AS rc
LEFT JOIN Recipes AS r ON rc.RecipeClassID = r.RecipeClassID
WHERE r.RecipeID IS NULL;

SELECT rc.RecipeClassDescription
FROM Recipe_Classes AS rc
WHERE NOT EXISTS (
	SELECT 1
	FROM Recipes AS r
	WHERE r.RecipeClassID = rc.RecipeClassID
);

-- 2. Show me all ingredients and any recipes they're used in.

SELECT i.IngredientName, r.RecipeTitle, ri.Amount
FROM Ingredients AS i
LEFT JOIN Recipe_Ingredients AS ri ON i.IngredientID = ri.IngredientID
LEFT JOIN Recipes AS r ON ri.RecipeID = r.RecipeID;

-- 3. List the salad, soup and main course cateogries and any recipes.

SELECT rc.RecipeClassDescription, r.RecipeTitle
FROM Recipe_Classes AS rc
LEFT JOIN Recipes AS r ON rc.RecipeClassID = r.RecipeClassID
WHERE rc.RecipeClassDescription 
IN ('Salad', 'Soup', 'Main Course');

-- 4. Display all recipe classes and any recipes.

SELECT rc.RecipeClassDescription, r.RecipeTitle
FROM Recipe_Classes AS rc
LEFT JOIN Recipes AS r ON rc.RecipeClassID = r.RecipeClassID;