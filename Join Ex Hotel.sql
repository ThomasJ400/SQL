/* Author: Thomas Jones */		/* Date: 25-02-2018 */
/* Aggregate functions on Music Database */
/* START OF EXERCISE SHEET */

USE music;

/* QUESTION 1 */
/* START */
SELECT COUNT(*) FROM artist;
/* END */

/* QUESTION 2 */
/* START */
SELECT COUNT(*) FROM album;
/* END */

/* QUESTION 3 */
/* START */
SELECT 
	AVG(time),
	MIN(time),
	MAX(time) 
FROM track;
/* END */

/* QUESTION 4 */
/* START */
SELECT track_id FROM track
WHERE played = 
	(SELECT MAX(played) FROM track);
/* END */

/* QUESTION 5 */
/* START */
SELECT track_id 
FROM track
WHERE played = 
	(SELECT MIN(played) FROM track);
/* END */

/* QUESTION 6 */
/* START */
SELECT 
	SUM(time) AS "Total Length", 
	MIN(time) AS "Shortest Length", 
	AVG(time) AS "Average Length", 
	MAX(time) AS "Longest Length" 
FROM track
WHERE artist_id = 5
AND album_id = 1;
/* END */
/* END OF EXERCISE SHEET */


/* Author: Thomas Jones */		/* Date: 25-02-2018 */
/* Join Exercise Hotel Database */
/* START OF SHEET

hotel 	{hotelno(p),hotelname,city}
guest	{guestno(p),guestname,guestaddress}
room		{roomno(p),hotelno(p)*,type,price}
booking	{hotelno(p)*,guestno(p)*,datefrom(p),dateto,roomno*}

*/
/* QUESTION 1 */
/* START */
SELECT room.roomno, room.hotelno, hotel.city 
FROM room
JOIN hotel
ON room.hotelno = hotel.hotelno
WHERE hotel.city LIKE "London";
/* END */
/* QUESTION 2 */
/* START */
SELECT DISTINCT room.type, room.price, hotel.hotelname 
FROM room
JOIN hotel
ON room.hotelno = hotel.hotelno
WHERE hotel.hotelname LIKE "Grosvenor";
/* END */
/* QUESTION 3 */
/* START */
SELECT booking.guestno, guest.guestname, hotel.hotelname
FROM booking
JOIN guest
ON booking.guestno = guest.guestno
JOIN hotel
ON booking.hotelno = hotel.hotelno
WHERE hotel.hotelname LIKE "Watergate";
/* END */
/* QUESTION 4 */
/* START */
SELECT booking.guestno, guest.guestname, hotel.hotelname, booking.datefrom, booking.dateto
FROM booking
JOIN guest
ON booking.guestno = guest.guestno
JOIN hotel
ON booking.hotelno = hotel.hotelno;
/* END */
/* QUESTION 5 */
/* START */
SELECT room.type, room.price, hotel.hotelname 
FROM room
JOIN hotel
ON room.hotelno = hotel.hotelno;
/* END */
/* QUESTION 6 */
/*With a simple select* statement to determine the actual result....
+---------+---------+------------+------------+--------+
| hotelno | guestno | datefrom   | dateto     | roomno |
+---------+---------+------------+------------+--------+
| ch01    |   10006 | 2004-04-21 | NULL       |   1101 |
| ch02    |   10002 | 2004-04-25 | 2004-05-06 |    801 |
| dc01    |   10003 | 2004-05-20 | NULL       |   1001 |
| dc01    |   10007 | 2004-05-13 | 2004-05-15 |   1001 |
| fb01    |   10001 | 2004-04-01 | 2004-04-08 |    501 |
| fb01    |   10001 | 2004-05-01 | NULL       |    701 |
| fb01    |   10002 | 2016-05-04 | 2004-05-29 |    601 | *
| fb01    |   10004 | 2004-04-15 | 2004-05-15 |    601 |
| fb01    |   10005 | 2004-05-02 | 2004-05-07 |    501 |
| fb02    |   10003 | 2004-04-05 | 2010-04-04 |   1001 |
| fb02    |   10005 | 2004-05-12 | 2030-05-04 |   1001 | **
+---------+---------+------------+------------+--------+
* This is incorrect input into the database as the datefrom, is greater than the dateto.
** This is the only current booking altogether, and fb02 is Watergate, fb01 is Grosvenor.
As the business rules aren't defined, I'll assume that when DATETO is NULL it means that the occupant is also still there, otherwise it would be a NULL set.
*/
/* START */
SELECT booking.guestno, guest.guestname, hotel.hotelname, booking.datefrom, booking.dateto
FROM booking
JOIN guest
ON booking.guestno = guest.guestno
JOIN hotel
ON booking.hotelno = hotel.hotelno
WHERE hotel.hotelname LIKE "Grosvenor"
AND (booking.dateto > NOW()
OR booking.dateto IS NULL);
/* END */
/* QUESTION 7 */
/* START */
SELECT room.type, room.price, hotel.hotelname 
FROM room
JOIN hotel
ON room.hotelno = hotel.hotelno
WHERE room.type IN("double","family") 
AND room.price < 40
ORDER BY price;  
/* END */

/* END OF EXERCISE SHEET */