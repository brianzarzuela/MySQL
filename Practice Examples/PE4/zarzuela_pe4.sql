-- ---------------------------------------------------------------------------------

-- File       : zarzuela_pe4.sql
-- Author     : Brian Zarzuela
-- Date       : 3 February 2020
--
-- Desciption :
--    Set of tasks for selecting data from the contact_info table of the conman database.
--    Please install a fresh copy of the conman database by running the 
--    createCONTACT_INFO.sql and insertContact_Info.sql scripts.

-- ---------------------------------------------------------------------------------

USE conman;

--  Task 1
--    Change the primary key of contact_info form contactID to contactID and phone_number.
ALTER TABLE contact_info
DROP PRIMARY KEY;

ALTER TABLE contact_info
ADD PRIMARY KEY contact_info_pk(contactID, phone_number);

--  Task 2
--    Change the firstname attribute to be a variable length string of up to 15 characters.
--    A value is required. If a value isn't specified 'UNKNOWN' should appear.
--    Change the lastname attribute to be a fixed length string of up to 30 characters.
--    A value is required. If a value isn't specified 'UNKNOWN' should appear.
ALTER TABLE contact_info
MODIFY COLUMN firstname VARCHAR(15) NOT NULL DEFAULT 'UNKNOWN';

ALTER TABLE contact_info
MODIFY COLUMN lastname CHAR(30) NOT NULL DEFAULT 'UNKNOWN';


--  Task 3
--    Add a record to the contact_info table without specifying values for firstname and lastname.
INSERT INTO contact_info (contactID, phone_number) VALUES (101, '585-555-5555');

--  Task 4
--    Add an attribute 'owes' that will hold the amount of money that a contact may owe you.
--    Should be capable of storing the amount in the format ####.##
ALTER TABLE contact_info
ADD COLUMN owes DECIMAL(6,2);