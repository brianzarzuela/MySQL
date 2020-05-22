-- File       : Zarzuela_HW2.sql
-- Author     : Brian Zarzuela
-- Date       : 3 February 2020
-- Desciption :
--    Creates and populats the members and
--    committees table from mysql tutorial

CREATE TABLE members (
  member_id INT AUTO_INCREMENT,
  name VARCHAR(1000),
  PRIMARY KEY (member_id)
);

CREATE TABLE committees (
  committee_id INT AUTO_INCREMENT,
  name VARCHAR(100),
  PRIMARY KEY (committee_id)
);

INSERT INTO members(name)
VALUES ('John'), ('Jane'), ('Mary'), ('David'), ('Amelia');

INSERT INTO committees(name)
VALUES ('John'), ('Mary'), ('Amelia'), ('Joe');