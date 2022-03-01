DROP DATABASE IF EXISTS `bms`;
CREATE DATABASE `bms`;
USE bms;
CREATE TABLE `bms`.`customer` (
  `cust_id` INT NOT NULL AUTO_INCREMENT,
  `cname` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `cust_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cust_id`));

CREATE TABLE `bms`.`bank` (
  `bank_id` INT NOT NULL AUTO_INCREMENT,
  `bname` VARCHAR(45) NOT NULL,
  `bcity` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bank_id`));

CREATE TABLE `bms`.`borrows` (
  `br_id` INT NOT NULL AUTO_INCREMENT,
  `cust_id` INT NOT NULL,
  `bank_id` INT NOT NULL,
  `amount` INT NOT NULL,
  `b_date` DATE NOT NULL,
  `duration` INT NOT NULL,
  `b_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`br_id`, `cust_id`, `bank_id`),
  INDEX `cust_id_idx` (`cust_id` ASC) VISIBLE,
  INDEX `bank_id_idx` (`bank_id` ASC) VISIBLE,
  CONSTRAINT `cust_id`
    FOREIGN KEY (`cust_id`)
    REFERENCES `bms`.`customer` (`cust_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bank_id`
    FOREIGN KEY (`bank_id`)
    REFERENCES `bms`.`bank` (`bank_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO bms.customer (cname, age, cust_type) VALUES
    ('Thomas', '20', 'Corporate'),('Stoneman', '23', 'Regular'),('Wyatt', '35', 'Priority '),('Kimbra', '39', 'Priority '),('Domingo', '45', 'Priority '),
    ('Cortes', '45', 'Corporate '),('Colt', '40', 'Regular'),('Pinkie', '45', 'Priority '),('Marlon', '60', 'Regular'),('Crafford', '65', 'Corporate');
    
INSERT INTO bms.bank (bname, bcity) VALUES
    ('central bank', 'KOLKATA'),('BANK B', 'KOLKATA'),('Indian bank', 'PURULIA'),
    ('BANK D', 'ASANSOL'),('BANK E', 'PURULIA'),('Indian bank', 'KOLKATA'),
    ('central bank', 'ASANSOL'),('BANK I', 'PURULIA'),('BANK J', 'KOLKATA'),('central bank', 'HOWRAH');

INSERT INTO bms.borrows (cust_id, bank_id,amount,b_date, duration, b_type) VALUES 
(1,1,150000,'2018-03-12', 10, 'Car'), (2,1,178000,'2018-09-12', 10, 'Home'), (1,2,100000,'2020-03-10', 10, 'Car'),(2,3,100000,'2018-03-12', 15, 'Car'),
(3,3,105030,'2019-03-12', 10, 'Car'), (4,4,100000,'2008-03-12', 15, 'Home'),(3,5,189000,'2018-03-07', 50, 'Home'),(4,6,100000,'2018-03-12', 15, 'Car'),
(5,7,106700,'2019-06-12', 30, 'Home'),(6,8,80000,'2021-03-12', 19, 'Car'),(7,8,100000,'2018-03-12', 10, 'Personal'),(8,9,100000,'2016-03-10', 25, 'Personal'),
(8,10,109000,'2018-09-12', 15, 'Car'),(10,10,100000,'2018-03-05', 9, 'Personal');

/* List the details of the customers who have borrowed more than rupees 10 lakhs from
the Central Bank in Kolkata. */ 
 SELECT * FROM customer   where cust_id in(
                                          select cust_id from borrows where amount>100000 and br_id in
    (select bank_id from bank where bname='central bank' and bcity='Kolkata'));
/* Output
cust_id	cname	age	cust_type
1	   Thomas	20	Corporate
 */

/* List the names and ages of customers who have borrowed from the Indian Bank on
12/03/18 for a duration of 15 years or more. */ 
 select * from customer WHERE cust_id in
              (select cust_id from borrows where duration=15 and b_date='2018-03-12' and bank_id in
			 (select bank_id from bank where bname='Indian bank'));
/* output
cust_id, cname, age, cust_type
2	  Stoneman	23	Regular
4	   Kimbra	39	Priority 
*/

/* List the names of all corporate customers who have not taken any car loan. */ 
 SELECT c.cname
 from customer c 
 join borrows b on c.cust_id=b.cust_id 
 where b.b_type<>'Car' and c.cust_type='Corporate';
 /* output
cname
Crafford
 */

/* List the details of the customer who has the third-highest borrowed amount. */ 
SELECT c.cust_id,c.cname,c.age,c.cust_type 
 FROM customer c join borrows b on c.cust_id=b.cust_id
 order by b.amount desc limit 1 offset 2;
/* output
cust_id	cname	age	cust_type
1	  Thomas	20	Corporate
*/

/* List the total loan amount (for all customers) for the different banks located in
Kolkata. */ 
SELECT sum(amount) as bor_sum_kol FROM borrows br
JOIN bank b
on br.bank_id = b.bank_id
WHERE b.bcity = 'Kolkata' ;
/* output
bor_sum_kol
628000
*/

/* List the loan details of the youngest customer. */ 
 SELECT * FROM borrows
 where cust_id in
                (select cust_id from customer
                 where age <=all(select age from customer ));
/* output
br_id	cust_id	bank_id	amount	b_date	duration	b_type
1	    1	    1	  150000	2018-03-12	10	    Car
3	    1	    2	  100000	2020-03-10	10	    Car
*/
                 
/* List the names of all customers who are in their 60s. */ 
 SELECT cname FROM customer where age  between 60 and 70;
/*output
	cname
	Marlon
	Crafford
*/
