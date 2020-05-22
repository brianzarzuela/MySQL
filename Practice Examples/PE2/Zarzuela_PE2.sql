-- File       : Zarzuela_PE2.sql
-- Author     : Brian Zarzuela
-- Date       : 27 January 2020
-- Desciption :
--    Creates the PE2 database and BOOK table

CREATE DATABASE PE2;
USE PE2;

/* Drop previous table if it already exists */
DROP TABLE book;
CREATE TABLE book(
title varchar(50),
isbn13number char(13),
author1 varchar(50),
author2 varchar(50),
author3 varchar(50),
author4 varchar(50),
author5 varchar(50),
number_of_pages int,
release_data date,
CONSTRAINT book_pk PRIMARY KEY(isbn13number)
);