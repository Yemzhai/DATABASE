SELECT deparment
FROM Course
WHERE courseName = 'asd'; --1

SELECT
  studentID,
  c.deparment
FROM enroll e
  JOIN course c ON e.courseName = c.courseName;

CREATE INDEX enroll_coursename
  ON enroll (courseName); --2


SELECT courseName
FROM enroll
WHERE studentID = 1;

CREATE INDEX enroll_studentID
  ON enroll (studentID); --3


SELECT office
FROM instructor
WHERE instrID IN (SELECT instrID
                  FROM Course); --4


SELECT *
FROM Student
WHERE major = '123';

CREATE INDEX student_major
  ON Student (major); --5


SELECT *
FROM Movie
WHERE mID IN (SELECT mID
              FROM rating
              GROUP BY mID
              HAVING count(*) > 2);


SELECT
  m.title,
  max(r.stars)
FROM Movie m
  JOIN Rating r ON m.mID = r.mID
GROUP BY m.mID
ORDER BY m.title;


SELECT name
FROM Reviewer
WHERE rID IN (SELECT rID
              FROM rating
              WHERE ratingDate IS NULL);


CREATE VIEW v AS
  SELECT title
  FROM Movie
  WHERE mID IN (SELECT mID
                FROM rating
                WHERE rID IN (SELECT rID
                              FROM reviewer
                              WHERE name = 'Mike Anderson'))
        AND director IS NOT NULL;


CREATE INDEX ind
  ON rating (rID);
CREATE INDEX ind
  ON reviewer (name);


SELECT *
FROM Reviewer
WHERE rID IN (SELECT rID
              FROM rating
              GROUP BY rID
              HAVING count(*) > 2);


SELECT *
FROM Reviewer
WHERE rID IN (SELECT rID
              FROM rating
              WHERE mID IN (SELECT mID
                            FROM movie
                            WHERE director = 'Steven Spielberg'));


CREATE INDEX ind
  ON rating (mID);

CREATE INDEX ind
  ON movie (director);
