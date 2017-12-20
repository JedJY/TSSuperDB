/*
  * Tao & Sons Supermarket Chain Database
  * Names:Jed Yeung, Travis Price
  * 
  *
  *
*/

DROP SCHEMA IF EXISTS TSDatabase;
CREATE SCHEMA TSDatabase;
USE TSDatabase;

-- SUPERMARKET Table Stucture --

CREATE TABLE SUPERMARKET
(
  SuperMarketID INT(5) NOT NULL,
  SuperMarketLocation VARCHAR(60) NOT NULL,
  SuperMarketManagerName VARCHAR(30) NOT NULL,
  PhoneNumber VARCHAR(11) NOT NULL,
  PRIMARY KEY (SuperMarketID)
);

--  DAPARTMENT Table Structure --

CREATE TABLE DEPARTMENT
(
  DepartmentNumber INT(2) NOT NULL,
  DepartmentName VARCHAR(25) NOT NULL,
  PRIMARY KEY (DepartmentNumber, DepartmentName)
);

-- ITEM Table Structure --

CREATE TABLE ITEM
(
  ItemID VARCHAR(10) NOT NULL,
  ItemPrice DECIMAL(19,2) NOT NULL,
  ItemQuanitity INT NOT NULL,
  DepartmentNumber INT NOT NULL,
  DepartmentName VARCHAR(25) NOT NULL,
  PRIMARY KEY (ItemID),
  FOREIGN KEY (DepartmentNumber, DepartmentName) REFERENCES DEPARTMENT(DepartmentNumber, DepartmentName)
);

-- CUSTOMER Table Structure --

CREATE TABLE CUSTOMER
(
  DatePurchaseMade DATETIME NOT NULL,
  MemberID INT NOT NULL,
  CustomerName VARCHAR(60) NOT NULL,  -- must be member in order to make purchase
  PRIMARY KEY (DatePurchaseMade, MemberID)
);

-- CASHIER Table Structure --

CREATE TABLE CASHIER
(
  CashierID INT NOT NULL,
  CashierName VARCHAR(60) NOT NULL,
  PosID INT NOT NULL,
  PRIMARY KEY (CashierID)
);

-- Shops_At Table Structure --

CREATE TABLE Shops_At
(
  DatePurchaseMade DATETIME NOT NULL,
  MemberID INT NOT NULL,
  SuperMarketID INT(5) NOT NULL,
  PRIMARY KEY (DatePurchaseMade, MemberID, SuperMarketID),
  FOREIGN KEY (DatePurchaseMade, MemberID) REFERENCES CUSTOMER(DatePurchaseMade, MemberID),
  FOREIGN KEY (SuperMarketID) REFERENCES SUPERMARKET(SuperMarketID)
);

-- EMPLOYEE Table Structure --

CREATE TABLE EMPLOYEE
(
  EmployeeName VARCHAR(60) NOT NULL,
  EmployeeID INT NOT NULL,
  DepartmentNumber INT(2) NOT NULL,
  DepartmentName VARCHAR(25) NOT NULL,
  SuperMarketID INT(5) NOT NULL,
  -- Works__atDepartmentNumber INT(2),
  -- Works__atDepartmentName VARCHAR(25),
  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (DepartmentNumber, DepartmentName) REFERENCES DEPARTMENT(DepartmentNumber, DepartmentName),
  FOREIGN KEY (SuperMarketID) REFERENCES SUPERMARKET(SuperMarketID)
  -- FOREIGN KEY (Works__atDepartmentNumber, Works__atDepartmentName) REFERENCES DEPARTMENT(DepartmentNumber, DepartmentName)
);

-- ORDER Table Structure --

CREATE TABLE ORDERS
(
  -- doesnt make sense without total
  OrderID INT NOT NULL,
  DatePurchaseMade DATETIME NOT NULL,
  MemberID INT NOT NULL,
  CashierID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (DatePurchaseMade, MemberID) REFERENCES CUSTOMER(DatePurchaseMade, MemberID),
  FOREIGN KEY (CashierID) REFERENCES CASHIER(CashierID)
);

-- ORDERLINEITEM Table Stucture --

CREATE TABLE ORDERLINEITEM
(
  ItemID VARCHAR(10) NOT NULL,
  ItemQuantity INT NOT NULL,
  ItemPrice DECIMAL(19,2) NOT NULL,
  OrderLineItemID INT NOT NULL,
  OrderID INT NOT NULL,
  PRIMARY KEY (OrderLineItemID),
  FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID)
);

-- Is_a Table Structure --

CREATE TABLE Is_a
(
  EmployeeID INT NOT NULL,
  CashierID INT NOT NULL,
  PRIMARY KEY (EmployeeID, CashierID),
  FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID),
  FOREIGN KEY (CashierID) REFERENCES CASHIER(CashierID)
);

-- EMPLOYEE_PhoneNumber Table Structure --

CREATE TABLE EMPLOYEE_PhoneNumber
(
  PhoneNumber VARCHAR(10) NOT NULL,
  EmployeeID INT NOT NULL,
  PRIMARY KEY (PhoneNumber, EmployeeID),
  FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);

-- -------------------------------------------

-- Test Data --

/*
  Supermarket Table Sample Insert
*/

INSERT INTO SUPERMARKET(
  SuperMarketID,
  SuperMarketLocation,
  SuperMarketManagerName,
  PhoneNumber
) VALUES
(00001, 'Newport Beach, CA', 'Audra T. Thompson', '9497231257'),
(00002, 'Enfield, CT', 'Erica J. Russell', '8607462838'),
(00003, 'Fall Branch, TN', 'Margaret B. Helmer', '4238974830'),
(00004, 'Tidioute, PA', 'Israel P. Jose', '8144841183'),
(00005, 'Cheboygan, MI', 'Gussie T. Haley', '2316259507'),
(00006, 'Monticello, AR', 'Christopher M. Jacob', '8703675642'),
(00007, 'Washington, DC', 'Marylou C. Walden', '2023289690');

