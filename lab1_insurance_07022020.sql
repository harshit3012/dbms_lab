CREATE DATABASE insurance;
show databases;
use insurance;
show tables;
create table PERSON(
  driver_id varchar(30) NOT NULL UNIQUE, 
  name varchar(50) NOT NULL, 
  address longtext not null, 
  primary key(driver_id));

create table CAR(
  reg_num varchar(30) not null unique, 
  model varchar(20) not null, 
  year int(4) not null, 
  primary key(reg_num));

create table ACCIDENT(
  report_num int(20) not null unique, 
  accident_date date not null, 
  location varchar(20) not null, 
  PRIMARY KEY(report_num));

create table PARTICIPATED(
  driver_id varchar(30) NOT NULL, 
  reg_num varchar(30) not null unique, 
  report_num int(20) not null unique, 
  damage_amount float not null, 
  primary key(driver_id, reg_num, report_num), 
  FOREIGN KEY (driver_id) references PERSON(driver_id), 
  foreign key (reg_num) references CAR(reg_num), 
  foreign key (report_num) references ACCIDENT(report_num));

create table OWNS(
  driver_id varchar(30) not null unique, 
  reg_num varchar(30) not null unique, 
  primary key(driver_id, reg_num), 
  foreign key (driver_id) references PERSON(driver_id), 
  foreign key (reg_num) references CAR(reg_num));

insert into PERSON (driver_id, name, address) VALUES ("A01", "Richard", "Srinivas Nagar");
insert into PERSON (driver_id, name, address) VALUES ("A02", "Pradeep", "Rajaji Nagar");
insert into PERSON (driver_id, name, address) VALUES ("A03", "Smith", "Ashok Nagar");
insert into PERSON (driver_id, name, address) VALUES ("A04", "Venu", "N R Colony");
insert into PERSON (driver_id, name, address) VALUES ("A05", "Jhon", "Hanumanth Nagar");
insert INTO CAR(reg_num, model, year) VALUES ("KA032250", "Indica", 1990);
insert INTO CAR(reg_num, model, year) VALUES ("KA031181", "Laneer", 1957);
insert INTO CAR(reg_num, model, year) VALUES ("KA032250", "Indica", 1990);
insert INTO CAR(reg_num, model, year) VALUES ("KA095477", "Toyota", 1998);
insert INTO CAR(reg_num, model, year) VALUES ("KA053408", "Honda", 2008);
insert INTO CAR(reg_num, model, year) VALUES ("KA041702", "Audi", 2005);
insert INTO OWNS(driver_id, reg_num) VALUES ("A01", "KA032250");
insert INTO OWNS(driver_id, reg_num) VALUES ("A02", "KA053408");
insert INTO OWNS(driver_id, reg_num) VALUES ("A03", "KA031181");
insert INTO OWNS(driver_id, reg_num) VALUES ("A04", "KA095477");
insert INTO OWNS(driver_id, reg_num) VALUES ("A05", "KA041702");
INSERT INTO ACCIDENT(report_num, accident_date, location) values (11, '2003-01-01', "Mysore Road");
INSERT INTO ACCIDENT(report_num, accident_date, location) values (12, '2004-02-02', "South End Circle");
INSERT INTO ACCIDENT(report_num, accident_date, location) values (13, '2003-01-21', "Bull Temple Road");
INSERT INTO ACCIDENT(report_num, accident_date, location) values (14, '2008-02-17', "Mysore Road");
INSERT INTO ACCIDENT(report_num, accident_date, location) values (15, '2005-03-04', "Kanakpura Road");
INSERT INTO PARTICIPATED(driver_id, reg_num, report_num, damage_amount) VALUES ("A01", "KA032250", 11, 10000);
INSERT INTO PARTICIPATED(driver_id, reg_num, report_num, damage_amount) VALUES ("A02", "KA053408", 12, 50000);
INSERT INTO PARTICIPATED(driver_id, reg_num, report_num, damage_amount) VALUES ("A03", "KA031181", 13, 25000);
INSERT INTO PARTICIPATED(driver_id, reg_num, report_num, damage_amount) VALUES ("A04", "KA095477", 14, 3000);
INSERT INTO PARTICIPATED(driver_id, reg_num, report_num, damage_amount) VALUES ("A05", "KA041702", 15, 5000);

select * from PARTICIPATED;
update PARTICIPATED set damage_amount=25000 where reg_num="KA053408" AND report_num=12;
insert into ACCIDENT values(16,"2019-01-03","Hanumanth nagar");
select count(distinct driver_id) CNT from PARTICIPATED, ACCIDENT where PARTICIPATED.report_num=ACCIDENT.report_num AND accident_date like '2008%';
select count(distinct model) ACC_MOD from PARTICIPATED, CAR where PARTICIPATED.reg_num=CAR.reg_num AND CAR.model="Toyota";

