CREATE DATABASE midterm;

--1

CREATE TABLE movies(
  id SERIAL PRIMARY KEY ,
  title VARCHAR(255) NOT NULL UNIQUE ,
  rating INTEGER,
  genre VARCHAR(50) NOT NULL
);

CREATE TABLE theatres(
  id SERIAL PRIMARY KEY ,
  name VARCHAR(255) NOT NULL UNIQUE ,
  size INTEGER CHECK (size > 3) NOT NULL ,
  city VARCHAR(50) NOT NULL
);

INSERT INTO movies(id,title,rating,genre) VALUES (1, 'Citizen Kane', 5, 'Drama'),
                                                 (2,'Singin'' in the Rain',7,'Comedy'),
                                                 (3,'The Wizard of Oz',7,'Fantasy'),
                                                 (4,'4 The Quiet Man',NULL ,'Comedy'),
                                                 (5,'North by Northwest',NULL,'Thriller'),
                                                 (6,'The Last Tango in Paris',9,'Drama'),
                                                 (7,'Some Like it Hot',4,'Comedy'),
                                                 (8,'A Night at the Opera',NULL ,'Comedy');

INSERT INTO theatres(id,name,size,city) VALUES (1, 'Kinopark Esentai', 15, 'Almaty'),
                                                (2,'Star Cinema Mega',7,'Almaty'),
                                               (3,'Kinopark 8',9,'Shymkent'),
                                               (4,'Star Cinema 15',11,'Astana'),
                                               (5,'Cinemax',4,'Aktau');

SELECT *FROM movies;

SELECT *FROM theatres;
--2

SELECT DISTINCT ON(genre) title FROM movies;

--3

SELECT *FROM movies ORDER BY rating DESC LIMIT 3;

--4

SELECT *FROM theatres ORDER BY size LIMIT 1 OFFSET 2;

--5

SELECT *FROM movies WHERE rating IS NULL;

--6

SELECT *FROM theatres WHERE city IN (SELECT city FROM theatres WHERE city = 'Almaty' OR city = 'Shymkent') AND size >= 7;

--7

SELECT id AS "Movie ID",format('The genre of %s is %s',title,genre) AS "MovieInfo" FROM movies;

--8

CREATE TABLE movietheaters(
  theater_id INT REFERENCES theatres(id),
  movie_id INT REFERENCES movies(id),
  rating INT,
  PRIMARY KEY(theater_id,movie_id)
);

INSERT INTO movietheaters(theater_id,movie_id,rating) VALUES  (1, 5, 5),
                                                              (3, 1, 7),
                                                              (1, 3, 9),
                                                              (4, 6, 6),
                                                              (2, 3, 5),
                                                              (4, 4, 7);


--9

SELECT *FROM theatres WHERE id NOT IN (SELECT  theater_id FROM movietheaters);

--10

SELECT title,CASE
          WHEN rating <= 3 THEN 'Low rating'
          WHEN rating >= 4 AND rating <= 7 THEN ' Medium rating'
          WHEN rating >= 8 AND rating <= 10 THEN 'High rating'
          WHEN rating IS NULL THEN 'No rating'
          END
FROM movies;

--11

UPDATE movies SET rating = 1 WHERE rating IS NULL;

SELECT *FROM movietheaters;

--12

DELETE FROM movies WHERE id NOT IN (SELECT movie_id FROM movietheaters);

--13

SELECT title FROM movies WHERE title IN (SELECT title FROM movies WHERE title LIKE 'T_e%n');

--14

SELECT AVG(rating) FROM movies GROUP BY genre;

--15

SELECT id,name
FROM theatres WHERE id IN (SELECT theater_id FROM movietheaters
                           GROUP BY theater_id HAVING COUNT(movie_id) > 1);

DROP DATABASE midterm;
DROP TABLE movies;
DROP TABLE theatres;
DROP TABLE movietheaters;
--------------------------------------------------------------------------------

