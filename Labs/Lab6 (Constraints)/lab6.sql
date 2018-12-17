DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Reviewer;
DROP TABLE IF EXISTS Rating;

CREATE TABLE Movie(
  mID INT,
  title TEXT,
  year INT,
  director TEXT
);

CREATE TABLE Reviewer(
  rID INT,
  name TEXT
);

CREATE TABLE Rating(
  rID INT,
  mID INT,
  stars INT,
  ratingDate DATE
);

--1 (Constraint Declarations)
--1
ALTER TABLE Movie
    ADD CONSTRAINT movie_mid_u_key UNIQUE(mID),
    ADD CONSTRAINT movie_mid_n_null CHECK(mID IS NOT NULL);

--2
ALTER TABLE Movie
    ADD CONSTRAINT movie_title_year_p_key PRIMARY KEY(title, year);

--3
ALTER TABLE Reviewer
    ADD CONSTRAINT reviewer_rid_p_key PRIMARY KEY(rID);

--4
ALTER TABLE Rating
    ADD CONSTRAINT rating_rid_mid_date_p_key UNIQUE(rID, mID, ratingDate);

--5
ALTER TABLE Reviewer
    ALTER COLUMN name SET NOT NULL;

--6
ALTER TABLE Rating
    ALTER COLUMN stars SET NOT NULL;

--7
ALTER TABLE Movie
    ADD CONSTRAINT movie_year_check CHECK(year > 1900);

--8
ALTER TABLE Rating
    ADD CONSTRAINT rating_stars_check CHECK(stars in (1, 2, 3, 4, 5));

--9
ALTER TABLE Rating
    ADD CONSTRAINT rating_date_check CHECK(ratingDate > '2000-01-01');

--10
ALTER TABLE Movie
    ADD CONSTRAINT movie_director_year_check CHECK (CASE
                                                    WHEN director = 'Steven Spielberg' AND year > 1990
                                                      THEN FALSE
                                                    WHEN director = 'James Cameron' AND year < 1990
                                                      THEN FALSE
                                                    ELSE TRUE
                                                    END
)

--2 (Load the DB)
INSERT INTO Movie VALUES(101, 'Gone with the Wind', 1939, 'Victor Fleming'),
                        (102, 'Star Wars', 1977, 'George Lucas'),
                        (103, 'The Sound of Music', 1965, 'Robert Wise'),
                        (104, 'E.T.', 1982, 'Steven Spielberg'),
                        (105, 'Titanic', 1997, 'James Cameron'),
                        (106, 'Snow White', 1937, null),
                        (107, 'Avatar', 2009, 'James Cameron'),
                        (108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

INSERT INTO Reviewer VALUES(201, 'Sarah Martinez'),
                           (202, 'Daniel Lewis'),
                           (203, 'Brittany Harris'),
                           (204, 'Mike Anderson'),
                           (205, 'Chris Jackson'),
                           (206, 'Elizabeth Thomas'),
                           (207, 'James Cameron'),
                           (208, 'Ashley White');

INSERT INTO Rating VALUES(201, 101, 2, '2011-01-22'),
                         (201, 101, 4, '2011-01-27'),
                         (202, 106, 4, NULL),
                         (203, 103, 2, '2011-01-20'),
                         (203, 108, 4, '2011-01-12'),
                         (203, 108, 2, '2011-01-30'),
                         (204, 101, 3, '2011-01-09'),
                         (205, 103, 3, '2011-01-27'),
                         (205, 104, 2, '2011-01-22'),
                         (205, 108, 4, NULL),
                         (206, 107, 3, '2011-01-15'),
                         (206, 106, 5, '2011-01-19'),
                         (207, 107, 5, '2011-01-20'),
                         (208, 104, 3, '2011-01-02');

--3 (Constraint Enforcement)
-- Must not work!
--11
UPDATE Movie SET mID = mID + 1;

--12
INSERT INTO Movie VALUES ('109', 'Titanic', 1997, 'JC');

--13
INSERT INTO Reviewer VALUES (201, 'Ted Codd');

--14
UPDATE Rating SET rID = 205, mID = 104;

--15
INSERT INTO Reviewer VALUES (209, NULL);

--16
UPDATE Rating SET stars = null WHERE rID = 208;

--17
UPDATE Movie SET year = year - 40;

--18
UPDATE Rating SET stars = stars + 1;

--19
INSERT INTO Rating VALUES (201, 101, 1, '1999-01-01');

--20
INSERT INTO Movie VALUES (109, 'Jurassic Park', 1993, 'Steven Spielberg');

--21
UPDATE Movie SET year = year - 10 WHERE title = 'Titanic';

-- Must work!
--22
INSERT INTO Movie VALUES (109, 'Titanic', 2001, NULL);

--23
UPDATE Rating SET mID = 109;

--24
UPDATE Movie SET year = 1901 WHERE director <> 'James Cameron';

--25
UPDATE Rating SET stars = stars - 1;

--4 (Referential Integrity Declarations)
--26
ALTER TABLE Rating
    ADD CONSTRAINT rating_rid_f_key_1 FOREIGN KEY(rID) REFERENCES Reviewer ON UPDATE CASCADE,
    ADD CONSTRAINT rating_rid_f_key_2 FOREIGN KEY(rID) REFERENCES Reviewer ON DELETE SET NULL;

ALTER TABLE Rating
    ADD CONSTRAINT rating_mid_f_key_1 FOREIGN KEY(mID) REFERENCES Movie(mID) ON DELETE CASCADE;

--5 (Reload the DB)
-- # Recreate the three tables using your modified CREATE TABLE statements.
-- # You should be able to load the original data (i.e., execute all of the INSERT statements in the data file)
-- # without any errors.

--6 (Referential Integrity Enforcement)
-- Must not work!
--27
INSERT INTO Rating VALUES(209, 109, 3, '2001-01-01');

--28
UPDATE Rating SET rID = 209 WHERE rID = 208;

--29
UPDATE Rating SET mID = mID + 1;

--30
UPDATE Movie SET mID = 109 WHERE mID = 108;

-- Must work!
--31
UPDATE Movie SET mID = 109 WHERE mID = 102;

SELECT * FROM Movie;

--32
UPDATE Reviewer SET rID = rID + 10;

--33
DELETE FROM Reviewer WHERE rID > 215; -- now work!

--34
DELETE FROM Movie WHERE mID < 105;

-- FINAL CHECK
--35
SELECT sum(rID) FROM Rating WHERE rID IS NOT NULL;

SELECT sum(stars) FROM Rating WHERE rid = 0;



 