INSERT INTO DEPARTMENT(
  DepartmentNumber,
  DepartmentName
) VALUES
(01, 'Produce & Deli'),
(02, 'Diary & Eggs'),
(03, 'Frozen'),
(04, 'Beverages & Snacks'),
(05, 'Meat & Seafood'),
(06, 'Bakery'),
(07, 'Pantry & Canned Goods');

INSERT INTO ITEM(
  ItemID,
  ItemPrice,
  ItemQuanitity,
  DepartmentNumber,
  DepartmentName
) VALUES
('FRESCUCUMB', 0.99, 10, 01, 'Produce & Deli'),
('ORGDOZEGG0', 3.99, 100, 02, 'Diary & Eggs'),
('BENJERIC02', 4.99, 205, 03, 'Frozen'),
('NABISOREO1', 2.99, 5, 04, 'Beverages & Snacks'),
('PERDUCHK02', 3.99, 50, 05, 'Meat & Seafood'),
('NATOWWHE01', 3.39, 80, 06, 'Bakery'),
('PROGRES041', 2.19, 80, 07, 'Pantry & Canned Goods');

-- DATETIME 'YYYY-MM-DD HH:MM:SS'

INSERT INTO CUSTOMER(
  DatePurchaseMade,
  MemberID,
  CustomerName
) VALUES
('2017-12-01 14:34:22', 0201, 'Alvin L. Hill'),
('2017-12-02 12:22:45', 0202, 'Michel L. Taylor'),
('2017-12-03 16:16:34', 0203, 'Monica J. Locklear'),
('2017-12-03 11:58:46', 0204, 'Shirley J. Smith'),
('2017-12-04 09:28:39', 0205, 'Paul F. Bergeron'),
('2017-12-06 18:36:23', 0206, 'Louis B. Yoder'),
('2017-12-07 13:21:11', 0207, 'Steve J. Parker');


INSERT INTO CASHIER(
  CashierID,
  CashierName,
  PosID
) VALUES
(001, 'Jean P. Jackson', 01),
(002, 'Barbara H. Boyle', 02);

INSERT INTO Shops_At(
  DatePurchaseMade,
  MemberID,
  SuperMarketID
) VALUES
('2017-12-01 14:34:22', 0201, 00001),
('2017-12-02 12:22:45', 0202, 00002),
('2017-12-03 16:16:34', 0203, 00003),
('2017-12-03 11:58:46', 0204, 00004),
('2017-12-04 09:28:39', 0205, 00005),
('2017-12-06 18:36:23', 0206, 00006),
('2017-12-07 13:21:11', 0207, 00007);

INSERT INTO EMPLOYEE(
  EmployeeName ,
  EmployeeID ,
  DepartmentNumber ,
  DepartmentName ,
  SuperMarketID
) VALUES
('Barbara W. Barnes', 0001, 07, 'Pantry & Canned Goods', 00001),
('Sean F. Hausman', 0002, 06, 'Bakery', 00002),
('John C. Cooper', 0003, 05, 'Meat & Seafood', 00003),
('Barbara H. Boyle', 0004, 04, 'Beverages & Snacks', 00004),
('Dave G. Morales', 0005, 03, 'Frozen', 00005),
('Joseph D. Hawkins', 0006, 01, 'Produce & Deli', 00006),
('Jean P. Jackson', 0007, 02, 'Diary & Eggs', 00007);

INSERT INTO ORDERS(
  OrderID ,
  DatePurchaseMade,
  MemberID ,
  CashierID
) VALUES
(0001, '2017-12-01 14:34:22', 0201, 001),
(0002, '2017-12-02 12:22:45', 0202, 001),
(0003, '2017-12-03 16:16:34', 0203, 001),
(0004, '2017-12-03 11:58:46', 0204, 001),
(0005, '2017-12-04 09:28:39', 0205, 002),
(0006, '2017-12-06 18:36:23', 0206, 002),
(0007, '2017-12-07 13:21:11', 0207, 002);


INSERT INTO ORDERLINEITEM(
  ItemID,
  ItemQuantity,
  ItemPrice, 
  OrderLineItemID,
  OrderID
) VALUES
('FRESCUCUMB', 1, 0.99, 01, 0001),
('ORGDOZEGG0', 1, 3.99, 02, 0002),
('BENJERIC02', 1, 4.99, 03, 0003),
('NABISOREO1', 1, 2.99, 04, 0004),
('PERDUCHK02', 1, 3.99, 05, 0005),
('NATOWWHE01', 1, 3.39, 06, 0006),
('PROGRES041', 1, 2.19, 07, 0007),
('FRESCUCUMB', 1, 0.99, 08, 0007),
('ORGDOZEGG0', 1, 3.99, 09, 0006),
('BENJERIC02', 1, 4.99, 10, 0005),
('NABISOREO1', 1, 2.99, 11, 0004),
('PERDUCHK02', 1, 3.99, 12, 0003),
('NATOWWHE01', 1, 3.39, 13, 0002),
('PROGRES041', 1, 2.19, 14, 0001);

INSERT INTO Is_a(
  EmployeeID,
  CashierID
) VALUES
(0004,001),
(0007,002);

INSERT INTO EMPLOYEE_PhoneNumber(
  PhoneNumber,
  EmployeeID
) VALUES
('9082198398', 0001),
('2522382448', 0002),
('3052869473', 0003),
('4016204343', 0004),
('6072937777', 0005),
('9316676840', 0006),
('2077556251', 0007);

-- Procedures --


-- Triggers --


