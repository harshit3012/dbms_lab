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
SELECT DISTINCT SID
FROM CATALOG, PARTS
WHERE CATALOG.PID=PARTS.PID AND PARTS.COLOR="Red" OR PARTS.COLOR="Green";
SELECT Catalog.SID
FROM SUPPLIER, CATALOG, PARTS
WHERE (SUPPLIER.sid=CATALOG.sid AND SUPPLIER.city="Bangalore") OR (PARTS.pid=CATALOG.pid AND PARTS.color="Red");
SELECT C1.SID, C2.SID
FROM CATALOG C1, CATALOG C2
WHERE C1.SID>C2.SID AND C1.PID=C2.PID;