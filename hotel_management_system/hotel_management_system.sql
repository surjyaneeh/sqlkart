DROP DATABASE IF EXISTS hms;
CREATE DATABASE hms;
USE hms;

CREATE TABLE hotel( 
hid INT NOT NULL AUTO_INCREMENT, 
hname VARCHAR(30),
city VARCHAR(30),
PRIMARY KEY (hid)  
);

CREATE TABLE room(   
 rid INT NOT NULL AUTO_INCREMENT,  
 htlid INT NOT NULL ,  
 tariff INT NOT NULL,  
 PRIMARY KEY (rid, htlid),
 INDEX htlid_idx (htlid ASC) VISIBLE,
 CONSTRAINT hid     
 FOREIGN KEY (htlid)  REFERENCES hotel (hid) );

CREATE TABLE booking(
  bno INT NOT NULL AUTO_INCREMENT,
  hotel_id INT NOT NULL,
  rid INT NOT NULL,
  str_dt DATE NOT NULL,
  end_dt DATE NOT NULL,
  guest_nm VARCHAR(45) NOT NULL,
  PRIMARY KEY (bno, hotel_id, rid),
  INDEX hotel_id_idx (hotel_id ASC) VISIBLE,
  INDEX rid_idx (rid ASC) VISIBLE,
  CONSTRAINT hotel_id
    FOREIGN KEY (hotel_id) REFERENCES room (htlid),
  CONSTRAINT rid
    FOREIGN KEY (rid) REFERENCES room (rid) );
    
INSERT INTO hotel( hname, city) VALUES 
('HOTEL A', 'KOLKATA' ),
('HOTEL B', 'KOLKATA' ),('HOTEL C', 'KOLKATA' ),('HOTEL D', 'KOLKATA' ),('HOTEL E', 'KOLKATA' ),('HOTEL F', 'KOLKATA' ),
('HOTEL A', 'ASANSOL' ),('HOTEL A', 'HOWRAH' ),('HOTEL A', 'PURULIA' ),('HOTEL P', 'MALDAH' ),('HOTEL Q', 'MIDNAPORE' );

INSERT INTO room( htlid, tariff) VALUES
('1','5000'),('2','1000'),('3','4000'),('4','2000'),
('5','3000'),('6','3000'),('7','2000'),('8','1000'),
('9','2000'),('10','1000'),('11','1000');

INSERT INTO `hms`.`booking` (`hotel_id`, `rid`, `str_dt`, `end_dt`, `guest_nm`) VALUES 
('1', '1', '2022-01-05', '2022-01-31', 'abc'),
('1', '2', '2019-10-23', '2019-11-23', 'dfg'),
('2', '1', '2019-10-10', '2019-11-15', 'bcv'),
('2', '2', '2019-03-23', '2019-05-22', 'plm'),
('3', '1', '2018-12-20', '2019-01-25', 'abc'),('3', '2', '2019-07-14', '2019-07-24', 'abc'),
('4', '1', '2020-08-29', '2020-09-29', 'plm'),('4', '2', '2020-01-26', '2020-02-27', 'abc'),
('5', '1', '2021-01-26', '2021-03-26', 'bvn'), ('6', '1', '2021-04-16', '2021-06-26', 'dfg'),
('3', '2', '2021-01-09', '2021-03-19', 'abc');

-- the names of guests who have stayed in the same hotel at least thrice.
select guest_nm from booking group by guest_nm having count(guest_nm)>=3;
-- output 
-- guest_nm
-- abc


-- List the costliest rooms in each hotel.
SELECT htlid, Max(tariff) as Costliest_room
from room 
  group by htlid  ;
/*
# htlid	Costliest_room
1	5
2	1
3	4
4	2
5	3
6	3
7	2
8	1
9	2
10	1
11	1
*/

-- List the total earnings from bookings in the last month for each hotel in Kolkata.
SELECT sum(tariff) from hotel h join room r on h.hid=r.rid 
join booking b on r.rid=b.rid and h.hid=b.hotel_id 
where h.city= 'kolkata' and str_dt>'2022-01-01';
/*
sum(tariff)
5000
*/

-- Insert a new booking in the database.
insert into booking(guest_nm,hotel_id,rid,str_dt,end_dt) 
values('jklm',5,2,'2020-06-01','2020-08-02');

-- Change the start_date and end_date of the new booking.
update booking set str_dt='2020-01-05',end_dt='2020-01-24' where bno=4;

-- Delete the record for the rooms with no bookings in the last 6 months.
DELETE
FROM booking
WHERE str_dt not between '01-06-2021' and '01-01-2022';