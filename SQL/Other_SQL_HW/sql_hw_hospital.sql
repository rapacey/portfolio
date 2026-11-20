-- SQL Practice Homework - Hospital Database

CREATE TABLE Hospital
    (
    PNo    INTEGER PRIMARY KEY,
    Name    VARCHAR(50), 
    Age     NUMBER CHECK (Age BETWEEN 0 and 110),
    Department  VARCHAR(50), 
    DateofAdm   DATE,
    Charges     NUMBER NOT NULL,
    Sex         VARCHAR(1)
    );

-- a)

SELECT *
FROM Hospital
WHERE Department = 'Cardiology';

-- b)

SELECT Name
FROM Hospital
WHERE Sex = 'F'
AND Department IN ('Orthopedic', 'Surgery');

-- c)

SELECT Name, DateofAdm
FROM Hospital
ORDER BY DateofAdm ASC;

-- d)

SELECT Name, Charges, Age
FROM Hospital
WHERE Sex = 'M';

-- e)

SELECT COUNT(*) AS over_20
FROM Hospital
WHERE age > 20;

-- f)

SELECT DISTINCT Department
FROM Hospital;

-- g)

SELECT Department, COUNT(*) AS patient_count
FROM Hospital
GROUP BY Department;

-- h)

SELECT 
    COUNT (CASE WHEN Sex = 'M' THEN 1 END) AS male_count,
    COUNT (CASE WHEN Sex = 'F' THEN 1 END) AS female_count
FROM Hospital;

SELECT Sex, COUNT(*) AS patient_count
FROM Hospital
GROUP BY Sex;

SELECT DISTINCT
    (SELECT COUNT(*)
    FROM Hospital 
    WHERE Sex = 'M')
    AS male_count,
    (SELECT COUNT(*)
    FROM Hospital
    WHERE Sex = 'F')
    AS female_count
FROM DUAL;

-- i)

SELECT *
FROM Hospital
WHERE DateofAdm >= DATE '1998-01-01'
AND DateofAdm <= DATE '1998-04-01';

-- j)

SELECT Department
FROM Hospital
GROUP BY Department
HAVING COUNT(*) < 2;

-- k)

SELECT *
FROM Hospital
WHERE UPPER(Name) LIKE ('Z%');

-- l)

UPDATE Hospital
    SET Age = 20
    WHERE Name = 'Kush';

-- m)

UPDATE Hospital
    SET Charges = Charges * 1.05;

-- n)

DELETE
    FROM Hospital
    WHERE Name = 'Tarun';

-- o) 

ALTER TABLE Hospital
    ADD WardNumber NUMBER;

-- p)

ALTER TABLE Hospital
    MODIFY Charges NULL;

-- q)

UPDATE Hospital
    SET Charges = NULL
    WHERE Department = 'Surgery';

-- r)

UPDATE Hospital
    SET Charges = Charges * .90
    WHERE Department = 'Cardiology';

-- s)

ALTER TABLE Hospital
DROP PRIMARY KEY;

-- t)

INSERT INTO Hospital (PNo, Name, Age, Department, DateofAdm, Charges, Sex)
VALUES(11, 'Mustafa', 37, 'ENT', DATE '1998-02-25', 250, 'M');