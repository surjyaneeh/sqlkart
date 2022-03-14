DROP DATABASE IF EXISTS sms;
CREATE DATABASE sms;
USE sms;
CREATE TABLE `sms`.`customers` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `ph_no` INT NOT NULL,
  PRIMARY KEY (`cid`));

CREATE TABLE `sms`.`items` (
  `ino` INT NOT NULL AUTO_INCREMENT,
  `iname` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `itype` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ino`));

CREATE TABLE `sms`.`orders` (
  `order_no` INT NOT NULL AUTO_INCREMENT,
  `ino` INT NOT NULL,
  `cid` INT NOT NULL,
  `ord_date` DATE NOT NULL,
  `qty` INT NOT NULL,
  PRIMARY KEY (`order_no`),
  INDEX `cid_idx` (`cid` ASC) VISIBLE,
  INDEX `ino_idx` (`ino` ASC) VISIBLE,
  CONSTRAINT `cid`
    FOREIGN KEY (`cid`)
    REFERENCES `sms`.`customers` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ino`
    FOREIGN KEY (`ino`)
    REFERENCES `sms`.`items` (`ino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO customers(cname, city, ph_no) VALUES 
('neha','kolkata', 543210), ('shreya','kolkata', 543120),('sayani','kolkata', 542310),
('anita','kolkata', 453210),('swarup','asansol', 643210),
('surjyanee','asansol', 986754),('koushanee','asansol', 978650),('nidhi','asansol', 893210);

INSERT INTO items(iname, price, itype) VALUES 
('mobile phone', 15000, 'electronics'), ('salt', 50, 'groceries'),('toothpaste', 50 ,'stationary'),
('ear phone', 1500, 'electronics'), ('flour', 25, 'groceries'),('body lotion', 250 ,'stationary'),
('head phone', 3500, 'electronics'), ('dal', 100, 'groceries'),('writing pads', 150 ,'stationary'),
('tv', 45000, 'electronics'), ('oil', 200, 'groceries'),('notebook', 100 ,'stationary');

INSERT INTO orders(ino, cid, ord_date, qty) VALUES 
(1,1,'2019-10-30',1), (2,2,'2019-03-10',2), (3,1,'2020-10-03',4), 
(4,1,'2020-04-29',2), (5,3,'2019-03-30',1), (6,3,'2019-06-30',3), 
(1,4,'2021-07-10',1), (7,5,'2018-10-11',1), (8,4,'2019-01-25',2), 
(8,5,'2021-10-20',1), (9,6,'2022-01-17',7), (10,8,'2021-01-13',1), 
(10,6,'2020-10-09',2), (11,7,'2022-01-19',1), (12,8,'2021-05-14',5)
;

/* For each item type, display the item with the lowest price. */
SELECT min(price) as price,iname  FROM items group by itype;
/* 
price	iname
1500	mobile phone
25	    salt
50	    toothpaste
*/


/* Display the name of the customer who has ordered the highest-priced item. */
SELECT c.cname,i.price from customers c 
join orders o on c.cid=o.cid 
join items i on o.ino=i.ino  
where price=(select max(i.price) from customers c 
join orders o on c.cid=o.cid join items i on o.ino=i.ino) ;
/* 
cname	  price
nidhi	   45000
surjyanee	45000
*/


/* Display the names of the customers who have ordered the item “mobile phone”. */
select cname from customers where cid in
(select cid from orders where ino in(select ino from items where iname='mobile phone'));
/* 
cname
neha
anita
*/


/*2 d */
SELECT * FROM customers where cid not in                 
				(select cid from orders where ord_date between'2021-06-20'and '2022-01-02' 
                  group by cid having count(*)>2);
/*
cid	cname	city	ph_no
1	neha	kolkata	543210
2	shreya	kolkata	543120
3	sayani	kolkata	542310
4	anita	kolkata	453210
5	swarup	asansol	643210
6	surjyanee	asansol	986754
7	koushanee	asansol	978650
8	nidhi	asansol	893210
*/


/*2 e */
select c.city,count(o.order_no)s   from customers c 
LEFt join orders o on c.cid=o.cid  
LEFT join items i on i.ino=o.ino 
group by c.city order by s desc;
/*
city	s
kolkata	8
asansol	7
 */


/*2 f */
select c.city,count(c.city) s from customers c  
join orders o on c.cid=o.cid  
join items i on i.ino=o.ino where i.itype='electronics' 
group by c.city order by s desc Limit 1;
/*
city	s
kolkata	3
*/
