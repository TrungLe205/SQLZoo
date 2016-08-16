-- #1 List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962;
 
-- #2 Give year of 'Citizen Kane'.
 SELECT yr
FROM movie WHERE title = 'Citizen Kane';

-- #3 List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%';

-- #4 What are the titles of the films with id 11768, 11955, 21191
SELECT title
FROM movie
WHERE id IN ('11768', '11955', '21191');

-- #5 What id number does the actress 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- #6 What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- #7 Obtain the cast list for 'Casablanca'.
SELECT name
FROM casting JOIN actor ON id = actorid
WHERE movieid = 11768;

-- #8 Obtain the cast list for the film 'Alien'
SELECT name
FROM casting JOIN actor ON id = actorid
WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien');

-- #9 List the films in which 'Harrison Ford' has appeared
SELECT title
FROM movie JOIN casting ON id = movieid
WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford');

-- #10 List the films where 'Harrison Ford' has appeared - but not in the starring role
SELECT title
FROM movie JOIN casting ON id = movieid
WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford')
AND ord != 1;

-- #11 SELECT title, name
FROM movie JOIN casting ON id = movieid
JOIN actor ON actor.id = actorid
WHERE yr = 1962 AND ord = 1;

-- #12 Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t
);

-- #13 List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name FROM movie
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews');

