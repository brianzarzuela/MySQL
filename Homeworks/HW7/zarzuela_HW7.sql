-- ---------------------------------------------------------------------------------

-- File       : zarzuela_HW7.sql
-- Author     : Brian Zarzuela
-- Date       : April 2020
--
-- Desciption :
--    Set of commands for creating the ACMEOnline database and the its tables from
--    its ER diagram and transposed relations. Also includes the set of statements
--    necessary to add requrested data to tables as well as make requested changes
--    to the user data and structure.
--
-- Notes      :
--    - Database in all uppercase
--    - Tables in lowercase with '_' as word seperators
--    - Attributes in Pascal case
--    - Booleans represented by tinyint(1)
--        - 0 as FALSE
--        - 1 as TRUE

-- ---------------------------------------------------------------------------------

-- Drop the database if it already exists
drop database if exists zarzuela_ACMEOnline;

-- Create the database
create database zarzuela_ACMEOnline;

-- Open the database
use zarzuela_ACMEOnline;


/* ---------------------------------------------------------------------------------
Create the item table from the relation

item (Item_Number, Item_Name, Description, Model, Price)
  PK = Item_Number

- Item_Number should be an integer that will store only positive values and
  automatically increment by 1 when a record is inserted.
- Item_Name should store up to 35 characters. A value is required.
- Description should be up to 255 characters.
- Model should store up to 50 characters. A value is required.
- Price should be able to store digits in the format ######.##. A value is required.
--------------------------------------------------------------------------------- */
create table item(
  Item_Number int unsigned auto_increment,
  Item_Name varchar(35) not null,
  Description varchar(255),
  Model varchar(50) not null,
  Price decimal(8,2) not null,
  constraint item_pk primary key (Item_Number)
);

describe item;


/* ---------------------------------------------------------------------------------
Create the customer table from the relation

customer (CustomerID, CustomerName, Address, Email)

- CustomerID is an integer that will store only positive values and automatically
  incrmeent by 1 when a record is added.
- CustomerName should allow up to 50 characters to be stored. A value is required.
- Address should allow up to 150 characters to be stored. A value is required.
- Email should allow up to 80 characters to be stored.
- A discriminator should be added to determine participation in any subtype(s).
--------------------------------------------------------------------------------- */
create table customer(
  CustomerID int unsigned auto_increment,
  CustomerName varchar(50) not null,
  Address varchar(150) not null,
  Email varchar(80),
  -- Discriminator added for customer type
  CustomerType enum ('business', 'home'),
  constraint customer_pk primary key (CustomerID)
);

describe customer;


/* ---------------------------------------------------------------------------------
Create the order table from the relation

ordered (OrderID, Total_Cost, CustomerID)
  PK = OrderID

- ordered(CustomerID) must exist in customer(CustomerID)

- order is a reserved word in MySQL, so the table will need to be called
  'ordered' instead.
- OrderID should be an integer that will store positive values and automatically
  increment by 1 when a record is added.
- Total_Cost should allow digits in the format of ########.## to be stored.
- If the CustomerID of a customer is changed, that change should be reflected here
  as well.
--------------------------------------------------------------------------------- */
create table ordered(
  OrderID int unsigned auto_increment,
  Total_Cost decimal(10,2),
  CustomerID int unsigned not null,
  -- update of a customer's CustomerID will update the ordered record
  constraint ordered_CustomerID_fk foreign key (CustomerID) references customer(CustomerID)
    on update cascade,
  constraint ordered_pk primary key (OrderID)
);

describe ordered;


/* ---------------------------------------------------------------------------------
Create the line_item table from the relation

line_item (Item_Number, OrderID, Quantity)
  PK = Item_Number, OrderID

- line_item(Item_Number) must exist in item(Item_Number)
- line_item(OrderId) must exist in ordered(OrderID)

- Quantity should be capable of storing a whole number up to 255 only.
- If an OrderID in ordered is changed, then the change should be reflected here as well.
- If an ordered is deleted, then any line_item(s) associated with that order should
  also be deleted.
- If the Item_Number of an item is changed, the change should be reflected here as well.
--------------------------------------------------------------------------------- */
create table line_item(
  Item_Number int unsigned not null,
  OrderID int unsigned not null,
  Quantity tinyint unsigned,
  -- update of an item's Item_Number will update the line_item record
  constraint line_item_Item_Number_fk foreign key (Item_Number) references item(Item_Number)
    on update cascade,
  -- update of an ordered's OrderID will update the line_item record
  -- delete of an ordered will cause the line_item record to also delete
  constraint line_item_OrderID_fk foreign key (OrderID) references ordered(OrderID)
    on update cascade
    on delete cascade,
  constraint line_item_pk primary key (Item_Number, OrderID)
);

describe line_item;


/* ---------------------------------------------------------------------------------
Create the business table from the relation

business (CustomerID, PaymentTerms)
  PK = CustomerID

- business(CustomerID) must exist in customer(CustomerID)

- PaymentTerms should allow up to 50 characters to be stored. A value is required.
- When the CustomerID of a customer is changed, the change should be reflected
  here as well.
--------------------------------------------------------------------------------- */
create table business(
  CustomerID int unsigned,
  PaymentTerms varchar(50) not null,
  -- update of a customer's CustomerID will update the business record
  constraint business_CustomerID_fk foreign key (CustomerID) references customer(CustomerID)
    on update cascade,
  constraint business_pk primary key (CustomerID)
);

