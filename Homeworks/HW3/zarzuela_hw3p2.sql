-- ---------------------------------------------------------------------------------

-- File       : zarzuela_hw3p2.sql
-- Author     : Brian Zarzuela
-- Date       : 4 February 2020
--
-- Desciption :
--    Set of tasks for modifying the contact_info table of the conman database.
--    Please install a fresh copy of the conman database and contact_info table
--    with President Destler's record inserted by running the (createCONTACT_INFO.sql)
--    and (insertContact_Info.sql) scripts before beginning.

-- ---------------------------------------------------------------------------------

USE conman;

--  Task 1
--    Add new data into contact_info
INSERT INTO contact_info VALUES (2, 'Eli', 'T', 'Wallowby', 'III', 'Mr.', 'Director', 'Finance', 'etwallowby@concor.com', 'www.concor.com/~wallowby', 'etwallowby', '505-546-3322 ext. 23', 'work', '1956-03-26', 'All meetings must be scheduled through his assistant.', 'Concor International, Inc.', '152 North Main Street', NULL, 'Beverly Hills', 'CA', '90210-3715', 'USA', 'www.concor.com', '323-555-6115');
INSERT INTO contact_info VALUES (3, 'Eve', 'C', 'Sampson', NULL, 'Mrs.', 'Assistant to Finance Director', 'Finance', 'esampson@concor.com', NULL, 'esampson', '505-546-3322 ext. 30', 'work', '1972-05-11', 'Very helpful.', 'Concor International, Inc.', '152 North Main Street', NULL, 'Beverly Hills', 'CA', '90210-3715', 'USA', 'www.concor.com', '323-555-5000');
INSERT INTO contact_info (contactID, firstname, middleinitial, lastname, suffix_description, title_description, jobtitle, department, email, phone_number, phonetype_description, birthday, notes, companyname, company_url) VALUES (4, 'Carson', 'B', 'Campbell', 'III', 'Dr.', 'Chief of Medicine', 'Geriatrics', 'cbc232@mvch.org', '585-222-2121', 'Home', '1955-01-05', 'Wife: Lisa Kids: Lucas, Lucy, and Lucinda.', 'Mountain View Hospital', 'www.mvch.org');
INSERT INTO contact_info (contactID, firstname, lastname, title_description, jobtitle, department, email, phone_number, phonetype_description, birthday, notes, companyname, company_url) VALUES (5, 'Brian', 'Zarzuela', 'Mr.', 'Student', 'Academics', 'bxz1515@rit.edu', '917-111-1111', 'Home', '1997-05-23', 'Enrolled in ISTE-230.', 'Rochester Institute of Technology', 'www.rit.edu');

--  Task 2
--    Add an attribute 'nickname' a variable length string of up to 20 characters.
--    Does not have to have a value. When a value isn't specified 'To Be Determined' should be used.
ALTER TABLE contact_info
ADD COLUMN nickname VARCHAR(20) NULL DEFAULT 'To Be Determined';

--  Task 3
--    Add constraints to modify the firstname and lastname attributes so that a value is
--    required to be entered when new records are added.
ALTER TABLE contact_info
MODIFY COLUMN firstname VARCHAR(15) NOT NULL;

ALTER TABLE contact_info
MODIFY COLUMN lastname VARCHAR(25) NOT NULL;

--  Task 4
--    Update the existing record for President Destler to add a nickname of 'Bill' for him.
UPDATE contact_info
SET nickname = 'Bill'
WHERE jobtitle = 'President' AND lastname = 'Destler'; 

--  Task 5
--    Delete the record of any contact that is associated with the 'Concor International, Inc.' company.
DELETE
FROM contact_info
WHERE companyname = 'Concor International, Inc.';


