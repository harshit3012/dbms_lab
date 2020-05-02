CREATE DATABASE SUPP;
USE SUPP;
CREATE TABLE PARTS(PART_NAME VARCHAR(20), PART_ID VARCHAR(10) PRIMARY KEY);
CREATE TABLE SUPPLIER(SNAME VARCHAR(20) NOT NULL, PART_ID VARCHAR(10) NOT NULL, PRICE INT NOT NULL);
INSERT INTO PARTS VALUES ("BOLT", 110000), ("SCREW", 101010), ("NUT", 100001), ("RIVET", 1111111);
INSERT INTO SUPPLIER VALUES ("A1 SUPS", "BOLT", 21), ("A2 SUPS", "BOLT", 24), ("A3 SUPS", "BOLT", 19), ("B1 SUPS", "BOLT", 18),
							("A1 SUPS", "SCREW", 30), ("A2 SUPS", "SCREW", 32), ("A3 SUPS", "SCREW", 29), ("B1 SUPS", "SCREW", 34),
                            ("A1 SUPS", "NUT", 43), ("A2 SUPS", "NUT", 41), ("A3 SUPS", "NUT", 40), ("B1 SUPS", "NUT", 45),
                            ("A1 SUPS", "RIVET", 80), ("A2 SUPS", "RIVET", 74), ("A3 SUPS", "RIVET", 82), ("B1 SUPS", "RIVET", 70);
ALTER TABLE SUPPLIER
ADD constraint PRIMARY KEY(SNAME, PART_ID);
SELECT MAX(PRICE), PART_ID
FROM SUPPLIER
GROUP BY PART_ID;