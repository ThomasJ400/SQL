CREATE DATABASE bank;
USE bank;
/* Table Build */
/* BEGIN */
DROP TABLE IF EXISTS account; /* Drop Children First */
DROP TABLE IF EXISTS customer; /* Drop Parent Last */

CREATE TABLE customer(
  CustomerID int(20) unsigned,
  Cfirstname varchar(254),
  Csurname varchar(254),
  StAddr varchar(254) NOT NULL,
  City varchar(254) DEFAULT "Smithville",
  State char(2) DEFAULT "KY",
  Zip varchar(20) NOT NULL,
  PRIMARY KEY (CustomerID)
);

CREATE TABLE account (
  AccountNum int(20),
  AccountType varchar(40) NOT NULL,
  DateOpened date NOT NULL,
  Balance decimal(7,2) NOT NULL,
  CustomerId int(20) unsigned ,
  PRIMARY KEY (AccountNum),
  FOREIGN KEY (CustomerId) REFERENCES customer (CustomerID)  /* ON DELETE SET NULL  ON DELETE CASCADE */
);

INSERT INTO customer VALUES 
(1001, "Joseph", "Smith", "Cherry Park", DEFAULT, DEFAULT, "91232"),
(1002, "Alberto", "Jones", "123 Lexington", DEFAULT, DEFAULT, "91232"),
(1003, "Nathanial", "Axe", "443 Grinder Ln", "Broadville", "GA", "81992"),
(1004, "Paulina", "Builder", "661Parker Rd", "Streetville", "GA", "81992"),
(1005, "Jim", "Ryan", "123 Cherry Park", NULL, NULL, "9123"),
(1006, "Ann", "Ryan", "123 Blosson Park", DEFAULT, "KY", "81992");

INSERT INTO account VALUES 
(1122, "Checking", "1998-11-13", 800, 1004),
(3322, "Saving", "1994-08-13", 800, 1004),
(4422, "Checking", "1998-12-01", 800, 1003),
(8811, "Saving", "1998-10-01", 800, 1002),
(9980, "Saving", "1989-05-01", 800, 1001);
/* END */

/* ALTER COMMAND */
/* BEGIN */

DELETE FROM customer WHERE CustomerID = 1004; /* Remove for doing rebuilds of the tables later on for later question: Update Q2 */

SELECT * FROM customer; SELECT * FROM account;

ALTER TABLE customer
ADD COLUMN pps VARCHAR(254);

SELECT * FROM customer;

ALTER TABLE customer
ADD CONSTRAINT ppsUN UNIQUE(pps);

ALTER TABLE customer
ADD COLUMN email VARCHAR(254) AFTER Csurname;

ALTER TABLE customer
MODIFY COLUMN Cfirstname VARCHAR(120);

ALTER TABLE customer
MODIFY COLUMN Csurname VARCHAR(120);

SELECT * FROM customer; DESCRIBE customer;

ALTER TABLE customer
DROP COLUMN pps;

SELECT * FROM customer; SELECT * FROM account;
/* END */
/* Rebuild with deletion of Paulina commented out */
 
/* The Update Command */
/* BEGIN */

UPDATE customer
SET StAddr = "45 Hazel Park" WHERE CustomerID = 1001;

UPDATE customer
SET Csurname = "Ryan" WHERE CustomerID = 1004;

UPDATE account
SET balance = balance + 200;

UPDATE account
SET balance = balance * 2 WHERE AccountType = "Saving" AND DateOpened < "1994-01-01";

SELECT * FROM customer; SELECT * FROM account;
/* END */

/* The Delete Command */
/* BEGIN */

DELETE FROM account
WHERE AccountNum = 9980;

DELETE FROM customer
WHERE CustomerID = 1004;

/* cannot delete a parent row. While data exists in a child of the table the row cannot be deleted unless using ON DELETE CASCADE */
/* See Alter Command PPS column already dropped */

SELECT * FROM customer; SELECT * FROM account;

/* END */




