USE localdb;

	DROP TABLE IF EXISTS cartContBooks;
	DROP TABLE IF EXISTS ShoppingCartManage;
    	DROP TABLE IF EXISTS employeeMonMan;
	DROP TABLE IF EXISTS OrdContBook;
	DROP TABLE IF EXISTS placeOrder;
	DROP TABLE IF EXISTS CustPossesCard;
	DROP TABLE IF EXISTS CreditCard;
	DROP TABLE IF EXISTS review;
	DROP TABLE IF EXISTS Book;
    	DROP TABLE IF EXISTS Customer;
    
CREATE TABLE Customer(
	email VARCHAR(25),
	custName VARCHAR(20),
	phoneNo VARCHAR(12),
	zipCode MEDIUMINT UNSIGNED,
	street VARCHAR(30),
	city VARCHAR(20),
	state VARCHAR(10),
	accID INTEGER UNSIGNED ZEROFILL AUTO_INCREMENT,
	password VARCHAR(30),
	rwdPoint INTEGER DEFAULT 0,
	PRIMARY KEY(accID),
	UNIQUE(eMail));
	
CREATE TABLE CreditCard(
	expDate DATE,
	name VARCHAR(20),
	secCode SMALLINT UNSIGNED,
	number CHAR(20),
	PRIMARY KEY(number));
	
CREATE TABLE CustPossesCard(
	number CHAR(20),
	accID INTEGER UNSIGNED ZEROFILL AUTO_INCREMENT,
	PRIMARY KEY(number, accID),
	FOREIGN KEY (number) REFERENCES CreditCard(number),
	FOREIGN KEY (accID) REFERENCES Customer(accID));
	
	
CREATE TABLE ShoppingCartManage(
	cName CHAR(20),
	dateCreated DATE,
	dateUpdated DATE,
	cartID INTEGER UNSIGNED ZEROFILL AUTO_INCREMENT,
	accID INTEGER UNSIGNED,
	PRIMARY KEY(cartID),
	FOREIGN KEY (accID) REFERENCES Customer(accID));
	
	
-- If we define specific categories "category" can be turned into an ENUM
CREATE TABLE Book(
	category VARCHAR(30),
	autName VARCHAR(30),
	year 	SMALLINT UNSIGNED,
	ISBN	CHAR(30),
	title	VARCHAR(100),
	edition	TINYINT UNSIGNED,
	publisher VARCHAR(50),
	stock INTEGER UNSIGNED,
	avrgRating FLOAT,
	price FLOAT,
	PRIMARY KEY (ISBN));

CREATE TABLE review(
	title CHAR(20),
	rating  FLOAT UNSIGNED,
	accID INTEGER UNSIGNED,
	comment VARCHAR(128), 
	ISBN CHAR(30),
	PRIMARY KEY(accID, ISBN),
	FOREIGN KEY(accID) REFERENCES customer(accID),
	FOREIGN KEY(ISBN) REFERENCES Book(ISBN));	

CREATE TABLE cartContBooks(
	quantity INTEGER UNSIGNED,
	cartID INTEGER UNSIGNED,
	ISBN CHAR(30),
	PRIMARY KEY(cartID, ISBN),
	FOREIGN KEY(cartID) REFERENCES ShoppingCartManage(cartID),
	FOREIGN KEY(ISBN) REFERENCES Book(ISBN));
	
-- Decided to join OrderAndPlaces and join EmployeeMonitorsManagers
CREATE TABLE placeOrder(
	payMethod CHAR(12),
	billAddr CHAR(40),
	shipAddr CHAR(40),
	shipDate DATE,
	orDate	DATE,
	status ENUM('Pending to Pay','Ready To Ship', 'Shipped', 'Delivered', 'Picked Up'),
	totalPrice FLOAT,
	ordID INTEGER UNSIGNED ZEROFILL AUTO_INCREMENT,
	accID INTEGER UNSIGNED,
	PRIMARY KEY(ordID),
	FOREIGN KEY (accID) REFERENCES Customer(accID));
	
CREATE TABLE OrdContBook(
	quantity INTEGER UNSIGNED,
	ordID INTEGER UNSIGNED,
	ISBN CHAR(30),
	PRIMARY KEY(ordID, ISBN),
	FOREIGN KEY(ordID) REFERENCES placeOrder(ordID),
	FOREIGN KEY(ISBN) REFERENCES Book(ISBN));

CREATE TABLE employeeMonMan(
	salary FLOAT UNSIGNED,
	name CHAR(20),
	empAddress CHAR(40),
	rank ENUM('monitor', 'manager'),
	ordID INTEGER UNSIGNED,
	empID INTEGER UNSIGNED ZEROFILL AUTO_INCREMENT,
	PRIMARY KEY(empID),
	FOREIGN KEY (ordID) REFERENCES placeOrder(ordID));	

