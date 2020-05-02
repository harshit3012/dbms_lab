create database Airline;
use Airline;
create table flights(
flno int,
ffrom varchar(15),
fto varchar(15),
distance int,
departs timestamp default '2005-05-13 17:15:31',
arrives timestamp default '2005-05-13 17:15:31',
price int,
primary key (flno));
create table aircraft(
aid int,
aname varchar(15),
cruisingrange int,
primary key (aid));

create table employees(
eid int,
ename varchar(15),
salary int,
primary key (eid));

create table certified(
eid int,
aid int,
primary key (eid,aid),
foreign key(eid) references employees(eid),
foreign key(aid) references aircraft(aid));

insert into flights values(101,'Bangalore','Delhi',2500,'2005-05-13 07:15:31','2005-05-13 17:15:31',5000),(102,'Bangalore','Lucknow',3000,'2005-05-13 07:15:31','2005-05-13 11:15:31',6000),(103,'Lucknow','Delhi',500,'2005-05-13 12:15:31',' 2005-05-13 17:15:31',3000),
(107,'Bangalore','Frankfurt',8000,'2005-05-13 07:15:31','2005-05-13 22:15:31',60000),(104,'Bangalore','Frankfurt',8500,'2005-05-13 07:15:31','2005-05-13 23:15:31',75000),(105,'Kolkata','Delhi',3400,'2005-05-13 07:15:31','2005-05-13 09:15:31',7000);

select * from flights;

insert into aircraft values(101,'747',3000),(102,'Boeing',900),(103,'647',800),(104,'Dreamliner',10000),(105,'Boeing',3500),(106,'707',1500),(107,'Dream', 120000);

insert into employees values(701,'A',50000),(702,'B',100000),(703,'C',150000),(704,'D',90000),(705,'E',40000),(706,'F',60000),(707,'G',90000);

insert into certified values(701,101),(701,102),(701,106),(701,105),(702,104),(703,104),(704,104),(702,107),(703,107),(704,107),(702,101),(703,105),(704,105),(705,103);

select * from certified;
select * from employees;

/* i.	Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000. */
select distinct aname 
from aircraft a,employees e,certified c
where a.aid=c.aid and e.eid=c.eid and e.salary>80000;

/* ii.	For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruisingrange of the aircraft for which she or he is certified.*/
select c.eid, max(a.cruisingrange)
from certified c, aircraft a
where c.aid=a.aid
group by c.eid
having count(*)>3;

/* iii.	Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to Frankfurt.*/
select ename
from employees
where salary<(select min(price)
				from flights
                where ffrom='Bangalore' and fto='Frankfurt');
                
/* iv.	For all aircraft with cruisingrange over 1000 Kms, find the name of the aircraft and the average salary of all pilots certified for this aircraft.*/
select a.aname, avg(e.salary)
from aircraft a, employees e, certified c
where a.aid=c.aid and a.cruisingrange>1000 and e.eid=c.eid
group by a.aname;
                                                        
/*v. Find the names of pilots certified for some Boeing aircraft.*/
select distinct e.ename
from employees e,certified c, aircraft a
where a.aid=c.aid and e.eid=c.eid and a.aname='Boeing';

/* vi.	Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi.*/
select a.aid
from aircraft a
where a.cruisingrange >( select min(f.distance)
						from flights f
						where f.ffrom = 'Bangalore' AND f.fto = 'Delhi' );

/*vii.	A customer wants to travel from Bangalore to Delhi with no more than two changes of flight. List the choice of departure times from Madison if the customer wants to arrive in New York by 6 p.m.*/
SELECT F.departs
FROM Flights F
WHERE F.flno IN ( ( SELECT F0.flno
 FROM Flights F0
 WHERE F0.ffrom = ‘Bangalore’ AND F0.tto = ‘Delhi’
 AND extract(hour from F0.arrives) < 18 )
 UNION
( SELECT F0.flno
 FROM Flights F0, Flights F1
 WHERE F0.ffrom = ‘Bangalore’ AND F0.tto <> ‘Delhi’
 AND F0.tto = F1.ffrom AND F1.tto = ‘Delhi’
 AND F1.departs > F0.arrives
 AND extract(hour from F1.arrives) < 18)
 UNION
( SELECT F0.flno
 FROM Flights F0, Flights F1, Flights F2
 WHERE F0.ffrom = ‘Bangalore’
 AND F0.tto = F1.ffrom
 AND F1.tto = F2.ffrom
 AND F2.tto = ‘Delhi’
 AND F0.tto <> ‘Delhi’
 AND F1.tto <> ‘Delhi’
 AND F1.departs > F0.arrives
 AND F2.departs > F1.arrives
 AND extract(hour from F2.arrives) < 18));
 
/* viii.	Print the name and salary of every non-pilot whose salary is more than the average salary for pilots.*/

SELECT E.ename, E.salary
FROM Employees E
WHERE E.eid NOT IN ( SELECT DISTINCT C.eid
 FROM Certified C )
AND E.salary >( SELECT AVG (E1.salary)
 FROM Employees E1
 WHERE E1.eid IN
( SELECT DISTINCT C1.eid
 FROM Certified C1 ) ); 
