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
      VALUES('Art & Photography', 'Editors of Phaidon', 2012 , '978-0714864679',  'The Art Book: New Edition', 2,
             'Phaidon', 15, 0, 70.99),
      VALUES('Technology', 'Walter Isaacson', 2013, '978-1-4516-4854-6', 'Steve Jobs', 1, 'Norman Seeff', 5, 0, 4.99),
      VALUES('Technology', 'Mark Lutz', 2009, '978-0-596-15806-4', 'Learning Python: Powerful Object-Oriented Programming',
            4, 'O''Reilly', 25, 0, 40.99),
      VALUES('Technology, 'Stephen W. Prate', 1995, '978-1-878739-74-2', 'C++ Primer Plus: Teach Yourself Object-Oriented Programming/Book and Disk',
            2, 'Waite Group Press', 10, 0, 2.99),
      VALUES('Health & Fitness', 'Gary Taubes', 2011, '978-0-307-47425-4', 'Why We Get Fat: And What to Do About It',
             1, 'Alfred A. Knoopf', 10, 0, 6.50),
      VALUES('Health & Fitness', 'B. K. S. Iyengar', 1995, '978-0-8052-1031-6', 'Light on Yoga: The Bible of Modern Yoga',
            1, 'Shocken Books', 5, 0, 15.75),
      VALUES('Health & Fitness', 'Michael Pollan', 2007, '978-0-14-303858-0', 'The Omnivore's Dilemma : A Natural History of Four Meals',
            5, 'The Penguin Press', 15, 0, 10.00),
      
      VALUES('Science & Math', 'Carl Sagan', 2013, '978-0-345-53943-4', 'Cosmos', 1, 'Ballantine Books', 7, 0, 12.00),
      VALUES('Science & Math', 'Charles Darwin', 1975, '978-0-393-09219-6', 'The Origin of Species', 1, 'W W Norton & Co Inc',
             20, 0, 15.99),
      VALUES('Science & Math', 'Albert Einstein', 1961, '978-0-517-02530-7', 'Relativity: The Special and the General Theory', 1,
            'Three Rivers Press', 30, 0, 12.99),
      VALUES('Science Fiction & Fantasy', 'J.K. Rowling', 2009, '978-0-545-13970-0', 'Harry Potter and the Deathly Hallows', 1,
            'Scholastic Press', 12, 0, 10.50),
      VALUES('Science Fiction & Fantasy', 'Suzanne Collins', 2012, '978-0-545-42511-7',  'The Hunger Games: Movie Tie-in Edition', 1,
            'Scholastic Press', 15, 0, 11.00),
      VALUES('Science Fiction & Fantasy', 'J.R.R. Tolkien', 1997, ' 978-0-618-00221-4','The Hobbit: or There and Back Again, 1,
            'Houghton Mifflin Company', 30, 0, 20.30);
