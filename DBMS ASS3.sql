-- 1. Develop a SQL query to list employees having birthday in Jan of computer dept
SELECT E.*
FROM Employees E
INNER JOIN Dept D ON E.deptno = D.Deptno
WHERE MONTH(E.dob) = 1 AND D.Name = 'Computer';

-- 2. Develop a SQL query to Find the names of all employees who work for "ERP project
SELECT E.name
FROM Employees E
INNER JOIN Works W ON E.empid = W.empid
INNER JOIN Project P ON W.Projectid = P.Projectid
WHERE P.title = 'ERP system';

-- 3. Develop a SQL query to Find the names and cities of residence of all employees who work for "Banking project" 
SELECT E.name, E.city
FROM Employees E
INNER JOIN Works W ON E.empid = W.empid
INNER JOIN Project P ON W.Projectid = P.Projectid
WHERE P.title = 'Banking Project';

-- 4. Develop a SQL query to find time required for "Banking project"
SELECT SUM(total_hrs_worked) AS total_hours
FROM Works
WHERE Projectid = (SELECT Projectid FROM Project WHERE title = 'Banking Project');

-- 5. Develop a SQL query to Find all employees in the database who live in the same cities as the project for which they work
SELECT E.name, E.city
FROM Employees E
INNER JOIN Works W ON E.empid = W.empid
INNER JOIN Project P ON W.Projectid = P.Projectid
WHERE E.city = P.city;

-- 6. Develop a SQL query to Find all employees in the database who live in the same cities and on the same streets as do their managers.
SELECT E.name, E.city
FROM Employees E, Dept D
INNER JOIN Employees M ON D.Managerempid = M.empid
WHERE E.city = M.city AND E.address = M.address;

-- 7. Develop a SQL query to Find all employees in the database who do not work for "Banking project" 8. Develop a SQL query to find average salary of each department
SELECT E.name
FROM Employees E
WHERE E.empid NOT IN (SELECT empid FROM Works WHERE Projectid = (SELECT Projectid FROM Project WHERE title = 'Banking Project'));

-- 9. Develop a SQL query to Find all employees in the database who earn more than each employee of "Testing Department" 
SELECT D.Name AS Department, AVG(E.salary) AS AverageSalary
FROM Employees E
INNER JOIN Dept D ON E.deptno = D.Deptno
GROUP BY D.Name;

-- 10. Develop a SQL query to Find all employees who earn more than the average salary of all employees of their department.
SELECT E1.name
FROM Employees E1
WHERE E1.salary > ALL (SELECT E2.salary FROM Employees E2 WHERE E2.deptno = (SELECT Deptno FROM Dept WHERE Name = 'Testing'));

-- 11. Develop a SQL query to Find the department that has the most employees. 
SELECT E.name
FROM Employees E
INNER JOIN Dept D ON E.deptno = D.Deptno
WHERE E.salary > (SELECT AVG(E2.salary) FROM Employees E2 WHERE E2.deptno = D.Deptno);

-- 12. Develop a SQL query to Find the department that has the smallest payroll. 
SELECT D.Name AS Department, COUNT(*) AS EmployeeCount
FROM Employees E
INNER JOIN Dept D ON E.deptno = D.Deptno
GROUP BY D.Name
ORDER BY EmployeeCount DESC
LIMIT 1;

-- 13. Develop a SQL query to Find the employees working on each project.
SELECT D.Name AS Department, SUM(E.salary) AS TotalSalary
FROM Employees E
INNER JOIN Dept D ON E.deptno = D.Deptno
GROUP BY D.Name
ORDER BY TotalSalary ASC
LIMIT 1;

-- 14. Develop a SQL query to Find the employees who are not having any project. 
SELECT P.title AS Project, GROUP_CONCAT(E.name) AS Employees
FROM Project P
LEFT JOIN Works W ON P.Projectid = W.Projectid
LEFT JOIN Employees E ON W.empid = E.empid
GROUP BY P.title;

-- 15. Develop a SQL query to Find the employees who is not having any project as well as projects who are not having employees. 
SELECT E.name
FROM Employees E
LEFT JOIN Works W ON E.empid = W.empid
WHERE W.Projectid IS NULL;

-- Employees without projects
SELECT E.name AS Employee, 'No Project' AS Assignment
FROM Employees E
LEFT JOIN Works W ON E.empid = W.empid
WHERE W.Projectid IS NULL
UNION ALL

-- Projects without employees
SELECT 'No Employee' AS Employee, P.title AS Assignment
FROM Project P
LEFT JOIN Works W ON P.Projectid = W.Projectid
WHERE W.empid IS NULL;

-- 16. Develop a SQL query to Find the employees whose department is located in "main building" 
SELECT E.name
FROM Employees E
INNER JOIN Dept D ON E.deptno = D.Deptno
WHERE D.Location = 'Main Building';

-- 17. Develop a SQL query to find employees working on more than 2 project of "Development department" 
SELECT E.name
FROM Employees E
INNER JOIN Works W ON E.empid = W.empid
INNER JOIN Project P ON W.Projectid = P.Projectid
INNER JOIN Dept D ON E.deptno = D.Deptno
WHERE D.Name = 'Development'
GROUP BY E.empid
HAVING COUNT(W.Projectid) > 2;

-- 18. Develop a SQL query to display senior person of "Testing Department" 
SELECT E.name
FROM Employees E
INNER JOIN Dept D ON E.deptno = D.Deptno
WHERE D.Name = 'Testing'
ORDER BY E.date_of_joining ASC
LIMIT 1;

-- 19. Create a view containing the total number of employees whose project location is "Pune"
CREATE VIEW EmployeesInPune AS
SELECT P.city AS ProjectLocation, COUNT(E.empid) AS EmployeeCount
FROM Employees E
INNER JOIN Works W ON E.empid = W.empid
INNER JOIN Project P ON W.Projectid = P.Projectid
WHERE P.city = 'Pune'
GROUP BY P.city;

-- 20. Calculate total travelling allowance for all using view (1000) Rs each)
SELECT SUM(EmployeeCount * 1000) AS TotalTravelingAllowance
FROM EmployeesInPune;