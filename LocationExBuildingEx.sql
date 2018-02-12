/*
Author: Thomas Jones
Title: Location Exercise
Date: 01/02/2018
*/

CREATE DATABASE location;
USE location;

/*Q 1*/
/* START */
CREATE TABLE area
(
	LOCATION_ID DECIMAL(4,0),
	STREET_ADDRESS VARCHAR(40),
	POSTAL_CODE VARCHAR(12),
	CITY VARCHAR(30),
	STATE_PROVINCE VARCHAR(25),
	COUNTRY_ID VARCHAR(2)
);
/* END */

/* Q2 */
/* START */
RENAME TABLE area TO locations;
/* END */

/*Q 3,5*/
/* START */
ALTER TABLE locations
ADD COLUMN REGION_ID VARCHAR(2) AFTER STATE_PROVINCE;
/* END */

/*Q 4*/
/* START */
ALTER TABLE locations
ADD COLUMN ID VARCHAR(2) FIRST;
/* END */

/*Q 6*/
/* START */
ALTER TABLE locations
CHANGE COUNTRY_ID COUNTRY_ID INT(25);
/* END */

/*Q 7*/
/* START */
ALTER TABLE locations
DROP COLUMN CITY;
/* END */

/*Q 8*/
/* START */
ALTER TABLE locations
CHANGE STATE_PROVINCE STATE VARCHAR(25);
/* END */

/*Q 9, 10*/
/* START */
ALTER TABLE locations
ADD PRIMARY KEY(LOCATION_ID,COUNTRY_ID);
/* END */

/*Q 11*/
/* START */
ALTER TABLE locations
DROP PRIMARY KEY;
/* END */

/*
Author: Thomas Jones
Title: Building Exercise
Date: 01/02/2018
*/

CREATE DATABASE building;
USE building;

/*Q 1, 3*/
/* START */
CREATE TABLE buildings
(
	building_no INT(11) PRIMARY KEY,
	building_name VARCHAR(255),
	address VARCHAR(355)
);

CREATE TABLE rooms
(
	room_no INT(11) PRIMARY KEY,
	room_name VARCHAR(255),
	building_no INT(11),
	FOREIGN KEY(building_no) REFERENCES buildings(building_no)
);
/* END */

/* Q2 */
/* START */
INSERT INTO buildings VALUES
(1, "ACME Headquarter","3950 North 1st Street CA 95134"),
(2, "ACME Sales","5000 North 1st Street CA 95134");

INSERT INTO rooms VALUES
(1,"Amazon",1),
(2,"War Room",1),
(3,"Office of CEO",1),
(4,"Marketing",2),
(5,"Showroom",2);
/* END */

/*Q 4,5,6*/
/* START */
DELETE FROM buildings WHERE building_no = 1;
/* Yes; Cannot delete or update a parent row. As rooms has the foreign key attached.*/
/* END */

/*Q 7,8*/
/* START */
DROP TABLE IF EXISTS rooms;

CREATE TABLE rooms
(
	room_no INT(11) PRIMARY KEY,
	room_name VARCHAR(255),
	building_no INT(11),
	FOREIGN KEY(building_no) REFERENCES buildings(building_no) ON DELETE CASCADE
);
/* END */

/*Q 9*/
/* START */
INSERT INTO rooms VALUES
(1,"Amazon",1),
(2,"War Room",1),
(3,"Office of CEO",1),
(4,"Marketing",2),
(5,"Showroom",2);
/* END */

/*END OF EXERCISE*/

/*Q 10,11*/
/* START */
DELETE FROM buildings WHERE building_no = 1;
/* Yes, it worked */
/* END */

/*Q 12,13*/
/* START */
SELECT * FROM buildings; SELECT * FROM rooms;
/* Yes, The rooms were deleted. */
/* END */

/*Q 14*/
/* START */
DROP TABLE IF EXISTS rooms;

CREATE TABLE rooms
(
	room_no INT(11) PRIMARY KEY,
	room_name VARCHAR(255),
	building_no INT(11),
	FOREIGN KEY(building_no) REFERENCES buildings(building_no) ON DELETE SET NULL
);

INSERT INTO rooms VALUES
(1,"Amazon",1),
(2,"War Room",1),
(3,"Office of CEO",1),
(4,"Marketing",2),
(5,"Showroom",2);

INSERT INTO buildings VALUES
(1, "ACME Headquarter","3950 North 1st Street CA 95134");

DELETE FROM buildings WHERE building_no = 1;
/* Yes, it worked */

SELECT * FROM buildings; SELECT * FROM rooms;
/* Yes, The rooms were set to null in the rooms table. */
/* END */
/* END OF EXERCISE */