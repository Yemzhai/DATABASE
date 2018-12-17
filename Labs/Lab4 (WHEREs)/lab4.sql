CREATE DATABASE lab5;

CREATE TABLE salesman(
  salesman_id INT PRIMARY KEY,
  name VARCHAR(255),
  city VARCHAR(255),
  comission NUMERIC
);

CREATE TABLE customers(
  customer_id INT PRIMARY KEY,
  cust_name VARCHAR(255),
  city VARCHAR(255),
  grade INT,
  salesman_id INT REFERENCES salesman(salesman_id)
);

CREATE TABLE orders(
  ord_no INT PRIMARY KEY,
  purch_amt REAL,
  ord_date DATE,
  customer_id INT REFERENCES customers(customer_id),
  salesman_id INT REFERENCES salesman(salesman_id)
);

INSERT INTO customers VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
                             (3005, 'Graham Zusi', 'California', 200, 5002),
                             (3001, 'Brad Guzan', 'London', DEFAULT, 5005),
                             (3004, 'Fabian Johns', 'Paris', 300, 5006),
                             (3007, 'Brad Davis', 'New York', 200, 5001),
                             (3009, 'Geoff Camero', 'Berlin', 100, 5003),
                             (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders VALUES (70001, 150.5, '2012-10-05', 3005, 5002),
                          (70009, 270.65, '2012-09-10', 3001, 5005),
                          (70002, 65.26, '2012-10-05', 3002, 5001),
                          (70004, 110.5, '2012-08-17', 3009, 5003),
                          (70007, 948.5, '2012-09-10', 3005, 5002),
                          (70005, 2400.6, '2012-07-27', 3007, 5001),
                          (70008, 5760 ,'2012-09-10' ,3002, 5001);

INSERT INTO salesman VALUES (5001, 'James Hoog', 'New York', 0.15),
                            (5002, 'Nail Knite', 'Paris', 0.13),
                            (5005, 'Pit Alex', 'London', 0.11),
                            (5006, 'Mc Lyon', 'Paris', 0.14),
                            (5003, 'Lauson Hen', DEFAULT, 0.12),
                            (5007, 'Paul Adam', 'Rome', 0.13);

-- SELECT * FROM salesman;
--
-- SELECT * FROM customers;
-- 
-- SELECT * FROM orders;

SELECT sum(purch_amt) FROM orders;

SELECT avg(purch_amt) FROM orders;

SELECT count(*) FROM customers WHERE cust_name IS NOT NULL;

SELECT min(purch_amt) FROM orders;

SELECT * FROM customers WHERE cust_name LIKE '%b';

SELECT * FROM orders WHERE customer_id IN (SELECT customer_id FROM customers WHERE city = 'New York');

SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders WHERE purch_amt > 10);

SELECT sum(grade) FROM customers;

SELECT * FROM customers WHERE cust_name IS NOT NULL;

SELECT max(grade) FROM customers;