USE Lab_20;

CREATE TABLE IF NOT EXISTS Cars (
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    VIN varchar(55),
    Manufacturer varchar(55),
    Model varchar(55),
    Year int,
    Color varchar(55)
    );

CREATE TABLE IF NOT EXISTS Customers (
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	CustomerID int,
    Name varchar(55),
	Phone varchar(55),
    Email varchar(55),
    Address varchar(200),
    City varchar(50),
    State_Province varchar(50),
    Country varchar(50),
    ZIP int
    );

CREATE TABLE IF NOT EXISTS Salespersons (
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    StaffID int,
    Name varchar(55),
    Store varchar(55)
    );

CREATE TABLE IF NOT EXISTS Invoices (
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Invoice_number int,
    Invoice_Date DATE,
    Car int,
    Customer int,
    Salesperson int,
    FOREIGN KEY (Car) REFERENCES Cars(ID),
    FOREIGN KEY (Customer) REFERENCES Customers(ID),
    FOREIGN KEY (Salesperson) REFERENCES Salespersons(ID)
    ); 