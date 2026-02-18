USE CS334;
GO

-- 1. Print the names of professors who work in the 
-- departments that have fewer than 50 PhD Students

SELECT 
	p.pname AS ProfessorName,
	d.dname AS DepartmentName,
	d.numphds AS PHDStudents
FROM prof AS p
JOIN dept d ON p.dname = d.dname
WHERE d.numphds < 50;

-- 2. Print the names of the students with the lowest GPA

SELECT sname, gpa
FROM student
-- Use subquery to find the minimum GPA in the table
WHERE gpa = (SELECT MIN(gpa) FROM student);

-- 3. For each Computer Sciences class, print the class number, section number,
-- and the average gpa of students enrolled in the class

SELECT 
	e.cno AS CourseNumber,
	e.sectno AS SectionNumber,
	AVG(stu.gpa) AS average_gpa
FROM enroll AS e
JOIN student AS stu ON e.sid = stu.sid
JOIN course AS c ON e.cno = c.cno AND e.dname = c.dname
WHERE c.dname = 'Computer Sciences'
GROUP BY e.cno, e.sectno
ORDER BY average_gpa DESC;

-- 4. Print the names and section numbers of all classes with more
-- than six students enrolled in them

SELECT 
	c.cname AS CourseName, 
	e.sectno AS SecNumber, 
	COUNT(e.sid) AS Students
FROM enroll AS e
JOIN course AS c on e.cno = c.cno AND e.dname = c.dname
GROUP BY c.cname, e.sectno
HAVING COUNT(e.sid) > 6;

-- 5. Print the name(s) and sid(s) of student(s) enrolled in the most classes

SELECT 
	s.sname AS StudentName,
	e.sid AS StudentID,
	COUNT(e.cno) AS Classes
FROM enroll AS e
JOIN student AS s ON e.sid = s.sid
GROUP BY s.sname, e.sid
HAVING COUNT(e.cno) = (
	-- Subquery to find max number of courses
	SELECT MAX(counts.cnt)
	FROM (
		SELECT COUNT(cno) AS cnt
		FROM enroll
		GROUP BY sid
	) AS counts
);

-- 6. Print the names of departments that have one or more 
-- majors who are under 18 years old.

SELECT DISTINCT 
	d.dname AS Department,
	s.sname AS Minor_Student_Name,
	s.age AS Age
FROM dept as d
JOIN major AS m ON d.dname = m.dname
JOIN student AS s ON m.sid = s.sid
WHERE s.age < 18;

-- 7. Print the names and majors of students who are taking one of the College Geometry courses

SELECT DISTINCT
	s.sname AS Student_Name,
	m.dname AS Major
FROM student AS s
JOIN major AS m ON s.sid = m.sid
JOIN enroll AS e ON s.sid = e.sid
JOIN course AS c ON e.dname = c.dname AND e.cno = c.cno
WHERE c.cname LIKE 'College Geometry%';

-- 8. For those departments that have no major taking a College Geometry course
-- print the department name and the number of PhD students in the department

SELECT 
	d.dname AS Department,
	d.numphds AS Number_of_PhD_Students
FROM dept AS d

EXCEPT

SELECT
	d.dname AS Department,
	d.numphds AS Number_of_PhD_Students
FROM dept AS d
JOIN major AS m ON d.dname = m.dname 
JOIN student AS s ON m.sid = s.sid
JOIN enroll AS e ON s.sid = e.sid 
JOIN course AS c ON e.dname = c.dname AND e.cno = c.cno
WHERE c.cname LIKE ('College Geometry%')

-- 9. Print the names of students who are taking both a Computer Sciences 
-- course and a Mathematics course.

SELECT 
	s.sname AS Student_Name
FROM student AS s
JOIN enroll AS e ON s.sid = e.sid
WHERE e.dname = 'Computer Sciences'

INTERSECT 

SELECT 
	s.sname AS Student_Name
FROM student AS s
JOIN enroll AS e ON s.sid = e.sid
WHERE e.dname = 'Mathematics';

-- 10. Print the age difference between the oldest and the youngest Computer Sciences major

SELECT MAX(s.age) - MIN(s.age) AS difference
FROM student AS s
JOIN major AS m ON s.sid = m.sid
WHERE m.dname = 'Computer Sciences';

-- 11. For each department that has one or more majors with a GPA under 1.0
-- print the name of the department and the average GPA of its majors.

SELECT 
	m.dname AS Department,
	AVG(s.gpa) AS Average_GPA
FROM [dbo].[major] AS m
JOIN [dbo].[student] AS s ON m.[sid] = s.[sid]
WHERE m.[dname] IN (
	-- Subquery: find departments with at least one student < 1.0
	SELECT dname
	FROM [dbo].[major] AS m2
	JOIN [dbo].[student] AS s2 ON m2.[sid] = s2.[sid]
	WHERE s2.[gpa] < 1.0
)
GROUP BY m.[dname];

-- 12. Print the ids, names and GPAs of the students who are currently
-- taking ALL the Civil Engineering courses

SELECT 
	s.sid AS Student_Id,
	s.sname AS Student_Name,
	s.gpa AS GPA
FROM student AS s
JOIN enroll AS e on s.sid = e.sid 
-- Look at Civil Engineering Courses
WHERE e.dname = 'Civil Engineering'
GROUP BY s.sid, s.sname, s.gpa
HAVING COUNT(DISTINCT e.cno) = (
	-- Subquery: Total number of unique Civil Eng courses available
	SELECT COUNT(DISTINCT cno)
	FROM course
	WHERE dname = 'Civil Engineering'
);
