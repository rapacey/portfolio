USE CS334;
GO

-- 1. Import Students
BULK INSERT student
FROM 'C:\Users\Rob\Desktop\data\student.data'
WITH (
	FIELDTERMINATOR = '\t',  -- Tab Delimiter
	ROWTERMINATOR = '0x0a',  -- Look for Line Feed (\n) specifically
	TABLOCK
);

-- 2. Import Departments
BULK INSERT dept
FROM 'C:\Users\Rob\Desktop\data\dept.data'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '0x0a',  -- Look for Line Feed (\n) specifically
	TABLOCK
);

-- 3. Import Professors
BULK INSERT prof
FROM 'C:\Users\Rob\Desktop\data\prof.data'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '0x0a',  -- Look for Line Feed (\n) specifically
	TABLOCK
);

-- 4. Import Courses
BULK INSERT course
FROM 'C:\Users\Rob\Desktop\data\course.data'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '0x0a',  -- Look for Line Feed (\n) specifically
	TABLOCK
);

-- 5. Insert Majors
BULK INSERT major
FROM 'C:\Users\Rob\Desktop\data\major.data'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '0x0a',  -- Look for Line Feed (\n) specifically
	TABLOCK
);

-- 6. Insert Class Sections
BULK INSERT section
FROM 'C:\Users\Rob\Desktop\data\section.data'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '0x0a',  -- Look for Line Feed (\n) specifically
	TABLOCK
);

-- 7. Insert Enrollments
BULK INSERT enroll
FROM 'C:\Users\Rob\Desktop\data\enroll.data'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '0x0a',  -- Look for Line Feed (\n) specifically
	TABLOCK
);