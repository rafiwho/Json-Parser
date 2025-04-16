-- Create a table for employees
CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Insert some sample data
INSERT INTO employees (id, name, age, department, salary)
VALUES (1, 'John Doe', 30, 'Engineering', 75000.00);

-- Select all employees
SELECT * FROM employees;

-- Select employees in Engineering department
SELECT name, age, salary 
FROM employees 
WHERE department = 'Engineering';

-- Update an employee's salary
UPDATE employees 
SET salary = 80000.00 
WHERE id = 1;

-- Delete an employee
DELETE FROM employees 
WHERE id = 1; 