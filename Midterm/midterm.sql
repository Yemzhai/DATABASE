
CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL UNIQUE,
  rating INTEGER,
  genre VARCHAR(50) NOT NULL
);

CREATE TABLE theaters (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  size INTEGER,
  city VARCHAR(50) NOT NULL
);

INSERT INTO movies (title, rating, genre) VALUES ('NOMER1', 15, 'hentai'),('NOMER2', 15, 'hentai'),('NOMER3', 15, 'horror');
INSERT INTO movies (title, rating, genre) VALUES ('NOMER4', 18, 'horror'),('NOMER5', 5, 'naruto'),('NOMER6', 22, 'anieme');
INSERT INTO movies (title, rating, genre) VALUES ('NOMER7', NULL, 'horror'),('NOMER8', NULL, 'naruto');
INSERT INTO theaters (name, size, city) VALUES ('tNOMER1', 100, 'ASTANA'),('tNOMER2', 125, 'KOSTANAI'),('tNOMER3', 200, 'ALMATY');
INSERT INTO theaters (name, size, city) VALUES ('tNOMER4', 120, 'ASTANA'),('tNOMER5', 145, 'ALMATY'),('tNOMER6', 95, 'PETROVAVLOSVK');

SELECT DISTINCT ON(genre) * FROM movies; 
SELECT * FROM movies ORDER BY rating DESC LIMIT 3;
SELECT * FROM theaters ORDER BY size DESC LIMIT 1 OFFSET 2;
SELECT * FROM movies WHERE rating is NULL;
SELECT * FROM theaters WHERE (city = 'ASTANA' or city = 'ALMATY') and size > 125;
SELECT id AS MovieId, (SELECT format('The genre of %s is %s', title, genre)) AS MovieInfo FROM movies;

CREATE TABLE movietheaters (
		theatger_id INTEGER REFERENCES theaters(id),	
		movie_id INTEGER REFERENCES movies(id),
		rating INTEGER
);

SELECT * FROM theaters WHERE id NOT IN (SELECT theatger_id
               FROM movietheaters
               GROUP BY theatger_id
               HAVING count(*) > 0);
               
SELECT * FROM movietheaters;

SELECT * FROM movies;

INSERT INTO movietheaters (theatger_id, movie_id, rating) VALUES (1,4,15) , (2,6,10);


SELECT *,
CASE WHEN (rating < 3) THEN 'low'
	WHEN rating < 7 and movies.rating > 3 THEN 'medium'
	 WHEN rating < 11 and movies.rating > 7 THEN 'high'
END AS quality
FROM movies;

UPDATE movies SET rating = 1 WHERE rating is NULL;
DELETE FROM movies WHERE id NOT IN 
(SELECT movie_id
               FROM movietheaters
               GROUP BY movie_id
               HAVING count(*) > 0);

INSERT INTO movies (title, rating, genre) VALUES ('Toean', 213, 'hentai1');

SELECT * FROM movies WHERE title LIKE 'T_e%n';

SELECT DISTINCT ON(genre) genre, avg(rating) FROM movies GROUP BY genre;

SELECT name FROM theaters WHERE id IN (SELECT theatger_id FROM movietheaters GROUP BY theatger_id HAVING count(*) > 0);

