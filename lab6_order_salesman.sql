CREATE DATABASE OrderDB;
USE OrderDB;
CREATE TABLE salesman(
  salesman_id INT,
  sname VARCHAR(15), 
  city VARCHAR(15),
  commission INT,
  primary key(salesman_id));

 CREATE TABLE customer (
   Customer_id INT,
   Cust_Name VARCHAR(15),
   City VARCHAR(15),
   Grade INT,
   Salesman_id INT,
   primary key(Customer_id),
   foreign key (Salesman_id) references salesman(Salesman_id));

create table ORDERS (Ord_No int,
                     Purchase_Amt INT,
                     Ord_Date VARCHAR(15), 
                     Customer_id INT, 
                     Salesman_id INT,
                     primary key(Ord_No),
                     foreign key (Salesman_id) references salesman(Salesman_id),
                     foreign key (Customer_id) references customer(Customer_id));

INSERT INTO salesman VALUES (1000, 'JOHN','BANGALORE',25); 
INSERT INTO salesman VALUES (2000,'RAVI','BANGALORE',20); 
INSERT INTO salesman VALUES (3000, 'KUMAR','MYSORE',15); 
INSERT INTO salesman VALUES (4000, 'SMITH','DELHI',30); 
INSERT INTO salesman VALUES (5000, 'HARSHA','HYDRABAD',15); 
INSERT INTO customer VALUES (10, 'PREETHI','BANGALORE', 100, 1000); 
INSERT INTO customer VALUES (11, 'VIVE','MANGALORE', 300, 1000); 
INSERT INTO customer VALUES (12, 'BHASKAR','CHENNAI', 400, 2000); 
INSERT INTO customer VALUES (13, 'CHETHAN','BANGALORE', 200, 2000); 
INSERT INTO customer VALUES (14, 'MAMATHA','BANGALORE', 400, 3000);
INSERT INTO ORDERS VALUES (50, 5000, '04-MAY-17', 10, 1000); 
INSERT INTO ORDERS VALUES (51, 450, '20-JAN-17', 10, 2000);
INSERT INTO ORDERS VALUES (52, 1000, '24-FEB-17', 13, 2000); 
INSERT INTO ORDERS VALUES (53, 3500, '13-APR-17', 14, 3000); 
INSERT INTO ORDERS VALUES (54, 550, '09-MAR-17', 12, 2000);

/*1. Count the customers with grades above Bangalore’s average. */
SELECT Count(*) 
from CUSTOMER
where Grade>(SELECT avg(Grade)
			from CUSTOMER
			where City='BANGALORE');
            
/*2. Find the name and numbers of all salesmen who had more than one customer. */
SELECT salesman_id,sname
from salesman
where salesman_id=(SELECT Salesman_id
					from CUSTOMER
                    where CUSTOMER.Salesman_id=salesman.salesman_id
                    group by CUSTOMER.Salesman_id
                    having count(*)>1);
                    
/* 2. Find the name and numbers of all salesmen who had more than one customer.  */
SELECT salesman_id, sname
from salesman A 
where 1 < (SELECT count(*) 
from CUSTOMER 
where Salesman_id=A.salesman_id);


/*4. Create a view that finds the salesman who has the customer with the highest order of a day. */
create view BestSalesman AS
SELECT B.Ord_Date, A.salesman_id, A.sname 
from salesman A, ORDERS B
where A.salesman_id = B.Salesman_id 
AND B.Purchase_Amt=(SELECT MAX(Purchase_Amt) 
from ORDERS C 
WHERE C.Ord_Date = B.Ord_Date);

SELECT * from BestSalesman;

/*5. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted. */

ALTER TABLE ORDERS
  ADD CONSTRAINT Salesman_id
  FOREIGN KEY (Salesman_id) 
  REFERENCES salesman(salesman_id) 
  ON DELETE CASCADE;
  
ALTER TABLE CUSTOMER 
  ADD CONSTRAINT Salesman_idCust
  FOREIGN KEY (Salesman_id) 
  REFERENCES salesman(salesman_id) 
  ON DELETE SET NULL;
  
delete from salesman 
where salesman_id=1000;
