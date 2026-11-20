-- SQL For Mere Mortals, 4th Edition
-- Chapter 13 Homework: Grouping Data

USE SalesOrdersExample;

-- 1. Show me each vendor and the average by vendor of the number of days to deliver products.

SELECT
	v.VendorID,
	v.VendName,
	AVG(pv.DaystoDeliver) AS DeliveryAverage
FROM Vendors AS v
JOIN Product_Vendors AS pv
	ON v.VendorID = pv.VendorID
GROUP BY v.VendorID, v.VendName
ORDER BY v.VendName;

-- 2. Display for each product the product name and the total sales.

SELECT 
	p.ProductNumber,
	p.ProductName,
	SUM(od.QuotedPrice * od.QuantityOrdered) AS TotalSales
FROM Products AS p
JOIN Order_Details AS od
	ON p.ProductNumber = od.ProductNumber
GROUP BY p.ProductNumber, p.ProductName
ORDER BY TotalSales DESC;

-- 3. List all the vendors and the count of the products sold by each.

SELECT 
	v.VendorID,
	v.VendName,
	COUNT(pv.ProductNumber) AS ProductCount
FROM Vendors AS v
JOIN Product_Vendors AS pv 
	ON v.VendorID = pv.VendorID
GROUP BY v.VendorID, v.VendName
ORDER BY v.Vendname;

-- 4. Solve problem #3 by using a subquery.

SELECT 
	v.VendorID,
	v.VendName,
	(
		SELECT COUNT(pv.ProductNumber)
		FROM Product_Vendors AS pv
		WHERE pv.VendorID = v.VendorID
	) AS ProductCount
FROM Vendors AS v
ORDER BY ProductCount DESC;

USE EntertainmentAgencyExample;

-- 1. Show each agent's name, the sum of the contract price for 
-- the engagements booked and the agent's total commission.

SELECT 
	a.AgentID,
	a.AgtFirstName,
	a.AgtLastName,
	COALESCE(	
	(	SELECT SUM(e.ContractPrice)
		FROM Engagements AS e
		WHERE e.AgentID = a.AgentID
	),
	0
	) AS ContractsSum,
	COALESCE(
	(
		SELECT SUM(e.ContractPrice)
		FROM Engagements AS e
		WHERE e.AgentID = a.AgentID
	),
	0
	) * a.CommissionRate AS AgentCommission

FROM Agents AS a
ORDER BY a.AgtLastName;

-- Alternative Solution - Standard JOIN

SELECT 
    a.AgentID,
    a.AgtFirstName,
    a.AgtLastName,
    SUM(e.ContractPrice) AS ContractsSum,
    SUM(e.ContractPrice) * a.CommissionRate AS AgentCommission
FROM Agents AS a
JOIN Engagements AS e 
    ON a.AgentID = e.AgentID
GROUP BY a.AgentID, a.AgtFirstName, a.AgtLastName, a.CommissionRate
ORDER BY a.AgtLastName;

USE SchoolSchedulingExample;

-- 1. Display by category the category name and the count of classes offered.

SELECT 
    c.CategoryID,
    c.CategoryDescription,
    COUNT(cl.ClassID) AS ClassCount
FROM Categories AS c
JOIN Subjects AS s 
    ON c.CategoryID = s.CategoryID
JOIN Classes AS cl 
    ON s.SubjectID = cl.SubjectID
GROUP BY c.CategoryID, c.CategoryDescription
ORDER BY c.CategoryDescription;

-- 2. List each staff memeber and the count of classes each is scheduled to teach.

SELECT
	s.StaffID,
	s.StfFirstName + ' ' + s.StfLastName AS StaffMember,
	(	
		SELECT COUNT(fc.ClassID)
		FROM Faculty_Classes AS fc
		WHERE fc.StaffID = s.StaffID
	) AS ClassCount
FROM Staff AS s;

-- 3. Could you modify the query in Question 2 to return 27 rows, using a non-subquery answer?

-- Use a LEFT JOIN so that all staff members are returned, regardless of whether they have assigned classes

SELECT 
    s.StaffID,
    s.StfFirstName || ' ' || s.StfLastName AS StaffMember,
    COUNT(fc.ClassID) AS ClassCount
FROM Staff AS s
LEFT JOIN Faculty_Classes AS fc 
    ON s.StaffID = fc.StaffID
GROUP BY s.StaffID, s.StfFirstName, s.StfLastName
ORDER BY s.StaffID;

USE BowlingLeagueExample;

-- 1. Display for each bowler the bowler name and the average of the bowler's raw game scores.

SELECT 
	b.BowlerID,
	b.BowlerLastName,
	b.BowlerFirstName,
	AVG(bs.RawScore) AS AverageRawGameScore
FROM Bowlers AS b
JOIN Bowler_Scores AS bs 
	ON b.BowlerID = bs.BowlerID
GROUP BY b.BowlerID, b.BowlerLastName, b.BowlerFirstName
ORDER BY b.BowlerLastName, b.BowlerFirstName;

-- 2. Calculate the current average and handicap for each bowler.

SELECT 
    b.BowlerID,
    b.BowlerLastName,
    b.BowlerFirstName,
    ROUND(AVG(bs.RawScore), 0) AS CurrentAverage,
    ROUND((200 - AVG(bs.RawScore)) * 0.80, 0) AS CurrentHandicap
FROM Bowlers AS b
JOIN Bowler_Scores AS bs 
    ON b.BowlerID = bs.BowlerID
GROUP BY b.BowlerID, b.BowlerLastName, b.BowlerFirstName
ORDER BY b.BowlerLastName, b.BowlerFirstName;

-- 3. Display the highest raw score for each bowler using a subquery.

SELECT 
	b.BowlerID,
	b.BowlerLastName, 
	b.BowlerFirstName,
	(
		SELECT MAX(bs.RawScore)
		FROM Bowler_Scores AS bs
		WHERE bs.BowlerID = b.BowlerID
	) AS MaxRawScore
FROM Bowlers AS b
ORDER BY MaxRawScore DESC;

USE RecipesExample;

-- 1. If I want to cook all the recipes in my cookbook, how much of each ingredient must I have on hand?

SELECT 
    i.IngredientID,
    i.IngredientName,
    COALESCE(SUM(ri.Amount), 0) AS TotalAmount
FROM Ingredients AS i
LEFT JOIN Recipe_Ingredients AS ri 
    ON i.IngredientID = ri.IngredientID
GROUP BY i.IngredientID, i.IngredientName
ORDER BY i.IngredientName;

-- 2. List all meat ingredients and the count of recipes that include each one. 

SELECT 
    i.IngredientID,
    i.IngredientName,
    COUNT(ri.RecipeID) AS RecipeCount
FROM Ingredient_Classes AS ic
JOIN Ingredients AS i 
    ON ic.IngredientClassID = i.IngredientClassID
JOIN Recipe_Ingredients AS ri 
    ON i.IngredientID = ri.IngredientID
WHERE ic.IngredientClassDescription = 'Meat'
GROUP BY i.IngredientID, i.IngredientName
ORDER BY i.IngredientName;