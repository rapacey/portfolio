-- SQL Queries for Mere Mortals, 4th Edition
-- Chapter 10 Homework - Unions

-- Sales Orders
-- 1. List the customers who ordered a helmet together with the vendors who provide helmets.

USE SalesOrdersExample
GO

SELECT 
    c.CustLastName || ', ' ||
    c.CustFirstName AS FullName,
    p.ProductName, 
    'Customer' AS RowID

FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.Order_Details AS od
    ON o.OrderNumber = od.OrderNumber
INNER JOIN dbo.Products AS p
    ON od.ProductNumber = p.ProductNumber

WHERE p.ProductName LIKE '%helmet%'

UNION 

SELECT 
    v.VendName, 
    p.ProductName, 
    'Vendor' AS RowID

FROM dbo.Vendors AS v
INNER JOIN dbo.Product_Vendors AS pv
    ON v.VendorID = pv.VendorID
INNER JOIN dbo.Products AS p
    ON pv.ProductNumber = p.ProductNumber

WHERE p.ProductName LIKE '%helmet%';

-- Entertainment Agency
-- 1. Display a combined list of customers and entertainers.

USE EntertainmentAgencyExample
GO

SELECT 
    c.CustFirstName || ', ' || c.CustLastName AS Name,
    'Customer' AS RowID
FROM dbo.Customers AS c
UNION
SELECT e.EntStageName, 'Entertainer' AS RowID
FROM dbo.Entertainers AS e;

-- 2. Produce a list of customers who like contemporary music together with
-- a list of entertainers who play contemporary music.

SELECT Customers.CustFirstName || ', ' || Customers.CustLastName AS FullName,
       Musical_Styles.StyleName, 'Customer' AS RowID

FROM dbo.Customers 

INNER JOIN dbo.Musical_Preferences ON Customers.CustomerID = Musical_Preferences.CustomerID
INNER JOIN dbo.Musical_Styles ON Musical_Preferences.StyleID = Musical_Styles.StyleID

WHERE Musical_Styles.StyleID = 10

UNION

SELECT Entertainers.EntStageName, Musical_Styles.StyleName,
       'Entertainer' AS RowID

FROM dbo.Entertainers 
INNER JOIN Entertainer_Styles ON Entertainers.EntertainerID = Entertainer_Styles.EntertainerID
INNER JOIN dbo.Musical_Styles ON Entertainer_Styles.StyleID = Musical_Styles.StyleID

WHERE Entertainer_Styles.StyleID = 10;

-- School Scheduling
-- 1. Create a mailing list for students and staff, sorted by ZIP Code.

USE SchoolSchedulingExample
GO

SELECT Students.StudFirstName,
       Students.StudLastName,
       Students.StudStreetAddress,
       Students.StudCity,
       Students.StudState,
       Students.StudZipCode
FROM dbo.Students

UNION

SELECT Staff.StfFirstName,
       Staff.StfLastName,
       Staff.StfStreetAddress,
       Staff.StfCity,
       Staff.StfState,
       Staff.StfZipCode

FROM dbo.Staff
ORDER BY StudZipCode;

-- Bowling League
-- 1. Find the bowlers who had a raw score of 165 or better at Thunderbird Lanes
-- combined with bowlers who had a raw score of 150 or better at Bolero Lanes.

USE BowlingLeagueExample
GO

-- Solve question with UNION

SELECT 
       CONCAT(b.BowlerFirstName, ' ', b.BowlerMiddleInit, ' ', b.BowlerLastName) AS BowlerName,
       t.TourneyLocation,
       bs.RawScore

FROM dbo.Bowlers AS b

JOIN dbo.Bowler_Scores AS bs ON b.BowlerID = bs.BowlerID
JOIN dbo.Tourney_Matches AS tm ON bs.MatchID = tm.MatchID
JOIN dbo.Tournaments AS t ON tm.TourneyID = t.TourneyID

WHERE t.TourneyLocation = 'Thunderbird Lanes' 
       AND bs.RawScore >= 165

UNION 

SELECT 
       CONCAT(b.BowlerFirstName, ' ', b.BowlerMiddleInit, ' ',b.BowlerLastName) AS BowlerName,
       t.TourneyLocation,
       bs.RawScore

FROM dbo.Bowlers AS b

JOIN dbo.Bowler_Scores AS bs ON b.BowlerID = bs.BowlerID
JOIN dbo.Tourney_Matches AS tm ON bs.MatchID = tm.MatchID
JOIN dbo.Tournaments AS t ON tm.TourneyID = t.TourneyID

WHERE t.TourneyLocation = 'Bolero Lanes'
       AND bs.RawScore >= 150;

-- Solve question with complex WHERE clause

SELECT 
       CONCAT(b.BowlerFirstName, ' ', b.BowlerMiddleInit, ' ', b.BowlerLastName) AS BowlerName,
       t.TourneyLocation,
       bs.RawScore

FROM dbo.Bowlers AS b

JOIN dbo.Bowler_Scores AS bs ON b.BowlerID = bs.BowlerID
JOIN dbo.Tourney_Matches AS tm ON bs.MatchID = tm.MatchID
JOIN dbo.Tournaments AS t ON tm.TourneyID = t.TourneyID

WHERE (t.TourneyLocation = 'Thunderbird Lanes' 
       AND bs.RawScore >= 165)
       OR
       (t.TourneyLocation = 'Bolero Lanes'
       AND bs.RawScore >= 150);

-- Recipes Example
-- 1. Display a list of all ingredients and their default measurment amounts
-- together with ingredients used in recipes and the measurement amount for each recipe.

USE RecipesExample;
GO

-- Set 1: All default ingredients (includes NULL defaults)
SELECT 
    i.IngredientName,
    m.MeasurementDescription
FROM dbo.Ingredients AS i
LEFT JOIN dbo.Measurements AS m 
    ON i.MeasureAmountID = m.MeasureAmountID

UNION ALL

-- Set 2: Distinct ingredient/measurement pairs from recipes
SELECT DISTINCT
    i.IngredientName,
    m.MeasurementDescription
FROM dbo.Recipe_Ingredients AS ri
INNER JOIN dbo.Ingredients AS i 
    ON ri.IngredientID = i.IngredientID
INNER JOIN dbo.Measurements AS m 
    ON ri.MeasureAmountID = m.MeasureAmountID;