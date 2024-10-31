-- Use the database
USE Atharva;

-- Create Employee table
CREATE TABLE Employee (
    emp_no INT,
    emp_name VARCHAR(20),
    date DATE,
    position VARCHAR(20),
    salary INT
);

-- Create TE table
CREATE TABLE TE (
    emp_no INT,
    emp_name VARCHAR(20),
    join_date DATE,
    position VARCHAR(20),
    salary INT
);

-- Insert records into Employee table
INSERT INTO Employee VALUES (1, 'abc', '2018-07-11', 'clerk', 50000);
INSERT INTO Employee VALUES (2, 'abhi', '2018-05-11', 'ceo', 150000);
INSERT INTO Employee VALUES (3, 'xyz', '2018-05-21', 'hr', 100000);
INSERT INTO Employee VALUES (4, 'aqwgy', '2018-06-21', 'te', 10000);
INSERT INTO Employee VALUES (5, 'sfhjfh', '2018-07-21', 'gt', 12000);

-- Insert records into TE table
INSERT INTO TE VALUES (1, 'abc', '2018-07-11', 'clerk', 50000);
INSERT INTO TE VALUES (2, 'abhi', '2018-05-11', 'ceo', 150000);
INSERT INTO TE VALUES (3, 'xyz', '2018-05-21', 'hr', 100000);
INSERT INTO TE VALUES (4, 'aqwgy', '2018-06-21', 'te', 10000);
INSERT INTO TE VALUES (5, 'sfhjfh', '2018-07-21', 'gt', 12000);

-- 1. Select all records from Employee
SELECT * FROM Employee;

-- 2. Select all records from TE
SELECT * FROM TE;

-- 3. Update the emp_name of the employee with emp_no 5 in TE
UPDATE TE SET emp_name = 'gjgj' WHERE emp_no = 5;

-- 4. Select all records from TE after the update
SELECT * FROM TE;

-- 5. Union of Employee and TE (removing duplicates)
SELECT * FROM Employee
UNION
SELECT emp_no, emp_name, join_date AS date, position, salary FROM TE;

-- 6. Union all of Employee and TE (including duplicates)
SELECT * FROM Employee
UNION ALL
SELECT emp_no, emp_name, join_date AS date, position, salary FROM TE;

-- 7. Select distinct emp_no from Employee where emp_no is in TE
SELECT DISTINCT emp_no FROM Employee WHERE emp_no IN (SELECT emp_no FROM TE);

-- 8. Calculate minimum salary in Employee table
SELECT MIN(salary) AS min_salary FROM Employee;

-- 9. Calculate maximum salary in Employee table
SELECT MAX(salary) AS max_salary FROM Employee;

-- 10. Calculate total salary in Employee table
SELECT SUM(salary) AS total_salary FROM Employee;

-- 11. Calculate average salary in Employee table
SELECT AVG(salary) AS average_salary FROM Employee;

-- 12. Count the number of employees in Employee table
SELECT COUNT(*) AS employee_count FROM Employee;

-- 13. Select employee names from Employee where names are in TE
SELECT DISTINCT emp_name FROM Employee WHERE emp_name IN (SELECT emp_name FROM TE);
