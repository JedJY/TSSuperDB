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
  SuperMarketID VARCHAR(5) NOT NULL,
  SuperMarketLocation VARCHAR(60) NOT NULL,
  SuperMarketManagerName VARCHAR(30) NOT NULL,
  PhoneNumber VARCHAR(10) NOT NULL,
  PRIMARY KEY (SuperMarketID)
);

--  DAPARTMENT Table Structure --

CREATE TABLE DEPARTMENT
(
  DepartmentNumber INT NOT NULL,
  DepartmentName VARCHAR(25) NOT NULL,
  PhoneNumber VARCHAR(10) NOT NULL,
  SuperMarketID INT NOT NULL,
  PRIMARY KEY (DepartmentNumber, DepartmentName),
  FOREIGN KEY (SuperMarketID) REFERENCES SUPERMARKET(SuperMarketID)
);

-- ITEM Table Structure --

CREATE TABLE ITEM
(
  ItemID INT NOT NULL,
  ItemPrice INT NOT NULL,
  ItemQuanitity INT NOT NULL,
  PLU INT NOT NULL,
  DepartmentNumber INT NOT NULL,
  DepartmentName INT NOT NULL,
  PRIMARY KEY (ItemID),
  FOREIGN KEY (DepartmentNumber, DepartmentName) REFERENCES DEPARTMENT(DepartmentNumber, DepartmentName)
);

-- CUSTOMER Table Structure --

CREATE TABLE CUSTOMER
(
  DatePurchaseMade INT NOT NULL,
  MemberID INT NOT NULL,
  CustomerName INT,
  PRIMARY KEY (DatePurchaseMade, MemberID)
);

-- CASHIER Table Structure --

CREATE TABLE CASHIER
(
  CashierID INT NOT NULL,
  CashierName INT NOT NULL,
  PosID INT NOT NULL,
  PRIMARY KEY (CashierID)
);

-- Shops_At Table Structure --

CREATE TABLE Shops_At
(
  DatePurchaseMade INT NOT NULL,
  MemberID INT NOT NULL,
  SuperMarketID INT NOT NULL,
  PRIMARY KEY (DatePurchaseMade, MemberID, SuperMarketID),
  FOREIGN KEY (DatePurchaseMade, MemberID) REFERENCES CUSTOMER(DatePurchaseMade, MemberID),
  FOREIGN KEY (SuperMarketID) REFERENCES SUPERMARKET(SuperMarketID)
);

-- EMPLOYEE Table Structure --

CREATE TABLE EMPLOYEE
(
  EmployeeName INT NOT NULL,
  EmployeeID INT NOT NULL,
  DepartmentNumber INT NOT NULL,
  DepartmentName INT NOT NULL,
  SuperMarketID INT NOT NULL,
  Works__atDepartmentNumber INT,
  Works__atDepartmentName INT,
  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (DepartmentNumber, DepartmentName) REFERENCES DEPARTMENT(DepartmentNumber, DepartmentName),
  FOREIGN KEY (SuperMarketID) REFERENCES SUPERMARKET(SuperMarketID),
  FOREIGN KEY (Works__atDepartmentNumber, Works__atDepartmentName) REFERENCES DEPARTMENT(DepartmentNumber, DepartmentName)
);

-- ORDER Table Structure --

CREATE TABLE ORDER
(
  OrderID INT NOT NULL,
  DatePurchaseMade INT NOT NULL,
  MemberID INT NOT NULL,
  CashierID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (DatePurchaseMade, MemberID) REFERENCES CUSTOMER(DatePurchaseMade, MemberID),
  FOREIGN KEY (CashierID) REFERENCES CASHIER(CashierID)
);

-- ORDERLINEITEM Table Stucture --

CREATE TABLE ORDERLINEITEM
(
  ItemID INT NOT NULL,
  ItemQuantity INT NOT NULL,
  ItemPrice INT NOT NULL,
  OrderLineItemID INT NOT NULL,
  PLU INT NOT NULL,
  OrderID INT NOT NULL,
  PRIMARY KEY (OrderLineItemID),
  FOREIGN KEY (OrderID) REFERENCES ORDER(OrderID)
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
  PhoneNumber INT NOT NULL,
  EmployeeID INT NOT NULL,
  PRIMARY KEY (PhoneNumber, EmployeeID),
  FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);

-- -------------------------------------------

-- Test Data --


-- Procedures --


-- Triggers --


