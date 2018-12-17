CREATE DATABASE lab1;

CREATE TABLE users(
  id SERIAL,
  firstname VARCHAR(50),
  lastname VARCHAR(50)
);

-- SELECT * FROM users;

ALTER TABLE users
    ADD COLUMN isadmin INT;

ALTER TABLE users
    ALTER COLUMN isadmin TYPE BOOL USING isadmin::boolean;

ALTER TABLE users
    ALTER COLUMN isadmin SET DEFAULT FALSE;

-- INSERT INTO users VALUES (DEFAULT ,'Aza', 'Qwe', DEFAULT );

ALTER TABLE users
    ADD CONSTRAINT uniq PRIMARY KEY (id);

CREATE TABLE tasks(
  id SERIAL,
  name VARCHAR(50),
  user_id INT
);

-- SELECT * FROM tasks;

DROP TABLE tasks;

DROP DATABASE lab1;