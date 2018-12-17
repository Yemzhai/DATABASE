--1
-- SELECT * FROM countries WHERE name = 'string';
CREATE INDEX countries_name ON countries(name);

--2
-- SELECT * FROM employees WHERE name = 'string' AND surname = 'string';
CREATE INDEX employees_name ON employees(name, surname);

--3
-- SELECT * FROM employees WHERE salary < value1 AND salary > value2;
CREATE INDEX employees_salary ON employees(salary);

--4
-- SELECT * FROM employees WHERE substring(name from 1 to 4) = 'abcd';
CREATE INDEX employees_substring ON employees(substring(name));

--5
-- SELECT * FROM employees e JOIN departments d
--                   ON d.department_id = e.department_id WHERE d.budget > value2 AND e.salary > value2;
CREATE INDEX employees_salary ON employees(salary);
CREATE INDEX department_budget ON departments(budget);
