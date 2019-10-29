-- SQL statement for the user functions
-- For Customers
-- New user account registration

DROP PROCEDURE IF EXISTS newUser;

DELIMITER $$

CREATE PROCEDURE newUser(
	IN email VARCHAR(25),
	IN custName VARCHAR(20),
	IN phoneNo VARCHAR(12),
	IN zipCode MEDIUMINT UNSIGNED,
	IN street VARCHAR(30),
	IN city VARCHAR(20),
	IN state VARCHAR(10),
	IN password VARCHAR(32),
	OUT error VARCHAR(2),
	OUT accID INTEGER UNSIGNED) 

BEGIN
	DECLARE hPassword VARCHAR(32);
	IF EXISTS(SELECT C.email FROM Customer C WHERE C.email = email) THEN
		SET error = "E";
		SET accID = 0;
	ELSE
		SELECT MD5(password) INTO hPassword;
		INSERT INTO Customer(email ,custName, phoneNo, zipCode, street, city, state, password)
		VALUES(email ,custName, phoneNo, zipCode, street, city, state, hPassword);
		SELECT LAST_INSERT_ID() INTO accID;
		SET error = "S";
	END IF;
END $$

DELIMITER ;
-- User login
	SELECT accID FROM Customer 
		WHERE email = 'ronvel1502@gmail' AND password = 'unknown';

-- User can update his address, password etc.
UPDATE Customer 
SET zipCode = 72722, street = 'Garland', city =  'New York City', state = 'New York', password = 'NewUnknown', phoneNo = '479-333-666'
	WHERE accID = 1;

-- Book search (by author name, title, category, year or combinations)
SELECT ISBN, title FROM Book
WHERE autName = 'Ricardo', title = 'The ball hurt me', category = 'Horror', year = 1990;
		
SELECT ISBN, title FROM Book
	WHERE autName = 'Robert', title = 'Are you reading?', category = 'Comedy';
		
-- For other combinations, it is only needed to add or remove attribute from the WHERE statement.

-- Create one empty order or shopping cart
	-- Shopping Cart
	INSERT INTO ShoppingCartManage(cName, dateCreate, dateUpdated, accID)
		VALUES('My New Cart', CONVERT(NOW(), DATE), CONVERT(NOW(), DATE), 1);
	
	-- Order
INSERT INTO placeOrder(payMethod, billAddr, shipAddr, orDate, shipDate, status, totalPrice, accID)
VALUES('Credit', '703 W Dickson St', '900 N Leverett Ave.', CONVERT(NOW(), DATE), NULL, 'Pending to Pay', 0.00, 1);

--- Add/delete books from shopping cart
	-- Adding book
	INSERT INTO cartContBooks(quantity, cartID, ISBN)
		VALUES(1, 123, ‘0-553-10354-7’);
	
	-- Delete book [Complete deletion of an entry, not individual books]
	DELETE FROM cartContBooks
		WHERE ISBN = ‘0-553-10354-7’ AND cartID = 123;

-- Merge shopping carts
CREATE PROCEDURE mergeCart(@accID INTEGER UNSIGNED, @name CHAR(20), @cart1ID INTEGER UNSIGNED, @cart2ID INTEGER UNSIGNED, @mergedID INTEGER UNSIGNED OUTPUT)
BEGIN
	INSERT INTO ShoopingCartManage(dateCreate, dateUpdated, accID, cName)
		VALUES(CONVERT(NOW(), DATE), NULL, @accID, @name);
		
	SET @mergedID = SELECT LAST_INSERT_ID();
		
	UPDATE cartContBooks
		SET cartID = @mergeCart
		WHERE cartID = @cart1ID;
		
	UPDATE cartContBooks
		SET cartID = @mergeCart
		WHERE cartID = @cart2ID;
		
	DELETE FROM ShoppingCartManage
		WHERE cartID = @cart1ID;
		
	DELETE FROM ShoopingCartManage
		WHERE cartID = @cart2ID;
END;

-- Change shopping carts as orders
CREATE PROCEDURE cartToOrder(@accID INTEGER UNSIGNED, @cartID INTEGER UNSIGNED, @billAddr CHAR(40), @payMethod CHAR(12), @shipAddr CHAR(40), @ordID INTEGER UNSIGNED OUTPUT)
BEGIN
	DECLARE @ordate DATE;
	DECLARE @totalPrice FLOAT;
		
	SET @orDate = CONVERT(NOW(), DATE);
		
INSERT INTO placedOrder(payMethod, billAddr, shipAddr, shipDate, orDate, status, accID)
VALUES(@payMethod, @billAddr, @shipAddr, NULL, @orDate, 'Pending to Pay', @accID);
		
	SET @ordID = SELECT LAST_INSERT_ID();
		
	INSERT INTO OrdContBook(ordID, quantity, ISBN)
		SELECT @ordID, C.quantity, C.ISBN FROM cartContBooks C
			WHERE cartID = @cartID;
				
	SET @totalPrice =  SELECT SUM( O.quantity * B.price) 
				FROM ordContBook O, Book B
				WHERE O.ordID = @ordID AND O.ISBN = B.ISBN;
	UPDATE placeOrder
		SET totalPrice = @totalPrice
		WHERE ordID = @ordID;
		
	DELETE FROM cartContBooks WHERE cartID =  @cartID;
	DELETE FROM ShoppingCartManage WHERE cartID = @cartID;
