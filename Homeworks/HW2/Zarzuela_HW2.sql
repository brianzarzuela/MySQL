-- File       : Zarzuela_HW2.sql
-- Author     : Brian Zarzuela
-- Date       : 27 January 2020
-- Desciption :
--    Creates the HW2 database and ITEM table

CREATE DATABASE HW2;
USE HW2;

/* Drop previous table if it already exists */
DROP TABLE item;

CREATE TABLE item(
itemID varchar(25),
itemname varchar(25),
name varchar(25),
street varchar(25),
city varchar(25),
color1 varchar(25),
color2 varchar(25),
color3 varchar(25),
state char(2),
zipcode varchar(10),
cost varchar(10),
retail_price varchar(10),
notes varchar(255),
description varchar(255),
returnable char(1),
perishable char(1),
shelf_qty int,
CONSTRAINT item_pk PRIMARY KEY(itemID)
);