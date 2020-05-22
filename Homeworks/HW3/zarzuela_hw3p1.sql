-- ---------------------------------------------------------------------------------

-- File       : zarzuela_hw3p1.sql
-- Author     : Brian Zarzuela
-- Date       : 3 February 2020
--
-- Desciption :
--    Set of tasks for selecting data from the country table of the world database.
--    Please install a fresh copy of the database (HW3DB.sql) before beginning.

-- ---------------------------------------------------------------------------------

USE world;

--  Task 1
--    Show the head of state for the United States
SELECT HeadOfState AS 'Head of State'
FROM country
WHERE name = 'United States';

--  Task 2
--    Change where the head of state is listed as 'George W. Bush' to the name of
--    the current President.
--    Rerun task 1 after the change has been made.
UPDATE country
SET HeadOfState = 'Donald J. Trump'
WHERE HeadOfState = 'George W. Bush';

SELECT HeadOfState AS 'Head of State'
FROM country
WHERE name = 'United States';

--  Task 3
--    Show the name of the countries that do not have an independence year specified.
SELECT name AS 'Country Name'
FROM country
WHERE IndepYear IS NULL;

--  Task 4
--    Show the name and continent of countries that have a population of 1 billion or
--    more and a life expectancy between 70-80.
SELECT Name, Continent
FROM country
WHERE Population >= 1000000000 AND LifeExpectancy BETWEEN 70 AND 80;

--  Task 5
--    Show the countries located in the continents of 'North America' and 'South America'
SELECT NAME
FROM country
WHERE continent IN ('North America', 'South America');