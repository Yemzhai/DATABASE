--1
CREATE DATABASE lab4;

--2
CREATE TABLE Warehouses(
  code INT PRIMARY KEY,
  location VARCHAR(255),
  capacity INT
);

CREATE TABLE Boxes(
  code CHAR(4) PRIMARY KEY,
  contents VARCHAR(255),
  value REAL,
  warehouse INT REFERENCES Warehouses(code)
);

--3
INSERT INTO Warehouses(code,location,capacity) VALUES(1,'Chicago',3),
                                                     (2,'Chicago',4),
                                                     (3,'New York',7),
                                                     (4,'Los Angeles',2),
                                                     (5,'San Francisco',8);

INSERT INTO Boxes(code,contents,value,warehouse) VALUES('0MN7','Rocks',180,3),
                                                       ('4H8P','Rocks',250,1),
                                                       ('4RT3','Scissors',190,4),
                                                       ('7G3H','Rocks',200,1),
                                                       ('8JN6','Papers',75,1),
                                                       ('8Y6U','Papers',50,3),
                                                       ('9J6F','Papers',175,2),
                                                       ('LL08','Rocks',140,4),
                                                       ('P0H6','Scissors',125,1),
                                                       ('P2T6','Scissors',150,2),
                                                       ('TU55','Papers',90,5);

--4
SELECT * FROM Warehouses;

--5
SELECT * FROM Boxes WHERE value BETWEEN 50 AND 150;

--6
SELECT DISTINCT ON(warehouse) * FROM Boxes;

--7
SELECT

--8
SELECT * FROM Boxes;

--9
INSERT INTO Warehouses VALUES (6, 'New York', 3);

--10
INSERT INTO Boxes VALUES ('H5RT', 'Papers', 200, 2);

--11
UPDATE Boxes SET value = 0.8*value WHERE warehouse = (
                                                     SELECT code FROM Warehouses ORDER BY capacity ASC LIMIT 1 OFFSET 2);

--12
DELETE FROM Boxes WHERE value < 150;

--13
DELETE FROM Boxes WHERE warehouse IN (
    SELECT code FROM warehouses WHERE location = 'New York'
    )
RETURNING code, warehouse;