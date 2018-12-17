CREATE DATABASE lab2;

CREATE TABLE countries(
  country_id SERIAL,
  country_name VARCHAR(50),
  region_id INT,
  population INT,
  PRIMARY KEY (country_id)
);

-- SELECT * FROM countries;

INSERT INTO countries VALUES (1, 'KZ', 9, 99999);

UPDATE countries SET region_id = NULL;

INSERT INTO countries (country_name, region_id, population) VALUES ('RUS', 8, 999999);
INSERT INTO countries VALUES (DEFAULT , 'USA', 11, 888888);
INSERT INTO countries (country_name, region_id) VALUES ('KYR', 1);

ALTER TABLE countries
    ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (country_name) VALUES (DEFAULT);

INSERT INTO countries VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT );

CREATE TABLE countries_new(
  LIKE countries
);

-- SELECT * FROM countries_new;

INSERT INTO countries_new SELECT * FROM countries;

UPDATE countries_new SET region_id = 1 WHERE region_id IS NULL;

UPDATE countries_new SET population = population * 1.1
RETURNING country_name, population as "New Population";

DELETE FROM countries WHERE population < 100000;

DELETE FROM countries_new as cn USING countries as c WHERE cn.country_id = c.country_id
RETURNING *;

DELETE FROM countries
RETURNING *;