-- SQL Queries for Mere Mortals, 4th Edition
-- Chapter 4 - Simple Queries

USE SalesOrdersExample
GO

-- 1. Show me all the information on our employees

SELECT *
FROM Employees;

-- 2. Show me a list of cities, in alphabetical order, where our vendors are located
-- Include the names of the vendors we work with in each city

SELECT VendCity, VendName
FROM Vendors
ORDER BY VendCity ASC;

USE EntertainmentAgencyExample
GO

-- 1. Give me the names and phone numbers of all our agents, and list them in last name/first name order

SELECT AgtLastName, AgtFirstName, AgtPhoneNumber
FROM Agents
ORDER BY AgtLastName ASC;

-- 2. Give me all the information on all our engagements

SELECT *
FROM Engagements;

-- 3. List all engagements and their associated start dates.
-- Sort the records by date in descending order and by engagement in ascending order.

SELECT EngagementNumber, StartDate
FROM Engagements
ORDER BY StartDate DESC, EngagementNumber ASC;

USE SchoolSchedulingExample
GO

-- 1. Show me a complete list of all the subjects we offer.

SELECT DISTINCT SubjectName
FROM Subjects
ORDER BY SubjectName ASC;

-- 2. What kinds of titles are associated with our faculty?

SELECT DISTINCT Title
FROM Faculty
ORDER BY Title ASC;

-- 3. List the names and phone numbers of all our staff and sort them by last name and first name

SELECT StfLastName, StfFirstName, StfPhoneNumber
FROM Staff
ORDER BY StfLastName ASC, StfFirstName ASC;

USE BowlingLeagueExample
GO

-- 1. List all of the teams in alphabetical order

SELECT TeamName
FROM Teams
ORDER BY TeamName ASC;

-- 2. Show me all the bowling score information for each of our members

SELECT *
FROM Bowler_Scores;

-- 3. Show me a list of bowlers and their addresses, and sort it in alphabetical order

SELECT BowlerFirstName, BowlerLastName, BowlerAddress, BowlerCity, BowlerState, BowlerZip
FROM Bowlers
ORDER BY BowlerLastName ASC;

USE RecipesExample
GO

-- 1. Show me a list of all the ingredients we currently keep track of

SELECT *
FROM Ingredients
WHERE MeasureAmountID IS NOT NULL;

-- 2. Show me all the main recipe information, and sort it by the name of the recipe in alphabetical order

SELECT *
FROM Recipes
ORDER BY RecipeTitle ASC;