CREATE DATABASE midterm2;

SELECT * FROM movies;

SELECT * FROM theatres;

SELECT *
FROM movietheaters;

--1

CREATE TABLE movies(
  id SERIAL PRIMARY KEY ,
  title VARCHAR(255) NOT NULL UNIQUE ,
  rating INT,
  genre VARCHAR(50) NOT NULL
);

CREATE TABLE theatres(
  id SERIAL PRIMARY KEY ,
  name VARCHAR(255) NOT NULL UNIQUE ,
  size INTEGER CHECK (size > 3) NOT NULL ,
  city VARCHAR(50) NOT NULL
);

INSERT INTO movies (title, rating, genre) VALUES
                                                 ('Citizen Kane', 5, 'Drama'),
                                                 ('Singing in the Rain', 8, 'Comedy'),
                                                 ('The Wizard of Oz', 2, 'Fantasy'),
                                                 ('The Quiet Man', null , 'Comedy'),
                                                 ('North by Nortwest', null , 'Thriller'),
                                                 ('The Last Tango in Paris', 9, 'Drama'),
                                                 ('Some Like it Hot', 4, 'Comedy'),
                                                 ('A Night at the Opera', null , 'Comedy');

INSERT INTO theatres (name, size, city) VALUES
                                               ('Kinopark Esentai', 15, 'Almaty'),
                                               ('Star Cinema Mega', 7, 'Almaty'),
                                               ('Kinopark 8', 9, 'Shymkent'),
                                               ('Star Cinema 15', 11, 'Astana'),
                                               ('Cinema', 4, 'Aktau');


--2
SELECT DISTINCT ON(city) name FROM theatres;

--3

SELECT name FROM theatres ORDER BY size DESC LIMIT 3;

--4
SELECT title FROM movies ORDER BY rating DESC LIMIT 1 OFFSET 2;

--5
SELECT title FROM movies WHERE rating IS NOT NULL;

--6
SELECT title FROM movies WHERE genre = 'Comedy' AND rating IS NOT NULL
    UNION SELECT title FROM movies WHERE genre = 'Fantasy' AND rating IS NOT NULL ;

--7
SELECT id AS "Movie ID",CASE
    WHEN rating <= 3 THEN format('The rating of %s is Low',title)
    WHEN rating >= 4 AND rating <= 7 THEN format('The rating of %s is Medium',title)
    WHEN rating >= 8 AND rating <= 10 THEN format('The rating of %s is High',title)
    WHEN rating IS NULL THEN format('The %s has no rating',title)
    END
AS "MovieInfo"
FROM movies;

--8
CREATE TABLE movietheaters(
  theater_id INT REFERENCES theatres(id),
  movie_id INT REFERENCES movies(id),
  rating INT,
  PRIMARY KEY (theater_id, movie_id)
);

INSERT INTO movietheaters (theater_id, movie_id, rating) VALUES
                                                                (1, 5, 5),
                                                                (3, 1, 7),
                                                                (1, 3, 9),
                                                                (4, 6, 6),
                                                                (2, 3, 5),
                                                                (4, 4, 7);

--9

SELECT id,title FROM movies WHERE id NOT IN (SELECT movie_id FROM movietheaters
                                             GROUP BY movie_id HAVING COUNT(theater_id) > 0);

--10
SELECT UPPER(title),SUBSTRING(title,4),LENGTH(title) FROM movies;

--11
UPDATE movies SET rating = 1 WHERE rating IS NULL;

--12
DELETE FROM movies WHERE id NOT IN (SELECT movie_id FROM movietheaters );

--13
SELECT title FROM movies WHERE title LIKE 'S%o_';

--14
SELECT AVG(size),city FROM theatres GROUP BY city;

--15
SELECT id, title FROM movies
WHERE id IN (SELECT movie_id FROM movietheaters GROUP BY movie_id HAVING count(movie_id) > 2);
