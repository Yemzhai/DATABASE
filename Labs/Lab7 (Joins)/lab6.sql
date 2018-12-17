--1
SELECT first_name, last_name, d.department_id, department_name FROM departments 
  AS d INNER JOIN employees AS e ON d.department_id = e.department_id;

--2
SELECT first_name, last_name, d.department_id, department_name FROM departments 
  AS d INNER JOIN employees AS e ON d.department_id = e.department_id AND d.department_id IN (80, 40);

--3
SELECT first_name, last_name, d.location_id, state_province FROM departments 
  AS d INNER JOIN employees AS e ON d.department_id = e.department_id INNER JOIN locations AS l ON d.location_id = l.location_id;

--4
SELECT first_name, last_name, d.department_id, d.department_name FROM employees 
  AS e RIGHT JOIN departments AS d ON e.department_id = d.department_id;

--5
SELECT first_name, last_name, d.department_id, d.department_name FROM employees
  AS e LEFT JOIN departments AS d ON e.department_id = d.department_id;
