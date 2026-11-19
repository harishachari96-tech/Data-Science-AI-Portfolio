CREATE DATABASE  SQL_Assignments;
USE SQL_Assignments;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    department VARCHAR(50) NOT NULL,
    manager VARCHAR(50)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50)
);

INSERT INTO Departments (dept_id, department, manager) VALUES
(1, 'IT', 'Suresh'),
(2, 'HR', 'Meena'),
(3, 'Finance', 'Ramesh'),
(4, 'Sales', 'Anil'),
(5, 'Marketing', 'Kavya');

INSERT INTO Employees (emp_id, emp_name, department, salary, city) VALUES
(1, 'Rahul', 'IT', 45000, 'Bangalore'),
(2, 'Priya', 'HR', 35000, 'Mysore'),
(3, 'Amit', 'IT', 60000, 'Bangalore'),
(4, 'Sneha', 'Finance', 50000, 'Hubli'),
(5, 'Kiran', 'HR', 40000, 'Bangalore'),
(6, 'Arjun', 'Finance', 55000, 'Mysore'),
(7, 'Divya', 'IT', 70000, 'Hubli'),
(8, 'Ravi', 'Sales', 30000, 'Bangalore');

-- =========================================================
-- ASSIGNMENT 1: BASIC SQL (SELECT, WHERE, ORDER BY)
-- =========================================================

-- Q1. Display all columns and all records from Employees.
SELECT *
FROM Employees;

-- Q2. Display name, department, and salary of IT employees.
SELECT emp_name, department, salary
FROM Employees
WHERE department = 'IT';

-- Q3. Find employees whose salary is greater than 40,000.
SELECT *
FROM Employees
WHERE salary > 40000;

-- Q4. Display employees who live in Bangalore, sorted by
--     salary from highest to lowest.
SELECT *
FROM Employees
WHERE city = 'Bangalore'
ORDER BY salary DESC;

-- =========================================================
-- ASSIGNMENT 2: AGGREGATE FUNCTIONS AND GROUP BY
-- =========================================================

-- Q1. Find the total number of employees.
SELECT COUNT(*) AS total_employees
FROM Employees;

-- Q2. Calculate average, highest, and lowest salary.
SELECT
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM Employees;

-- Q3. Find the total number of employees in each department.
SELECT department, COUNT(*) AS employee_count
FROM Employees
GROUP BY department;

-- Q4. Display departments whose average salary is greater
--     than 40,000.
SELECT department, AVG(salary) AS average_salary
FROM Employees
GROUP BY department
HAVING AVG(salary) > 40000;

-- =========================================================
-- ASSIGNMENT 3: JOINS
-- =========================================================

-- Q1. Display each employee's name, department, and manager.
SELECT
    e.emp_name,
    e.department,
    d.manager
FROM Employees AS e
INNER JOIN Departments AS d
    ON e.department = d.department;

-- Q2. Display names of employees who work in Finance.
SELECT e.emp_name
FROM Employees AS e
INNER JOIN Departments AS d
    ON e.department = d.department
WHERE d.department = 'Finance';

-- Q3. Display every department and its employees, including
--     departments that do not have employees.
SELECT
    d.department,
    e.emp_name
FROM Departments AS d
LEFT JOIN Employees AS e
    ON d.department = e.department
ORDER BY d.department, e.emp_name;

-- Q4. Find departments that currently have no employees.
SELECT d.department
FROM Departments AS d
LEFT JOIN Employees AS e
    ON d.department = e.department
WHERE e.emp_id IS NULL;

-- =========================================================
-- ASSIGNMENT 4: SUBQUERIES AND WINDOW FUNCTIONS
-- =========================================================

-- Q1. Find employees earning more than the overall average salary.
SELECT emp_name, salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
);

-- Q2. Find the second-highest distinct salary.
SELECT MAX(salary) AS second_highest_salary
FROM Employees
WHERE salary < (
    SELECT MAX(salary)
    FROM Employees
);

-- Alternative for MySQL 8.0+:
-- SELECT DISTINCT salary
-- FROM Employees
-- ORDER BY salary DESC
-- LIMIT 1 OFFSET 1;

-- Q3. Rank employees by salary from highest to lowest.
SELECT
    emp_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM Employees;

-- Q4. Find the highest-paid employee(s) in each department.
-- DENSE_RANK returns rank 1 to all employees tied for the
-- highest salary within their department.
SELECT department, emp_name, salary
FROM (
    SELECT
        department,
        emp_name,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS dept_salary_rank
    FROM Employees
) AS ranked_employees
WHERE dept_salary_rank = 1;

