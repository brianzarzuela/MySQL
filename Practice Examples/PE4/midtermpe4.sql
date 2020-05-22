--  Midterm Practice

use conman;


--  change the primary key of contact_info
alter table contact_info
drop primary key;

alter table contact_info
add primary key contact_info_pk(contactID, phone_number);


--  change existing attributes firstname and lastname
alter table contact_info
modify column firstname varchar(15) not null default 'UNKNOWN';

alter table contact_info
modify column lastname char(30) not null default 'UNKNOWN';


--  add a record
insert into contact_info (contactID, phone_number) values (101, '999-999-9999');


--  add a new attribute
alter table contact_info
add column owes decimal(6,2);