-- ---------------------------------------------------------------------------------

-- File       : zarzuela_PE14.sql
-- Author     : Brian Zarzuela
-- Date       : April 2020
--
-- Desciption :
--    Set of commands for 
--
-- Notes      :
--    First run the script PE14.sql to create the PE14 database.
--    Also run the script createBOOK.sql to create the book database.

-- ---------------------------------------------------------------------------------


-- Open the database
use PE14;


-- ---------------------------------------------------------------------------------
--  1. Display the model, manufacturer, serial number, processor speed, and memory
--     for the computer with item id = 3
select i.model, i.manufacturer, c.serialNumber, c.processorspeed, c.memory
from item i inner join computer c
on i.itemID = c.itemID
where i.itemID = 3;


-- ---------------------------------------------------------------------------------
--  2. Display the lease number, salesperson, item id, and quantity for any trucks
--     leased.
select l.leasenumber, l.salesperson, li.Itemid, li.quantity
from (lease l inner join lease_item li
on l.leasenumber = li.leasenumber) inner join item
on li.itemID = item.itemID
where item.type like 'truck';


-- ---------------------------------------------------------------------------------
--  3. Display all attributes (supertype and subtype) for item id = 7
select *
from ((item i left join computer c 
on i.itemID = c.itemID) left join furniture f
on i.itemID = f.itemID) left join truck t
on i.itemID = t.itemID
where i.itemID = 7;


-- Open the database
use book;


-- ---------------------------------------------------------------------------------
--  4. Display the reviewer's name, book title, and rating for books that have a
--     rating between 5 and 7, sorted by rating in descending order and then by
--     title in ascending order.
select r.name as 'Reviewer Name', b.title as 'Book Title', br.Rating
from (book b inner join bookreview br
on b.ISBN = br.ISBN) inner join reviewer r
on br.reviewerID = r.reviewerID
where br.rating between 5 and 7
order by br.rating desc, b.title;


-- ---------------------------------------------------------------------------------
--  5. List the owners and the books they own. List owners even if they do not own a
--     book. List the owner's first and last name and the book's title.
select o.FirstName, o.LastName, b.Title
from (owner o left join ownersBook ob
on o.ownerID = ob.ownerID) left join book b
on ob.ISBN = b.ISBN;


-- ---------------------------------------------------------------------------------
--  6. Show the publisher name and location, count of their ISBN numbers, length of
--     the longest title, and length of the shortest titles for books published by
--     publishers that have 'read' in the publisher's name (using INSTR()) and that
--     have published more than one book.
select concat(p.name, ' in ', p.city, ', ', p.statecode) as 'Publisher Name and Location',
       count(b.ISBN) as '# Books',
       max(length(b.title)) as 'Longest Title',
       min(length(b.title)) as 'Shortest Title'
from publisher p join book b
on p.publisherID = b.publisherID
where instr(lower(p.name), 'read') > 0
group by p.name, p.city, p.statecode
having count(b.ISBN) > 1;


-- ---------------------------------------------------------------------------------
--  7. Show the title and its average rating, rounded to the nearest whole number,
--     and the first 20 characters of the book's description, for all the books that
--     have 'THE' in the title in descending order by average rank and title.
select Title, 
       round(avg(rating)) as 'Avg Rating',
       concat(substr(Description, 1, 20), '...') as 'Description Excerpt'
from Book left join BookReview
on Book.ISBN = BookReview.ISBN
where instr(lower(Title), 'the') > 0
group by Title, Description
order by round(avg(rating)) desc, Title desc;




