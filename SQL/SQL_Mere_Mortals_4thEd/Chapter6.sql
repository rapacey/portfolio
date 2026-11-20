-- SQL Queries for Mere Mortals, 4th Edition
-- Chapter 6 - Filtering Your Data

USE SalesOrdersExample
GO

-- 1. Give me the names of all vendors based in Ballard, Bellevue and Redmond

SELECT VendName, VendCity
FROM Vendors
WHERE VendCity IN ('Ballard', 'Bellevue', 'Redmond');

-- 2. Show me an alphabetical list of products with a retail price of $125.00 or more

SELECT ProductName, RetailPrice
FROM Products
WHERE RetailPrice >= 125
ORDER BY ProductName ASC;

-- 3. Which vendors do we work with that don't have a Web site?

SELECT VendName, VendWebPage
FROM Vendors
WHERE VendWebPage IS NULL;

USE EntertainmentAgencyExample
GO

-- 1. Let me see a list of all engagements that occurred during October 2017

SELECT EngagementNumber, StartDate, EndDate
FROM Engagements
WHERE StartDate < '2017-11-01' AND EndDate >=  '2017-10-01'
ORDER BY StartDate ASC;

-- 2. Show me any engagements in October 2017 that start between Noon and 5:00 PM.

SELECT EngagementNumber, StartDate, StartTime
FROM Engagements
WHERE StartTime BETWEEN '12:00:00' AND '17:00:00' AND 
	StartDate < '11-01-2017' AND StartDate >= '10-01-2017'
ORDER BY StartDate ASC;

-- 3. List all the engagements that start and end on the same day.

SELECT EngagementNumber, StartDate, EndDate
FROM Engagements
WHERE StartDate = EndDate;

USE SchoolSchedulingExample
GO

-- 1. Show me which staff members use a P.O. Box as their address.

SELECT StfFirstName, StfLastName, StfStreetAddress
FROM Staff
WHERE StfStreetAddress LIKE '%Box%';

-- 2. Can you show me which students live outside the Pacific Northwest?

SELECT StudFirstName, StudLastName, StudState
FROM Students
WHERE StudState NOT IN ('WA', 'OR');

-- 3. List all the subjects that have a subject code starting MUS

SELECT SubjectCode
FROM Subjects
WHERE SubjectCode LIKE 'MUS%';

-- 4. Produce a list of the ID numbers of all the Associate Professors who are employed full time.

SELECT StaffID, Title, Status
FROM Faculty
WHERE Status = 'Full Time' AND Title = 'Associate Professor';

USE BowlingLeagueExample
GO

-- 1. Give me a list of the tournaments held during September 2017.

SELECT TourneyID, TourneyDate
FROM Tournaments
WHERE TourneyDate >= '2017-09-01' AND TourneyDate < '2017-10-01';

-- 2. What are the tournament schedules for Bolero, Red Rooster and Thunderbird Lanes?

SELECT *
FROM Tournaments
WHERE TourneyLocation IN ('Bolero Lanes', 'Red Rooster Lanes', 'Thunderbird Lanes');

-- 3. List the bowlers who live on the Eastside - Bellevue, Bothell, Duvall, Redmond, Woodinville
-- and who are on teams 5, 6, 7, or 8.

SELECT BowlerFirstName, BowlerLastName, BowlerCity, TeamID
FROM Bowlers
WHERE BowlerCity IN ('Bellevue', 'Bothell', 'Duvall', 'Redmond', 'Woodinville')
	AND TeamID BETWEEN 5 and 8
ORDER BY TeamID;

USE RecipesExample
GO

-- 1. List all the recipes that are main courses (recipe class is 1) and that have notes.

SELECT RecipeTitle, RecipeClassID, Notes
FROM Recipes
WHERE RecipeClassID = 1 AND Notes IS NOT NULL;

-- 2. Display the firest five recipes.

SELECT RecipeTitle, RecipeID
FROM Recipes
WHERE RecipeID BETWEEN 1 AND 5;




