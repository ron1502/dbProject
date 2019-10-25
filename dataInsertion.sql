INSERT INTO Customer (email, custName, phoneNo, zipCode, street, city, state, password, rwdPoint)
      VALUES('richard@gmail.com','Richard Castro', '479-679-9091', 72701, '300 N Garland Ave.', 'Fayetteville', 'Arkansas', 'dfas452', 0),
      VALUES('costellTyler@yahoo.com', 'Tyler Costello', '501-742-8723', 72002, '300 E Midland Rd.', 'Alexander', 'Arkansas', 'fasdf35', 0),
      VALUES('neha@outlook.com', 'Neha Sharma', '417-567-0923', 65619, '500 W Glenstone Ave.', 'Springfield, 'Missouri', 'drgt345aw', 0),
      VALUES('ronk@uak.edu', 'Ronald kingstone', '870-674-9061', '700 N. West 13th Ave.', 'Pine Bluff', 'Arkansas', 'dfsadf3245', 0),
      VALUES('hongKong@hotmail.com', 'Hong Kong', '405-871-3467', '300 S. Creston Drive', 'Oklahoma City', 'Oklahoma', 'fasdf354', 0);
         
INSERT INTO CreditCard(expDate, name, secCode, number)
      VALUES('2022-02', 'Richard Castro', 340, '8968-4510-8365-9274'),
      VALUES('2020-12', 'Tyler Costello', 890, '5871-8391-5190-2461'),
      VALUES('2021-10', 'Neha Sharma', 120, '7981-7823-9012-7831'),
      VALUES('2025-09', 'Hong Kong', 095, '5721-3719-3749-2910');
             
INSERT INTO CustPossesCard(number, accID)
      VALUES('8968-4510-8365-9274', 1),
      VALUES('5871-8391-5190-2461', 2),
      VALUES('7981-7823-9012-7831', 4),
      VALUES('5721-3719-3749-2910', 5);
  
INSERT INTO ShoppingCartManage(cName, dateCreated, dateUpdated, accID)
      VALUES('Dream Books', '2018-03-12', '2018-03-13', 1),
      VALUES('Mom''s Birthday', '2018-03-15', '2018-04-25', 2),
      VALUES('I''m getting these', '2018-04-26', '2018-04-27', 3),
      VALUES('New Books!!', '2018-05-12', '2018-07-12', 5),
      VALUES('Gifts for Chirstmas', '2018-09-30', '2018-10-25', 5);

INSERT INTO Book(category, autName, year, ISBN, title, edition, publisher, stock, avrgRating, price)
      VALUES('Art & Photography', 'Nikki Sixx', 2001, '0-06-098915-7', 'The Dirt: Confession of the Workd's Most Notorious Rock Band',
             1, 'HarperEntertainment', 10, 0, 10.00),
      VALUES('Art & Photography','Stephan Pentak', 2016, '978-1285858227', 'Design Basics', 9, 'CENGAGE Learning',
             20, 0, 69.99),
      VALUES('Art & Photography', 'Editors of Phaidon', 2012 , ' 978-0714864679',  'THe Art Book: New Edition', 2,
             'Phaidon', 15, 0, 70.99),
      
             
