DROP DATABASE IF EXISTS PE14;
CREATE DATABASE PE14;
USE PE14;

DROP TABLE IF EXISTS item;
CREATE TABLE item (
  ItemID int(11) NOT NULL,
  Type char(10) default NULL,
  Manufacturer char(20) default NULL,
  Model char(20) default NULL,
  LeaseRate double default NULL,
  PRIMARY KEY  (ItemID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO item VALUES (1,'Computer','Bell','OfficePro',89),(2,'Computer','Bell','OfficePro',99),(3,'Computer','Bell','OfficePro',119),(4,'Computer','Bell','OfficePro',149),(5,'Truck','Industrial','Box Van',400),(6,'Truck','Industrial','Box Van (Long)',450),(7,'Truck','Industrial','Flat Bed',800),(8,'Truck','Industrial','Semi',1200),(9,'Furniture','Brookstone','Efficency1',20),(10,'Furniture','Brookstone','Efficency2',25),(11,'Furniture','Brookstone','EfficencyPlus',30),(12,'Furniture','Brookstone','Executive',50),(13,'Furniture','Brookstone','ExecutivePlus',60);

DROP TABLE IF EXISTS computer;
CREATE TABLE computer (
  ItemID int(11) NOT NULL,
  SerialNumber char(20) NOT NULL,
  ProcessorSpeed int(11) NOT NULL,
  Memory char(10) NOT NULL,
  Dimensions char(10) NOT NULL,
  HardDriveSpace char(10) NOT NULL,
  CDRomSpeed char(10) NOT NULL,
  PRIMARY KEY  (ItemID),
  CONSTRAINT FK_Computer_Item FOREIGN KEY (ItemID) REFERENCES item (ItemID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO computer VALUES (1,'abc123',800,'128meg','24x18x6','10gigs','48'),(2,'abc124',800,'128meg','24x18x6','10gigs','48'),(3,'abc234',800,'256meg','24x18x6','20gigs','52'),(4,'abc235',800,'512meg','24x18x6','30gigs','52');

DROP TABLE IF EXISTS furniture;
CREATE TABLE furniture (
  ItemID int(11) NOT NULL,
  Dimensions char(20) NOT NULL,
  Weight int(11) NOT NULL,
  Color char(20) NOT NULL,
  PRIMARY KEY  (ItemID),
  CONSTRAINT FK_Furniture_Item FOREIGN KEY (ItemID) REFERENCES item (ItemID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO furniture VALUES (9,'5x3x3',40,'Brown'),(10,'5x3x3',45,'Brown'),(11,'5x3x3',45,'Black'),(12,'6x4x3',60,'Cherry'),(13,'6x4x3',70,'Cherry');

DROP TABLE IF EXISTS truck;
CREATE TABLE truck (
  ItemID int(11) NOT NULL,
  VinNumber char(20) NOT NULL,
  Color char(20) NOT NULL,
  MilesPerGallon tinyint(4) NOT NULL,
  TransmissionType char(10) NOT NULL,
  TowingCapacity int(11) NOT NULL,
  NumberOfAxles tinyint(4) NOT NULL,
  PRIMARY KEY  (ItemID),
  CONSTRAINT FK_Vehicle_Item FOREIGN KEY (ItemID) REFERENCES item (ItemID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO truck VALUES (5,'12345','White',15,'Auto',6000,2),(6,'12346','White',13,'Auto',8000,2),(7,'12347','Black',10,'Manual',14000,3),(8,'12348','Black',8,'Manual',20000,4);


DROP TABLE IF EXISTS lease;
CREATE TABLE lease (
  LeaseNumber int(11) NOT NULL,
  ActiveDate datetime NOT NULL,
  CustomerID int(11) NOT NULL,
  Term char(20) NOT NULL,
  Salesperson char(20) NOT NULL,
  Notes text,
  PRIMARY KEY  (LeaseNumber)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO lease VALUES (1,'2001-01-01 00:00:00',1,'24 Months','John Smith','Customer always pays on time, follow up call often.');

DROP TABLE IF EXISTS lease_item;
CREATE TABLE lease_item (
  LeaseNumber int(11) NOT NULL,
  ItemID int(11) NOT NULL,
  Quantity int(11) NOT NULL,
  PRIMARY KEY  (LeaseNumber,ItemID),
  KEY FK_Lease_Items_Items (ItemID),
  CONSTRAINT FK_Lease_Item_Items FOREIGN KEY (ItemID) REFERENCES item (ItemID),
  CONSTRAINT FK_Lease_Item_Leases FOREIGN KEY (LeaseNumber) REFERENCES lease (LeaseNumber)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO lease_item VALUES (1,1,20),(1,2,20),(1,3,20),(1,4,10),(1,5,4),(1,6,2),(1,7,1),(1,8,1),(1,9,3),(1,10,10),(1,11,5),(1,12,2),(1,13,2);


