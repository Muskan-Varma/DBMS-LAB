-- 1. develop DDL
CREATE TABLE Dept (
    Deptno INT PRIMARY KEY,
    Name VARCHAR(255),
    Location VARCHAR(255),
    Managerempid INT,
    Gender CHAR(1),
    CONSTRAINT chk_gender CHECK (Gender IN ('M', 'F'))
);

CREATE TABLE Employees (
    empid INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    dob DATE,
    date_of_joining DATE,
    gender CHAR(1),
    salary DECIMAL(10, 2),
    deptno INT,
    CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES Dept(Deptno)
);

CREATE TABLE Project (
    Projectid INT PRIMARY KEY,
    title VARCHAR(255),
    city VARCHAR(255)
);

CREATE TABLE Works (
    empid INT,
    Projectid INT,
    total_hrs_worked INT,
    PRIMARY KEY (empid, Projectid),
    CONSTRAINT fk_empid FOREIGN KEY (empid) REFERENCES Employees(empid),
    CONSTRAINT fk_Projectid FOREIGN KEY (Projectid) REFERENCES Project(Projectid)
);

CREATE TABLE Dependant (
    empid INT,
    name_of_dependant VARCHAR(255),
    age INT,
    relation VARCHAR(255),
    PRIMARY KEY (empid, name_of_dependant),
    CONSTRAINT fk_empid_dependant FOREIGN KEY (empid) REFERENCES Employees(empid)
);

-- 2. Insert data

INSERT INTO Dept (Deptno, Name, Location, Managerempid)
VALUES (1, 'Development', 'Building 1', 101);

INSERT INTO Dept (Deptno, Name, Location, Managerempid)
VALUES (2, 'Testing', 'Building 2', 102);

INSERT INTO Dept (Deptno, Name, Location, Managerempid)
VALUES (3, 'Planning', 'Building 3', 103);

INSERT INTO Dept (Deptno, Name, Location, Managerempid)
VALUES (4, 'Service', 'Building 4', 104);

INSERT INTO Dept (Deptno, Name, Location, Managerempid)
VALUES (5, 'Administration', 'Main Building', 105);

-- Employee 101
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (101, 'John Doe', '123 Main St', 'New York', '1990-05-15', '2010-07-01', 'M', 60000.00, 1);

-- Employee 102
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (102, 'Mary Smith', '456 Elm St', 'Los Angeles', '1992-08-20', '2011-05-15', 'F', 55000.00, 2);

-- Employee 103
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (103, 'James Johnson', '789 Oak Ave', 'Chicago', '1988-03-10', '2019-09-30', 'M', 65000.00, 1);

-- Employee 104
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (104, 'Emily Davis', '101 Pine Rd', 'San Francisco', '1995-11-25', '2018-02-14', 'F', 52000.00, 2);

-- Employee 105
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (105, 'Michael Wilson', '222 Cedar Ln', 'Dallas', '1987-07-07', '2020-11-10', 'M', 70000.00, 1);

-- Employee 106
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (106, 'Sophia Brown', '333 Maple Dr', 'Miami', '1993-04-18', '2017-06-25', 'F', 58000.00, 2);

-- Employee 107
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (107, 'Daniel Lee', '444 Birch Ave', 'Houston', '1989-09-03', '2012-03-05', 'M', 67000.00, 1);

-- Employee 108
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (108, 'Olivia Taylor', '555 Redwood Rd', 'Phoenix', '1994-01-12', '2019-08-12', 'F', 54000.00, 2);

-- Employee 109
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (109, 'William Anderson', '666 Sequoia St', 'Seattle', '1986-12-28', '2008-10-20', 'M', 72000.00, 1);

-- Employee 110
INSERT INTO Employees (empid, name, address, city, dob, date_of_joining, gender, salary, deptno)
VALUES (110, 'Ava Garcia', '777 Cedar Rd', 'Denver', '1991-06-05', '2014-12-18', 'F', 59000.00, 2);

