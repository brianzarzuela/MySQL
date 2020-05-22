-- Midterm Practice

use sakila_v1;

--  show the name and length of films that include 'fun' in the description
--  and are 120 minutes or less
select Title, Length
from film
where description like '%fun%' and length <= 120;


--  show the name of films that end in a vowel
select Title
from film
where title like '%a' or
      title like '%e' or
      title like '%i' or
      title like '%o' or
      title like '%u';


--  show the name of films with a length that is 120 minutes or longer,
--  but are also 180 minutes or less
select Title
from film
where length between 120 and 180;


--  show the title and length of films that have 'river' in the title and
--  a rating of either 'pg' or 'pg-13'
select Title
from film
where title like '%river%' and rating in ('pg', 'pg-13');


--  show the names of movies that have been released after 2012 with a length
--  greater than 160
select Title
from film
where release_year > 2012 and length > 160;


--  show the name, replacement cost, and rating of movies that do not have 'a'
--  as the second letter of the name and have a replacement cost of $19.99
select Title, replacement_cost as 'Replacement Cost', Rating
from film
where title not like '_a%' and replacement_cost = 19.99;


--  show the names of movies that do not have a description
select Title
from film
where description is null;


--  show the replacement cost for te film Town Ark
select replacement_cost as 'Replacement Cost'
from film
where title = 'Town Ark';


--  show the names of movies that are rated 'g' and releaed in 2006 or movies
--  that are rated 'pg' and releaed in 2010
select Title
from film
where (rating = 'g' and release_year = 2006) or (rating = 'pg' and release_year = 2010);


--  show all the data, except for the description, for films that were not released
--  in either 2006 or 2010
select film_id as 'Film ID', 
       Title, release_year as 'Release Year',
       Length,
       replacement_cost as 'Replacement Cost',
       Rating
from film
where release_year not in (2006, 2010);


--  for films released in 2006, change the replacement cost to 5.59 using one statement
update film
set replacement_cost = 5.59
where release_year = 2006;

select title, release_year, replacement_cost
from film
where release_year = 2006;


--  remove all films that are less than 60 minutes long and rated PG
delete
from film
where length < 60 and rating = 'pg';

select title
from film
where length < 60 and rating = 'pg';
















