-- SQL statement for the user functions
-- For Customers
-- New user account registration

	DROP PROCEDURE IF EXISTS newUser;
	DROP PROCEDURE IF EXISTS logIn;
	DROP PROCEDURE IF EXISTS mergeCart;
	DROP PROCEDURE IF EXISTS applyRwdPoints;
	DROP PROCEDURE IF EXISTS cartToOrder;

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

-- User login

	CREATE PROCEDURE logIn(
		IN email VARCHAR(25),
		IN password VARCHAR(32),
		OUT accID INTEGER UNSIGNED)
	BEGIN
		SELECT C.accID FROM Customer C WHERE C.email = email AND C.password = MD5(password) INTO accID;
	END $$

	DELIMITER ;

-- User can update his address, password etc.
	
	UPDATE Customer 
	SET zipCode = 72722, street = 'Garland', city =  'Fayetteville', state = 'Arkansas', password = MD5('NewPassword'), phoneNo = '479-333-666'
	WHERE accID = 1;

-- Book search (by author name, title, category, year or combinations)
	-- For performance reasons most of the query is going to be implemented in the front end
	-- WHERE condition is going to be built by putting every aspect of the search together in the front end
	
	SELECT ISBN, title FROM Book
	WHERE autName = 'Stephan Pentak', title = 'Design Basics', category = 'Art & Photography';
		
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
		VALUES(1, 1, ‘978-0-596-15806-4’);
	
	-- Delete book [Complete deletion of an entry, not individual books]
	DELETE FROM cartContBooks
		WHERE ISBN = ‘0-553-10354-7’ AND cartID = 123;

-- Merge shopping carts
	DELIMITER $$
		CREATE PROCEDURE mergeCart(
			IN @accID INTEGER UNSIGNED,
			IN @name CHAR(20),
			IN @cart1ID INTEGER UNSIGNED, 
			IN @cart2ID INTEGER UNSIGNED, 
			OUT @mergedID INTEGER UNSIGNED)
		BEGIN
			INSERT INTO ShoopingCartManage(dateCreate, dateUpdated, accID, cName)
				VALUES(CONVERT(NOW(), DATE), NULL, @accID, @name);

			SELECT LAST_INSERT_ID() INTO @mergedID;

			UPDATE cartContBooks
				SET cartID = @mergedID;
				WHERE cartID = @cart1ID;

			UPDATE cartContBooks
				SET cartID = @mergedID;
				WHERE cartID = @cart2ID;

			DELETE FROM ShoppingCartManage
				WHERE cartID = @cart1ID;

			DELETE FROM ShoopingCartManage
				WHERE cartID = @cart2ID;
		END $$

	DELIMITER ;
	
-- Turn shopping carts to orders
CREATE PROCEDURE cartToOrder(
	IN @accID INTEGER UNSIGNED, 
	IN @cartID INTEGER UNSIGNED, 
	IN @billAddr CHAR(40), 
	IN @payMethod CHAR(12), 
	IN @shipAddr CHAR(40), 
	OUT @ordID INTEGER UNSIGNED)
BEGIN
	DECLARE @ordate DATE;
	DECLARE @totalPrice FLOAT;
		
	SET @orDate = CONVERT(NOW(), DATE);
		
	INSERT INTO placedOrder(payMethod, billAddr, shipAddr, shipDate, orDate, status, accID)
	VALUES(@payMethod, @billAddr, @shipAddr, NULL, @orDate, 'Pending to Pay', @accID);
		
	SELECT LAST_INSERT_ID() INTO  @ordID;
		
	INSERT INTO OrdContBook(ordID, quantity, ISBN)
		SELECT @ordID, C.quantity, C.ISBN FROM cartContBooks C
			WHERE cartID = @cartID;
				
	SELECT SUM( O.quantity * B.price) 
		FROM ordContBook O, Book B
		WHERE O.ordID = @ordID AND O.ISBN = B.ISBN INTO @totalPrice;
		
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
		VALUES ("Amazing Book", 3.5, 1, '978-0-14-303858-0', 'The book arrived in excellent conditions');
	
-- Edit a written review
	SELECT comment FROM review 
		WHERE title = "Amazing Book" AND accID = 1 AND ISBN = '978-0-14-303858-0';
	
	UPDATE review 
		SET comment = 'This is the new comment'
		WHERE title = "Amazing Book" AND accID = 1 AND ISBN = '978-0-14-303858-0';

-- Total reward points 
	SELECT accID, custName, rwdpoints FROM Customer;

-- Functions for employees:
-- List book information (e.g., title, author, price) and quantity-in-stock of chosen books
	SELECT title, author, price, stock FROM Books 
	WHERE ISBN = '978-0-393-09219-6' OR ISBN = '978-0-517-02530-7';

--List information about those orders assigned to him/her
	SELECT * FROM placeorder O, employeeMonMan E 
		WHERE O.ordID = E.ordID;
	UPDATE order status
	UPDATE placeOrder SET status='shipped' 
	WHERE status='ready to ship';

-- Insert new books
INSERT INTO Books (category, autName , year, ISBN, title, edit, publisher, stock, price)
 VALUES ( 'Science Fiction & Fantasy', 'George R.R Martin', 1996, '978-1-5247-9628-0', 'Fire and Blood: 300 Years Before A Game of Thrones’, 1, 'Bantam Spectra', 10, 15.98);

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
	DELIMITER $$
	CREATE PROCEDURE applyRwdPoints(
		IN accID INTEGER UNSIGNED,
		IN ordID INTEGER UNSIGNED)
	BEGIN
		DECLARE rwdPoint FLOAT;
		DECLARE orderPrice FLOAT;

		SELECT C.rwdPoint FROM Customer C WHERE C.accID = accID INTO rwdPoint;
		SELECT P.totalPrice FROM placeOrder P WHERE P.ordID = orderID INTO orderPrice;

		IF rwdPoint <= orderPrice THEN
			SET orderPrice = orderPrice - rwdPoint;
			SET rwdPoint = 0.0;
		ELSE
			SET rwdPoint = rwdPoint - orderPrice;
			SET orderPrice = 0.0;
		END IF;

		UPDATE Customer C
			SET C.rwdPoint = rwdPoint
			WHERE C.accID = accID;

		UPDATE placeOrder P
			SET P.totalPrice = orderPrice
			WHERE P.ordID = ordID;
	END $$
	DELIMITER ;

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
	

