CREATE DATABASE STU_FAC;
USE STU_FAC;
CREATE TABLE STUDENT(
	snum INT PRIMARY KEY,
    sname VARCHAR(30) NOT NULL,
    major VARCHAR(20) NOT NULL,
    lvl VARCHAR(2) NOT NULL,
    age INT(2) NOT NULL);
	
CREATE TABLE Faculty(
fid INT,
fname VARCHAR(20),
deptid INT,
PRIMARY KEY(fid));
			
CREATE TABLE Class(
	cname VARCHAR(20) NOT NULL,
    meetsat TIMESTAMP,
    room VARCHAR(10),
    fid INT(10) NOT NULL,
	PRIMARY KEY(cname),
	FOREIGN KEY (fid) REFERENCES Faculty(fid));

CREATE TABLE Enrolled(
	snum INT PRIMARY KEY,
    cname VARCHAR(20) NOT NULL,
	PRIMARY KEY(snum,cname),
	FOREIGN KEY(snum) REFERENCES Student(snum),
	FOREIGN KEY(cname) REFERENCES Class(cname));
										
insert into Student values(1, 'jhon', 'CS', 'Sr', 19), (2, 'Smith', 'CS', 'Jr', 20), (3 , 'Jacob', 'CV', 'Sr', 20), (4, 'Tom ', 'CS', 'Jr', 20), (5, 'Rahul', 'CS', 'Jr', 20), (6, 'Rita', 'CS', 'Sr', 21);
insert into faculty values(11, 'Harish', 1000),(12, 'MV', 1000),(13 , 'Mira', 1001),(14, 'Shiva', 1002),(15, 'Nupur', 1000);
insert into Class values('class1', '12/11/15 10:15:16', 'R1', 14),('class10', '12/11/15 10:15:16', 'R128', 14),('class2', '12/11/15 10:15:20', 'R2', 12),('class3', '12/11/15 10:15:25', 'R3', 12),('class4', '12/11/15 20:15:20', 'R4', 14),('class5', '12/11/15 20:15:20', 'R3', 15),('class6', '12/11/15 13:20:20', 'R2', 14),('class7', '12/11/15 10:10:10', 'R3', 14);
insert into Enrolled values(1, 'class1'),(2, 'class1'),(3, 'class3'),(4, 'class3'),(5, 'class4'),(1, 'class5'),(2, 'class5'),(3, 'class5'),(4,'class5'),(5,'class5');

select distinct sname 
from Student,Faculty,Class,Enrolled
where fname='MV' AND Faculty.fid=Class.Fid and Student.snum=Enrolled.snum and Class.cname=Enrolled.cname and Student.lvl='Jr'; 

select cname
from Class
where room='R128' OR cname in ( select distinct cname 
				from Enrolled
                                group by cname
                                having count(*)>=5);

select sname
from Student
where snum in (select e1.snum 
		from Enrolled e1,Enrolled e2,Class c1,Class c2
                where e1.snum=e2.snum and e1.cname=c1.cname and e2.cname=c2.cname and e1.cname<>e2.cname and c1.meetsat=c2.meetsat);

select fname
from Faculty
where not exists(select room from Class
	         except
                 select distinct c.room 
                 from Class c
                 where c.fid=Faculty.fid);

select distinct fname
from Faculty
where 5>(select count(Enrolled.snum)
		 from Enrolled,Class
		 where Enrolled.cname=Class.cname and Class.fid=Faculty.fid);

select sname
from Student
where snum not in (select snum
		   from Enrolled);

select S.age, S.lvl
from Student S
group by S.age, S.lvl
having S.lvl in (select S1.lvl from Student S1
                 where S1.age = S.age
		 group by S1.lvl, S1.age
                 having count(*) >= all (select count(*)
					 from Student S2
					  where s1.age = S2.age
					  group by S2.lvl, S2.age));