describe business;


/* ---------------------------------------------------------------------------------
Create the home table from the relation

home (CustomerID, CreditCardNum, CardExpirationDate)
  PK = CustomerID

- home(CustomerID) must exist in customer(CustomerID)

- CreditCardNum will store exactly 16 characters. A value is required.
- CardExpirationDate will store exactly 6 characters. A value is required.
- When the CustomerID of a customer is changed, the change should be reflected
  here as well.
--------------------------------------------------------------------------------- */
create table home(
  CustomerID int unsigned,
  CreditCardNum char(16) not null,
  CardExpirationDate char(6) not null,
  -- update of a customer's CustomerID will update the business record
  constraint home_CustomerID_fk foreign key (CustomerID) references customer(CustomerID)
    on update cascade,
  constraint home_pk primary key (CustomerID)
);

describe home;


/* ------------------------------------------------------------------------------------------+--------+
Add the following data to the item table                                                     |        |
  +-----------------------+-----------------------------------------------+------------------+--------+
  | Item_Name             | Description                                   | Model            | Price  |
  +-----------------------+-----------------------------------------------+------------------+--------+
  | Cabbage Patch Doll    | Baby boy doll                                 | Boy              |  39.95 |
  | The Last Lecture      |                                               | Hardcover        |   9.95 |
  | Keurig Beverage Maker | Keurig Platinum Edition Beverage Maker in Red | Platinum Edition | 299.95 |
  +-----------------------+-----------------------------------------------+------------------+--------+
--------------------------------------------------------------------------------- */
insert into item (Item_Name, Description, Model, Price) values ('Cabbage Patch Doll', 'Baby boy doll', 'Boy', 39.95);
insert into item (Item_Name, Model, Price) values ('The Last Lecture', 'Hardcover', 9.95);
insert into item (Item_Name, Description, Model, Price) values ('Keurig Beverage Maker', 'Keurig Platinum Edition Beverage Maker in Red', 'Platinum Edition', 299.95);

select * from item;


/* ---------------------------------------------------------------------------------
Modify the Address attribute in customer to allow up to 100 characters and a
value is not required.
--------------------------------------------------------------------------------- */
alter table customer modify Address varchar(100);

describe customer;


/* ---------------------------------------------------------------------------------
Add the following attributes to the existing customer table
  - City should allow up to 60 characters to be stored. A value is not required.
  - State should allow exactly two characters to be stored. A value is not required.
  - Zipcode should support the storage of zipcodes in the format of either '#####'
    or '#####-####'. Data validation of either format is not required; just that
    either format could be accomodated. A value is not required.
--------------------------------------------------------------------------------- */
alter table customer add City varchar(60) after Address;
alter table customer add State char(2) after City;
alter table customer add Zipcode varchar(10) after State;

describe customer;


/* ---------------------------------------------------------------------------------
Remove the 'Keurig Beverage Maker' from the item table
--------------------------------------------------------------------------------- */
delete from item where Item_Name = 'Keurig Beverage Maker';

select * from item;


/* ---------------------------------------------------------------------------------
Add a value for description of 'Written by Randy Pausch' for 'The Last Lecture'.
--------------------------------------------------------------------------------- */
update item set Description = 'Written by Randy Pausch' where Item_Name = 'The Last Lecture';

select * from item;


/* ---------------------------------------------------------------------------------
Add the following data for Janine Jeffers
  - Customer Name: Janine Jeffers
  - Street: 152 Lomb Memorial Dr.
  - City: Rochester
  - State: NY
  - Zipcode: 14623
  - Email: jxj1234@rit.edu
  - Credit Card Number: 1234567890123456
  - Card Expiration: 012014
  - Update Janine's customer record to denote that she is a 'home' customer
  - OrderID = 1
  - Order Total: 113.74
  - Line Item: Item Number = 1; OrderID = 1; Quantity = 2
  - Line Item: Item Number = 2; OrderID = 1; Quantity = 3
  
Make sure all of the statements are considered a single "unit," which will ensure
that either all of the statements execute or none of them execute.

Assume that this is a multi-user system with other records able to be added and
therefore when you execute the statements you do not know the CustomerID that
will be assigned to Janine.
--------------------------------------------------------------------------------- */
start transaction;

  insert into customer (CustomerName, Address, City, State, Zipcode, Email) values 
    ('Janine Jeffers', '152 Lomb Memorial Dr.', 'Rochester', 'NY', '14623', 'jxj1234@rit.edu');

  insert into home (CustomerID, CreditCardNum, CardExpirationDate)
    select CustomerID, '1234567890123456', '012014' from customer
    where CustomerName = 'Janine Jeffers';

  update customer set CustomerType = 'home' where CustomerName = 'Janine Jeffers';

  insert into ordered (CustomerID, OrderID, Total_Cost)
    select CustomerID, 1, 113.74 from customer where CustomerName = 'Janine Jeffers';

  insert into line_item values (1, 1, 2);
  insert into line_item values (2, 1, 3);

commit;

select * from customer;
select * from home;
select * from ordered;
select * from line_item;



