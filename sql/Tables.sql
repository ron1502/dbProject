USE id11009435_dbbookstore
	DROP TABLE IF EXISTS cartContBooks;
	DROP TABLE IF EXISTS ShoppingCartManage;
    DROP TABLE IF EXISTS employeeMonMan;
	DROP TABLE IF EXISTS OrdContBook;
	DROP TABLE IF EXISTS placeOrder;
	DROP TABLE IF EXISTS CustPossesCard;
	DROP TABLE IF EXISTS CreditCard;
	DROP TABLE IF EXISTS Book;
    DROP TABLE IF EXISTS Customer;
    
CREATE TABLE Customer(
	email CHAR(25),
	custName CHAR(20),
	phoneNo CHAR(12),
	zipCode MEDIUMINT UNSIGNED,
	street CHAR(30),
	city CHAR(20),
	state CHAR(10),
	accID INTEGER UNSIGNED ZEROFILL AUTO_INCREMENT,
	password CHAR(30),
	rwdPoint INTEGER,
	PRIMARY KEY(accID),
	UNIQUE(eMail));
	
CREATE TABLE CreditCard(
	expDate DATE,
	name CHAR(20),
	secCode TINYINT UNSIGNED,
	number CHAR(19),
	PRIMARY KEY(number));
	
CREATE TABLE CustPossesCard(
	number CHAR(16),
	accID INTEGER UNSIGNED ZEROFILL AUTO_INCREMENT,
	PRIMARY KEY(number, accID),
	FOREIGN KEY (number) REFERENCES CreditCard(number),
	FOREIGN KEY (accID) REFERENCES Customer(accID));
	
	
CREATE TABLE ShoppingCartManage(
	cName CHAR(20),
	dateCrate DATE,
	dateUpadated DATE,
	cartID INTEGER UNSIGNED ZEROFILL AUTO_INCREMENT,
	accID INTEGER UNSIGNED,
	PRIMARY KEY(cartID),
	FOREIGN KEY (accID) REFERENCES Customer(accID));
	
	
-- If we define specific categories "category" can be turned into an ENUM
CREATE TABLE Book(
	category CHAR(10),
	autName CHAR(30),
	year 	SMALLINT UNSIGNED,
	ISBN	CHAR(30),
	title	CHAR(20),
	edition	TINYINT UNSIGNED,
	publisher CHAR(20),
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

