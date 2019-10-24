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
      VALUES('Dream Books', '2018-03-12', )
