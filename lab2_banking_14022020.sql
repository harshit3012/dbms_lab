CREATE DATABASE Banking_enterprise;
USE Banking_enterprise;
CREATE TABLE Branch(
	branch_name VARCHAR(20) NOT NULL,
	branch_city VARCHAR(20) NOT NULL,
	assets REAL NOT NULL,
	PRIMARY KEY(branch_name));
    
CREATE TABLE BankAccount(
	accno int(13) NOT NULL UNIQUE,
	branch_name VARCHAR(20) NOT NULL,
	balance REAL NOT NULL,
	PRIMARY KEY(accno),
	FOREIGN KEY(branch_name) REFERENCES Branch(branch_name));

CREATE TABLE BankCustomer(
	customer_name VARCHAR(40) NOT NULL UNIQUE,
	customer_street VARCHAR(30) NOT NULL,
	customer_city VARCHAR(20) NOT NULL,
	PRIMARY KEY(customer_name));

CREATE TABLE Depositer(
	customer_name VARCHAR(40) NOT NULL,
	accno int(13) NOT NULL UNIQUE,
	PRIMARY KEY(customer_name, accno),
	FOREIGN KEY(customer_name) REFERENCES BankCustomer(customer_name),
	FOREIGN KEY(accno) REFERENCES BankAccount(accno));

CREATE TABLE Loan(
	loan_number int(14) NOT NULL UNIQUE,
	branch_name VARCHAR(20) NOT NULL,
	amount REAL NOT NULL,
	PRIMARY KEY(loan_number));

INSERT INTO branch(branch_name, branch_city, assets) VALUES ("SBI_Chamarajpet", "Bangalore", 50000);
INSERT INTO branch(branch_name, branch_city, assets) VALUES ("SBI_ResidencyRoad", "Bangalore", 10000), ("SBI_ShivajiRoad", "Bombay", 20000), ("SBI_ParliamentRoad", "Delhi", 10000), ("SBI_JantarMantar", "Delhi", 20000);
INSERT INTO bankaccount(accno, branch_name, balance) VALUES (1, "SBI_Chamarajpet", 2000), (2, "SBI_ResidencyRoad", 5000), (3, "SBI_ShivajiRoad", 6000), (4, "SBI_ParliamentRoad", 9000), (5, "SBI_JantarMantar", 8000), (6, "SBI_ShivajiRoad", 4000), (8, "SBI_ResidencyRoad", 4000), (9, "SBI_ParliamentRoad", 3000), (10, "SBI_ResidencyRoad", 5000), (11, "SBI_JantarMantar", 2000);
INSERT INTO bankcustomer(customer_name, customer_street, customer_city) VALUES ("Avinash", "Bull_Temple_Road", "Bangalore"), ("Dinesh", "Bannergatta_Road", "Bangalore"), ("Mohan", "NationalCollege_Road", "Bangalore"), ("Nikil", "Akbar_Road", "Delhi"), ("Ravi", "Prithviraj_Road", "Delhi");

INSERT INTO depositer(customer_name, accno) VALUES ("Avinash", 1), ("Dinesh", 2), ("Nikil", 4), ("Ravi", 5);
INSERT INTO loan(loan_number, branch_name, amount) VALUES (1, "SBI_Chamarajpet", 1000), (2, "SBI_ResidencyRoad", 2000), (3, "SBI_ShivajiRoad", 3000), (4, "SBI_ParliamentRoad", 4000), (5, "SBI_JantarMantar", 5000);
