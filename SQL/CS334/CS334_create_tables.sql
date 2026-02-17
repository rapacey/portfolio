USE CS334;		-- Database Name
GO

-- Create Student Table
CREATE TABLE student (
	sid INT PRIMARY KEY,
	sname VARCHAR(50) NOT NULL,
	-- Constraint on student sex - must be m or f
	sex CHAR(1) CONSTRAINT ck_gender CHECK (sex IN ('m', 'f')),
	-- Check age - college students at least 18 years old
	age INT CHECK (age > 0),
	-- Year check between Freshman (1) and Grad Student (5)
	year INT CHECK (year BETWEEN 1 AND 5),
	gpa FLOAT
);

-- Create department table
CREATE TABLE dept (
	dname VARCHAR(50) PRIMARY KEY,
	numphds INT NOT NULL
);

-- Create professor table
CREATE TABLE prof (
	pname VARCHAR(50) PRIMARY KEY,
	dname VARCHAR(50),
	FOREIGN KEY (dname) REFERENCES dept(dname)
);

-- Create course table
CREATE TABLE course (
	cno NUMERIC(3,0) NOT NULL,
	cname VARCHAR(50),
	dname VARCHAR(50),
	-- Courses have 3 digit numbers 
	CONSTRAINT Chk_cno_3Digits CHECK (cno >= 100 AND cno <= 999),
	PRIMARY KEY (cno, dname),  -- Composite primary key
	FOREIGN KEY (dname) REFERENCES dept(dname)
);

-- Create major table
CREATE TABLE major (
	dname VARCHAR(50),
	sid INT,
	PRIMARY KEY (dname, sid), -- Composite primary key
	FOREIGN KEY (sid) REFERENCES student(sid),
	FOREIGN KEY (dname) REFERENCES dept(dname)
);

-- Create section table
CREATE TABLE section (
	dname VARCHAR(50), 
	cno NUMERIC(3,0) NOT NULL,
	sectno INT NOT NULL,
	pname VARCHAR(50),
	PRIMARY KEY (dname, cno, sectno), -- Composite primary key
	FOREIGN KEY (cno, dname) REFERENCES course(cno,dname),
	FOREIGN KEY (pname) REFERENCES prof(pname)
);

-- Create enrollment table
CREATE TABLE enroll (
	sid INT,
	grade DECIMAL(3,2) NOT NULL, -- Grade in gpa format ex. 3.45
	dname VARCHAR(50),
	cno NUMERIC(3,0) NOT NULL,
	sectno INT NOT NULL,
	PRIMARY KEY (sid, dname, cno, sectno), -- Composite primary key
	FOREIGN KEY (sid) REFERENCES student(sid),
	FOREIGN KEY (dname, cno, sectno) REFERENCES section(dname, cno, sectno)
);

ALTER TABLE enroll
ALTER COLUMN grade FLOAT;