INSERT INTO Project (Projectid, title, city)
VALUES (1, 'Banking Project', 'Pune');

INSERT INTO Project (Projectid, title, city)
VALUES (2, 'Testing Project', 'Pune');

INSERT INTO Project (Projectid, title, city)
VALUES (3, 'ERP System', 'Nashik');

INSERT INTO Project (Projectid, title, city)
VALUES (4, 'Software Management', 'Mumbai');

-- Project 2
INSERT INTO Project (Projectid, title, city)
VALUES (5, 'E-commerce Website', 'New York');

-- Project 3
INSERT INTO Project (Projectid, title, city)
VALUES (6, 'Mobile App Development', 'Pune');

-- Project 4
INSERT INTO Project (Projectid, title, city)
VALUES (7, 'Data Analytics Platform', 'Chicago');

-- Project 5
INSERT INTO Project (Projectid, title, city)
VALUES (8, 'AI Research', 'Los Angeles');

-- Project 6
INSERT INTO Project (Projectid, title, city)
VALUES (9, 'Marketing Campaign', 'Miami');

INSERT INTO Works (empid, Projectid, total_hrs_worked)
VALUES (101, 1, 40);

INSERT INTO Works (empid, Projectid, total_hrs_worked)
VALUES (102, 2, 30);

INSERT INTO Works (empid, Projectid, total_hrs_worked)
VALUES (103, 3, 10);

INSERT INTO Works (empid, Projectid, total_hrs_worked)
VALUES (110, 4, 50);

INSERT INTO Dependant (empid, name_of_dependant, age, relation)
VALUES (101, 'Jane Doe', 30, 'Spouse');

INSERT INTO Dependant (empid, name_of_dependant, age, relation)
VALUES (102, 'Emily Doe', 5, 'Child');

INSERT INTO Dependant (empid, name_of_dependant, age, relation)
VALUES (102, 'David Smith', 8, 'Child');

INSERT INTO Dependant (empid, name_of_dependant, age, relation)
VALUES (103, 'Sophie Johnson', 12, 'Child');

INSERT INTO Dependant (empid, name_of_dependant, age, relation)
VALUES (102, 'Oliver Davis', 18, 'Child');

INSERT INTO Dependant (empid, name_of_dependant, age, relation)
VALUES (105, 'Lily Wilson', 6, 'Child');

-- 4. Add mobile no column
ALTER TABLE Employees
ADD COLUMN Mobile_number VARCHAR(15);

-- 5. update mobile numbers
UPDATE Employees
SET Mobile_number = '123-456-7890'
WHERE empid BETWEEN 101 AND 110;

-- 6. delete testing project
DELETE FROM Works
WHERE Projectid = (SELECT Projectid FROM Project WHERE title = 'Testing Project');
DELETE FROM Project
WHERE title = 'Testing Project';

-- 7. employees having name starting with s
SELECT *
FROM Employees
WHERE name LIKE 'S%';

-- 8. departments having location building 1
SELECT *
FROM Dept
WHERE Location = 'Building 1';

-- 9. employees joined in 2019 to 2020
SELECT *
FROM Employees
WHERE YEAR(date_of_joining) BETWEEN 2019 AND 2020;

-- 10. employees having salary > 50000
SELECT *
FROM Employees
WHERE salary > 50000.00;

-- 11. all projects of pune
SELECT *
FROM Project
WHERE city = 'Pune';

-- 12. all dependents of employee 102
SELECT *
FROM Dependant
WHERE empid = 102;

-- 13. display all manager names
SELECT E.name AS Manager_Name
FROM Employees E
INNER JOIN Dept D ON E.empid = D.Managerempid;

-- 14. find age of all emp
SELECT empid, name, DATEDIFF(CURRENT_DATE, dob) / 365 AS Age
FROM Employees;

-- 15. display all emps in dec order of age
SELECT empid, name, DATEDIFF(CURRENT_DATE, dob) / 365 AS Age
FROM Employees
ORDER BY Age DESC;