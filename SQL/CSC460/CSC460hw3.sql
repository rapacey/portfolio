-- CSC 460 - Database Design
-- University of Arizona, Spring 2026
-- Homework 3: SQL Queries

-- Aquarium database schema

-- Species (sno, sname, sfood)
-- Tank (tno, tname, tcolor, tvolume)
-- Fish (fno, fname, fcolor, fweight, tno, sno)
-- Event (eno, fno, edate, enote)

-- Create database tables based on assignment schema
CREATE TABLE dbo.Species (
    sno INT PRIMARY KEY,
    sname VARCHAR(50),
    sfood VARCHAR(50)
);

CREATE TABLE dbo.Tank (
    tno INT PRIMARY KEY,
    tname VARCHAR(50),
    tcolor VARCHAR(50),
    tvolume INT
);

CREATE TABLE dbo.Fish (
    fno INT PRIMARY KEY,
    fname VARCHAR(50),
    fcolor VARCHAR(50),
    fweight INT,
    tno INT FOREIGN KEY REFERENCES dbo.Tank(tno),
    sno INT FOREIGN KEY REFERENCES dbo.Species(sno)
);

CREATE TABLE dbo.Event (
    eno INT PRIMARY KEY,
    fno INT FOREIGN KEY REFERENCES dbo.Fish(fno),
    edate VARCHAR(5), -- 5-character string per requirement
    enote VARCHAR(100)
);

-- Insert Mock Data
INSERT INTO dbo.Species (sno, sname, sfood) VALUES
(1, 'Great White Shark', 'herring'),
(2, 'Tiger Shark', 'tuna'),
(3, 'Goldfish', 'flakes'),
(4, 'Clownfish', 'plankton'),
(5, 'Blue Tang', 'herring');

INSERT INTO dbo.Tank (tno, tname, tcolor, tvolume) VALUES
(10, 'lagoon', 'blue', 5000),
(20, 'cesspool', 'green', 1000),
(30, 'puddle', 'green', 50),
(40, 'coral reef', 'green', 3000),
(50, 'deep ocean', 'blue', 10000);

INSERT INTO dbo.Fish (fno, fname, fcolor, fweight, tno, sno) VALUES
(101, 'Finley', 'red', 45, 10, 3),    -- Goldfish in lagoon
(102, 'Bruce', 'grey', 500, 20, 1),   -- Great White Shark in cesspool
(103, 'Nemo', 'orange', 5, 40, 4),    -- Clownfish in green coral reef
(104, 'Dory', 'blue', 12, 40, 5),     -- Blue Tang in green coral reef
(105, 'Bubbles', 'red', 8, 30, 3),    -- Goldfish in green puddle
(106, 'Chomp', 'grey', 350, 40, 2),   -- Tiger Shark in green coral reef
(107, 'Jaws', 'grey', 600, 30, 1);    -- Great White Shark in green puddle

INSERT INTO dbo.Event (eno, fno, edate, enote) VALUES
(1, 101, '01-01', 'successful birth at facility'),
(2, 101, '01-02', 'fish is swimming happily'),
(3, 102, '02-15', 'captured from wild, swimming in tank'),
(4, 103, '03-01', 'birth recorded'),
(5, 103, '03-02', 'swimming near the surface'),
(6, 105, '04-10', 'birth recorded');  -- Born, but has no swimming event

-- 1. What are the names of all of the red fish?

SELECT fname
FROM dbo.Fish
WHERE fcolor = 'red';

-- 2. What are the colors of all of the tanks named 'lagoon'?

SELECT tcolor
FROM dbo.Tank
WHERE tname LIKE N'%lagoon%';

-- 3. What is the Cartesian Product of the sname field from Species with 
-- the tname field from Tank? List each (sname,tname) pair only once.

SELECT DISTINCT S.sname, T.tname
FROM dbo.Species AS S
CROSS JOIN dbo.Tank AS T;

-- 4. What are the colors of the sharks (in alphabetical order)?

SELECT S.sname, F.fcolor
FROM dbo.Species AS S 
JOIN dbo.Fish AS F ON S.sno = F.sno
WHERE S.sname LIKE N'%shark%'
ORDER BY F.fcolor ASC;

-- 5. What is the name of the heaviest fish?

SELECT fname
FROM dbo.Fish
WHERE fweight = (SELECT MAX(fweight) FROM dbo.Fish);

-- 6. What are the names of the fish that are sharks and live in cesspools?

