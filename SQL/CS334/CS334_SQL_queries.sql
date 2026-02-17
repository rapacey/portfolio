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




