--CS 425 - Database Organization
-- Summer 2016
-- Illinois Institute of Technology

--SQL DDL

--2.1.1

CREATE TABLE assignedTo (
    donor   VARCHAR(256),
    organ   VARCHAR(256),
    patient VARCHAR(256),
    price   NUMERIC(8,2) NOT NULL CHECK(price > 0 AND price < 1000000),
    PRIMARY KEY(donor,organ,patient),
    FOREIGN KEY(donor,organ) REFERENCES organ(donor,organ),
    FOREIGN KEY(patient) REFERENCES patient(pName)
);

--2.1.2

CREATE TABLE worksFor(
    doctor         VARCHAR(256),
    hospital       VARCHAR(256),
    salary         NUMERIC(8),
    PRIMARY KEY(doctor,hospital)     
);

--SQL Queries

--2.2.1
--Write a SQL query that returns the name sof all donors that donate hearts or lungs.
--Make sure that every donor is only returned once.

SELECT DISTINCT donor
FROM organ
WHERE organ = 'Heart'
OR organ = 'Lung';

SELECT DISTINCT donor
FROM organ
WHERE organ IN ('Heart', 'Lung');

--2.2.2
--Write a SQL query that returns organs and their availability.

SELECT organ, available
FROM organ;

--2.2.3
--Return the name and rate of all doctors that support HMO combined with
-- each patient they are taking care of.

SELECT d.docName, d.rate, p.pName
FROM doctor d
JOIN takeCare t ON d.docName = t.doctor
JOIN patient p ON t.patient = p.pName
WHERE d.insurance = 'HMO';

--2.2.4
--Write a SQL query that returns the average age for all donors.

SELECT AVG(age) AS average_age
FROM donor;

--2.2.5
--Write a SQL query that returns the number of compatible donor-patient pairs (same blood type).

SELECT count(*) AS compatible_pairs
FROM patient JOIN donor USING(bloodType);

SELECT COUNT(DISTINCT d.dName || '-' || p.pName) AS compatible_pairs
FROM donor d
JOIN organ o ON d.dName = o.donor
JOIN takeCare t ON o.organ = t.organ
JOIN patient p ON t.patient = p.pName
WHERE d.bloodType = p.bloodType;

--2.2.6
--Write a SQL query that returns blood types for which the average age of donors
-- for that blood type is below 35.

SELECT bloodType
FROM donor
GROUP BY bloodType
HAVING AVG(age) < 35;

--2.2.7 
--Write a SQL query that returns the names of potential donors for each patient.
--A donor is a potential donor for a patient if he/she has the same blood type 
--and is donating an organ that the patient needs. Return each such pair only once.

SELECT DISTINCT pName, dName
FROM donor d
JOIN organ o ON d.dName = o.donor
JOIN takeCare t ON o.organ = t.organ
JOIN patient p ON t.patient = p.pName AND d.bloodType = p.bloodType;

--2.2.8
--Write a SQL query that returns the name(s) of the doctors in order by rate from lowest to highest.

SELECT docName, rate
FROM doctor
ORDER BY rate ASC;

--2.2.9
--Write a SQL query that returns patients (name) for which there exist no donor that is
--of the right blood type and donates the correct organ.

SELECT pName
FROM patient p 
JOIN takeCare t ON p.pname = t.patient
WHERE NOT EXISTS (
    SELECT 1
    FROM organ o 
    JOIN donor d ON o.donor = d.dName
    WHERE d.bloodType = p.bloodType
    AND o.organ = t.organ
);

--2.2.10
--Write a SQL query that returns the average number of organs donated by donors per blood type.

SELECT AVG(numO) AS avgNum, bloodType
FROM (
    SELECT count(*) AS numO, dName, bloodType
    FROM organ o JOIN donor d ON (o.donor = d.dName)
    GROUP BY dName, bloodType) AS n
GROUP BY bloodType; 

-- SQL Updates

--2.3.1
--Write a SQL operaiton that deletes all organs that were available before 2014.

DELETE 
FROM organ
WHERE available < 2014;

--2.3.2
--Increase the rate of all doctors for HMO insurance by 1,000

UPDATE doctor
SET rate = rate + 1000
WHERE insurance = 'HMO';

--2.3.3
--Insert a new organ 'Foot' for donor Alice available in 2015

INSERT INTO organ(donor, organ, available)
VALUES('Alice', 'Foot', '2015');

--2.3.4
--Update the availability of all hearts to 2016 if their current availability is 2015.

UPDATE organ
SET available = '2016'
WHERE organ = 'Heart'
AND available = '2015';

--2.3.5
--Change the rates for all doctors. The HMO rate should be set to the average rate for that doctor minus 500.
--The PPO rate should be set to the average rate for the doctor plus 500.

UPDATE doctor AS d
SET rate = (
    SELECT AVG(rate) FROM doctor AS r
    WHERE r.docName = d.docName)
    + CASE WHEN insurance = 'PPO' THEN 500
    ELSE -500
    END;