SELECT F.fname, S.sname, T.tname
FROM dbo.Fish AS F
JOIN dbo.Species AS S ON F.sno = S.sno
JOIN dbo.Tank AS T ON F.tno = T.tno
WHERE S.sname LIKE N'%shark%'
    AND T.tname = 'cesspool';

-- 7. The database contains names of species, tanks and fish.
-- Display a result containing all of these names.

SELECT sname AS Name FROM dbo.Species
UNION
SELECT tname FROM dbo.Tank
UNION
SELECT fname FROM dbo.Fish;

-- 8. What are the names of species found in puddles?

SELECT S.sname, T.tname
FROM dbo.Species AS S
JOIN dbo.Fish AS F ON S.sno = F.sno
JOIN dbo.Tank AS T ON F.tno = T.tno
WHERE T.tname = 'puddle';

-- 9. What are the names of species that are found in the same tank 
-- with a shark? List each species name only once in the results.

SELECT DISTINCT S.sname
FROM dbo.Species AS S
JOIN dbo.Fish AS F ON S.sno = F.sno
-- Subquery to find all tank numbers holding a shark
WHERE F.tno IN (
    SELECT F2.tno
    FROM dbo.Fish AS F2
    JOIN dbo.Species AS S2 ON F2.sno = S2.sno
    WHERE S2.sname LIKE '%shark%'
);

-- 10. What are the names of the fish that have been born and are swimming?

SELECT F.fname
FROM dbo.Fish AS F
WHERE F.fno IN (SELECT E1.fno FROM dbo.Event AS E1 WHERE E1.enote LIKE '%birth%')
AND F.fno IN (SELECT E2.fno FROM dbo.Event AS E2 WHERE E2.enote LIKE '%swim%');

-- 11. What are the names of the fish that have been born and are NOT swimming?

-- Set-difference problem "Born" EXCEPT "Swimming"

SELECT F.fname
FROM dbo.Fish AS F
JOIN dbo.Event AS E ON F.fno = E.fno
WHERE E.enote LIKE '%birth%'

EXCEPT

SELECT F.fname
FROM dbo.Fish AS F
JOIN dbo.Event AS E ON F.fno = E.fno
WHERE E.enote LIKE '%swim%';

-- Alternate Solution using Left Join
-- Build a combined map of birth and swim events, 
-- then filter out where swim bucket is empty (IS NULL)

SELECT DISTINCT F.fname
FROM dbo.Fish AS F
JOIN dbo.Event AS E1 ON F.fno = E1.fno AND E1.enote LIKE '%birth%'
LEFT JOIN dbo.Event AS E2 ON F.fno = E2.fno AND E2.enote LIKE '%swim%'
WHERE E2.fno IS NULL;

-- 12. What are the colors of the fish and the average weight of the fish 
-- of each color? Include in your results only those colors that have an 
-- average group weight under 40 and list the results in descending order
-- by weight.

SELECT fcolor, AVG(fweight) AS avg_weight
FROM dbo.Fish
-- To aggregate values and filter on the result, you must group by the attribute
GROUP BY fcolor
HAVING AVG(fweight) < 40
ORDER BY avg_weight DESC;

-- Alternate Solution: Window Functions

WITH WeightCalculations AS (
    SELECT 
        fcolor,
        fweight,
        AVG(fweight) OVER(PARTITION BY fcolor) AS avg_color_weight
    FROM dbo.Fish
)
SELECT DISTINCT fcolor, avg_color_weight
FROM WeightCalculations
WHERE avg_color_weight < 40
ORDER BY avg_color_weight DESC;

-- 13. What are the names of the species that eat herring that have a 
-- representative in all green tanks?

SELECT S.sname
FROM dbo.Species AS S
JOIN dbo.Fish AS F ON S.sno = F.sno
JOIN dbo.Tank AS T ON F.tno = T.tno
WHERE S.sfood = 'herring' AND T.tcolor = 'green'
GROUP BY S.sname, S.sno
HAVING COUNT(DISTINCT T.tno) = 
    (SELECT COUNT (*) FROM dbo.Tank WHERE tcolor = 'green');

-- Alternate Solution: Conditional Aggregation

SELECT S.sname
FROM dbo.Species AS S
JOIN dbo.Fish AS F ON S.sno = F.sno
JOIN dbo.Tank AS T ON F.tno = T.tno
WHERE S.sfood = 'herring'
GROUP BY S.sname, S.sno
HAVING COUNT(DISTINCT CASE WHEN T.tcolor = 'green' THEN T.tno END) = 
       (SELECT COUNT(*) FROM dbo.Tank WHERE tcolor = 'green');
