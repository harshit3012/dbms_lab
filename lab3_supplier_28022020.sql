CREATE DATABASE SUPPLIER;
USE SUPPLIER;
CREATE TABLE Supplier(
	sid INT(5) NOT NULL UNIQUE,
	sname VARCHAR(30) NOT NULL,
	city VARCHAR(30) NOT NULL,
	PRIMARY KEY(sid));
CREATE TABLE Parts(
	pid INT(5) NOT NULL UNIQUE,
	pname VARCHAR(30) NOT NULL,
	color VARCHAR(20) NOT NULL,
	PRIMARY KEY (pid));
CREATE TABLE Catalog(
	sid INT(5) NOT NULL,
	pid INT(5) NOT NULL,
	cost INT(20) NOT NULL,
	PRIMARY KEY(sid, pid),
	FOREIGN KEY(sid) REFERENCES Supplier(sid) ON DELETE CASCADE,
	FOREIGN KEY(pid) REFERENCES Parts(pid) ON DELETE CASCADE);
INSERT INTO Supplier(sid, sname, city) VALUES (10001, "Acme Widget", "Bangalore");
INSERT INTO Parts(pid, pname, color) VALUES (20001, "Book", "Red");
INSERT INTO Supplier(sid, sname, city) VALUES (10002, "Johns", "Kolkata");
INSERT INTO Supplier(sid, sname, city) VALUES (10003, "Vimal", "Mumbai");
INSERT INTO Supplier(sid, sname, city) VALUES (10004, "Reliance", "Delhi");
INSERT INTO Parts(pid, pname, color) VALUES (20002, "Pen", "Red");
INSERT INTO Parts(pid, pname, color) VALUES (20003, "Pencil", "Green");
INSERT INTO Parts(pid, pname, color) VALUES (20004, "Mobile", "Green");
INSERT INTO Parts(pid, pname, color) VALUES (20005, "Charger", "Black");
INSERT INTO Catalog(sid, pid, cost) VALUES (10001, 20001, 10), (10001, 20002, 10), (10001, 20003, 30), (10001, 20004, 10), (10001, 20005, 10), (10002, 20001, 10), (10002, 20002, 20), (10003, 20003, 30), (10004, 20003, 40);

select * from Supplier;
select * from Parts;
select * from Catalog;

SELECT DISTINCT pname 
from Parts, Catalog
where Parts.pid=Catalog.pid;

SELECT sname 
FROM Supplier
WHERE not exists( SELECT pid FROM Parts
					except
                    SELECT distinct pid 
                    FROM Catalog
                    WHERE Catalog.sid=Supplier.sid);

SELECT DISTINCT SID
FROM Catalog, Parts
WHERE Catalog.pid=Parts.pid AND Parts.color="Red" OR Parts.color="Green";

SELECT C1.sid, C2.sid
FROM Catalog C1, Catalog C2
WHERE C1.sid>C2.sid AND C1.pid=C2.pid;

SELECT Catalog.sid
FROM SUPPLIER, Catalog, Parts
WHERE (Supplier.sid=Catalog.sid AND Supplier.city="Bangalore") OR (Parts.pid=Catalog.pid AND Parts.color="Red");

SELECT pname
FROM Parts,Catalog,Supplier
WHERE Catalog.pid=Parts.pid and Catalog.sid=Supplier.sid 
and Supplier.sname='Acme Widget' and Catalog.pid not in (SELECT c.pid FROM Catalog c ,Supplier s
							WHERE s.sid=c.sid and s.sname<>'Acme Widget');

SELECT sid
FROM Catalog c
WHERE c.cost>( SELECT avg(c1.cost)
		FROM Catalog c1
		WHERE c.pid=c1.pid);

SELECT sid
FROM Catalog c
WHERE c.cost>( select avg(c1.cost)
		from Catalog c1
		where c.pid=c1.pid);				 

SELECT p.pid, s.sname
FROM Parts p, Supplier s, Catalog c
WHERE p.pid=c.pid and s.sid=c.sid
AND c.cost=(SELECT max(c1.cost)
	    FROM Catalog c1
            WHERE c1.pid=c.pid);
