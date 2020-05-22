-- ---------------------------------------------------------------------------------

-- File       : zarzuela_HW9.sql
-- Author     : Brian Zarzuela
-- Date       : April 2020
--
-- Desciption :
--    Set of commands for querying from the book database.
--
-- Notes      :
--    First run the script createBOOK.sql to create the book database.

-- ---------------------------------------------------------------------------------


-- Open the database
use book;


-- ---------------------------------------------------------------------------------
--  1. Count the number of publishers that are in each city, statecode combination.
--     Sort by the count of the number of publishers in ascending order, followed by
--     the location in descending order.
select concat(City, ', ', StateCode) as 'Location',
       count(PublisherID) as 'Count'
from Publisher
group by City, StateCode
order by count(PublisherID), concat(City, ', ', StateCode) desc;


-- ---------------------------------------------------------------------------------
--  2. For every book in the book table, show the title, the count of the number of
--     ratings, the minimum rating, the maximum rating, and the average rating
--     rounded to the nearest penny.
--     Sort by the count of the number of ratings in descending order, followed by
--     the average ratings in descending order.
select title,
       count(Rating) as 'Total Ratings',
       min(Rating) as 'Low',
       max(Rating) as 'High',
       avg(Rating) as 'Average'
from Book left join BookReview
on Book.ISBN = BookReview.ISBN
group by title, BookReview.ISBN
order by count(Rating) desc, avg(Rating) desc;


-- ---------------------------------------------------------------------------------
--  3. Show the publisher name and count of books pubilshed for those publishers
--     that have published more than two books. Sort by the count of books published
--     in descending order, followed by publisher name in ascending order.
select Name as 'Publisher Name',
       count(ISBN) as 'Book Count'
from Publisher, Book
where Publisher.PublisherID = Book.PublisherID
group by Name, Book.PublisherID
having count(ISBN) > 2
order by count(ISBN) desc, Name;


-- ---------------------------------------------------------------------------------
--  4. Select all of the book titles that have "bill" in their name and display the
--     title of the book, the length of the title, and the part of the title that
--     follows "bill".
select title,
       length(title) as 'Length',
       substr(title, instr(lower(title), 'bill') + 4) as 'After Bill'
from Book
where instr(lower(title), 'bill') > 0
order by title desc;


-- ---------------------------------------------------------------------------------
--  5. Show a listing of used books titles that are available.
select distinct title
from Book inner join OwnersBook
on Book.ISBN = OwnersBook.ISBN;