END;

-- Place the order 
UPDATE placeOrder
	SET shipDate = CONVERT(DATE_ADD(NOW(), INTERVAL 3 DAY, DATE), 
status = 'Ready To Ship'
		WHERE ordID = 24;

-- Order trace 
SELECT status FROM placeOrder WHERE ordID = 1;

-- Writ a review
INSERT INTO review (title, rating, accID, ISBN, comment)
VALUES ("Amazing Book", 3.5, 1, 023478, 'The book arrived in excellent conditions');
	
-- Edit a written review
	SELECT comment FROM review 
		WHERE title = "Amazing Book" AND accID = 1 AND ISBN = ‘0-553-10354-7’;
	
	UPDATE review 
		SET comment = 'This is the new comment'
		WHERE title = "Amazing Book" AND accID = 1 AND ISBN = ‘0-553-10354-7’;

-- Total reward points 
SELECT accID, custName, rwdpoints from Customer;

-- Functions for employees:
-- List book information (e.g., title, author, price) and quantity-in-stock of    chosen books
SELECT title, author, price, stock from Books 
WHERE ISBN='0-553-10354-7','0-553-10354-12';

--List information about those orders assigned to him/her
SELECT * from placeorder O,employeeMonMan E 
		WHERE O.ordID=  E.ordID;
Update order status
	UPDATE placeOrder SET status='shipped' 
WHERE status='ready to ship';

-- Insert new books
INSERT INTO Books (category, autName , year, ISBN, title, edit, publisher, stock, price)
 VALUES (‘High Fantasy’, ‘George R.R Martin’, 1996, ‘0-553-10354-7’, ‘Game of Thrones’, 2, ‘Bantam Spectra’, 2, 15.98);

-- Update the rating of a book
UPDATE book 
SET avgRating = (SELECT AVG(r.rating) FROM review r, book b WHERE r.ISBN=b.ISBN);

-- Obtained reward points
UPDATE Customer
	SET rwdPoint = rwdPoint + (SELECT totalPrice * 0.1 
FROM placeOrder
	WHERE accID = 1 AND orderID = 2)
	WHERE accID = 1;

-- Applying reward points
CREATE PROCEDURE applyRwdPoints(@accID INTEGER UNSIGNED, @ordID INTEGER UNSIGNED)
BEGIN
	DECLARE @rwdPoint FLOAT;
	DECLARE @orderPrice FLOAT;
		
	SET @rwdPoint =  SELECT rwdPoint FROM Customer WHERE accID = @accID;
SET @orderPrice = SELECT totalPrice FROM placeOrder WHERE ordID = @orderID;
		
	IF @rwdPoint <= @orderPrice THEN
		SET @orderPrice = @orderPrice - @rwdPoint;
		SET @rwdPoint = 0.0;
	ELSE
		SET @rwdPoint = @rwdPoint - @orderPrice;
		SET @orderPrice = 0.0;
	END IF;
		
	UPDATE Customer
		SET rwdPoint = @rwdPoint
		WHERE accID = @accID;
		
	UPDATE placeOrder
		SET totalPrice = @orderPrice
		WHERE ordID = @ordID;
END;

-- Functions for analysts
-- What types of books are better sold in the second quarter than the first quarter?
SELECT b.category,SUM(p.quantity)
		FROM Book b, OrdContBook o, placeOrder p
WHERE b.ISBN=o.ISBN AND p.ordID=o.ordID AND p.orDate
BETWEEN('JAN 01 2019','MAR 31 2019')
		GROUP BY b.category
		ORDER BY SUM(p.quantity)DESC
		LIMIT 1;

-- What kind of books/customers are most profitable?
	SELECT b.category, SUM(p.quantity * b.price)
		FROM Book b, OrdContBook o, placeOrder p
		WHERE b.ISBN=o.ISBN AND p.ordID=o.ordID 
		GROUP BY b.category
		ORDER BY SUM(p.quantity * b.price)DESC
		LIMIT 1;
-- What is the average time between the order placed and shipped?
	SELECT AVG(DATEDIFF(shipDate, orDate))
		FROM placeOrder
		WHERE shipDate != NULL AND orDate != NULL;

-- Is there any significant difference between books published by different publishers in terms of profitability? **
SELECT b.tittle, b.publisher, SUM(O.quantity * b.price)
		FROM book b, OrdContBook o ,placeorder p
		WHERE b.ISBN=o.ISBN AND p.ordID=o.ordID
		GROUP BY (b.tittle,b.publisher);

-- Does the overall rating effect the sales of a book? *
	SELECT b.ISBN, b.tittle,  b.avgRating, SUM(o.quantity) FROM book b, OrdContBook o
		WHERE b.ISBN=o.ISBN GROUP BY (b.ISBN,b.avgRating)
ORDER BY b.avgRating; 

-- Who is the most loyal customer (or the top 10 loyal customers) 
SELECT accID, custName 
FROM Customer 
ORDER BY rwdPoint 
DESC LIMIT 10;	
	

