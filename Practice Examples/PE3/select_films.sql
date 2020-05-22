-- ---------------------------------------------------------------------------------

-- File       : select_films.sql
-- Author     : Brian Zarzuela
-- Date       : 3 February 2020
--
-- Desciption :
--    Set of tasks for selecting films from the film table of the sikalv1 database.
--    Please install a fresh copy of the database (sakila_v1.sql) before beginning.

-- ---------------------------------------------------------------------------------

USE sakilav1;

--  Task 1
--    Show the name and length of the films that include 'fun' in the description
--    and are 120 minutes or less.
SELECT Title, Length
FROM film
WHERE description LIKE '%fun%' and Length <= 120;

--  Task 2
--    Show the name of films that end in 'a', 'e', 'i', 'o', or 'u'.
SELECT Title
FROM film
WHERE title LIKE '%a' OR
      title LIKE '%e' OR
      title LIKE '%i' OR
      title LIKE '%o' OR
      title LIKE '%u';

--  Task 3
--    Show the name of films with a length that is 120 minutes or longer,
--    but are also 180 minutes or less.
SELECT Title
FROM film
WHERE length BETWEEN 120 AND 180;

--  Task 4
--    Show the title and length of films that have 'river' in the title and a
--    rating either 'PG' or 'PG-13'
SELECT Title, LENGTH
FROM film
WHERE title LIKE '%river%' AND rating IN ('PG', 'PG-13');

--  Task 5
--    Show the title of films that have been realeased after 2012 and are
--    longer than 160 minutes.
SELECT Title
FROM film
WHERE release_year > 2012 AND length > 160;

--  Task 6
--    Show the title, replacement cost, and rating of films that do not have 'a'
--    as the second letter of the name and have a replacement cost of $19.99
SELECT Title, replacement_cost AS 'Replacement Cost', Rating
FROM film
WHERE title NOT LIKE '_a%' AND replacement_cost = 19.99;

--  Task 7
--   Show the title of films that do not have a description
SELECT Title
FROM film
WHERE description IS NULL;

--  Task 8
--    Show the replacement cost for the film Town Ark
SELECT replacement_cost AS 'Replacement Cost'
FROM film
WHERE title = 'Town Ark';

--  Task 9
--    Show the title of films that are rated 'G' and release in 2006 or
--    films that are rated 'PG' and release in 2010
SELECT Title
FROM film
WHERE (rating = 'G' AND release_year = 2006) OR
      (rating = 'PG' AND release_year = 2010);

--  Task 10
--    Show all data, except for the description, for films that were
--    not released in either 2006 or 2010.
SELECT film_id AS 'Film ID',
       Title,
       release_year AS 'Release Year',
       Length,
       replacement_cost AS 'Replacement Cost',
       Rating
FROM film
WHERE release_year NOT IN (2006, 2010);

--  Task 11
--    Change replacement cost to 5.59 for films release in 2006
UPDATE film
SET replacement_cost = 5.59
WHERE release_year = 2006;

--  Task 12
DELETE
FROM film
WHERE length < 60 AND rating = 'PG';












