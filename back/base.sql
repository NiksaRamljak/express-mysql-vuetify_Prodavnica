CREATE TABLE Categories
(
    ID   INTEGER PRIMARY KEY,
    Thumb VARCHAR(100),
    Name VARCHAR(20)
);
CREATE TABLE PaymentMethods
(
    ID   INTEGER PRIMARY KEY,
    Thumb VARCHAR(100),
    Name VARCHAR(20)
);
CREATE TABLE ShippingMethods
(
    ID   INTEGER PRIMARY KEY,
    Thumb VARCHAR(100),
    Name VARCHAR(20)
);
CREATE TABLE Status
(
    ID INTEGER PRIMARY KEY,
    Status VARCHAR(20)
);
CREATE TABLE Product
(
    ID          INTEGER PRIMARY KEY,
    CategoryID  INTEGER NOT NULL,
    ProductName VARCHAR(50),
    Price       DECIMAL(10, 2),
    FOREIGN KEY (CategoryID) REFERENCES Categories (ID)
);

CREATE TABLE Customer
(
    ID        INTEGER PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName  VARCHAR(50),
    Email     VARCHAR(100)
);
CREATE TABLE Address
(
    ID         INTEGER PRIMARY KEY,
    CustomerID INTEGER,
    Address    VARCHAR(100) NOT NULL,
    City       VARCHAR(50) NOT NULL,
    State      VARCHAR(50),
    PostCode   VARCHAR(20) NOT NULL,
    Country    VARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer (ID)
);

CREATE TABLE Orders
(
    ID         INTEGER PRIMARY KEY,
    CustomerID INTEGER,
    OrderDate  DATETIME,
    StatusID   INTEGER,
    FOREIGN KEY (CustomerID) REFERENCES Customer (ID),
    FOREIGN KEY (StatusID) REFERENCES Status (ID)
);
CREATE TABLE OrderItems
(
    ID        INTEGER PRIMARY KEY AUTO_INCREMENT,
    OrderID   INTEGER,
    ProductID INTEGER,
    Quantity  INTEGER,
    FOREIGN KEY (OrderID) REFERENCES Orders (ID),
    FOREIGN KEY (ProductID) REFERENCES Product (ID)
);
CREATE TABLE Payments
(
    ID       INTEGER PRIMARY KEY,
    OrderID         INTEGER,
    PaymentDate     DATETIME,
    Amount          DECIMAL(10, 2),
    PaymentMethodID INTEGER,
    FOREIGN KEY (OrderID) REFERENCES Orders (ID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods (ID)
);

CREATE TABLE Shipping
(
    ID               INTEGER PRIMARY KEY,
    OrderID          INTEGER,
    ShippingMethodID INTEGER,
    ShippingCost     DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders (ID),
    FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethods (ID)
);
CREATE TABLE Receipts
(
    ID   INTEGER PRIMARY KEY,
    OrderID     INTEGER,
    PaymentID   INTEGER,
    AddressID   INTEGER,
    ShippingID  INTEGER,
    ReceiptDate DATETIME,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders (ID),
    FOREIGN KEY (PaymentID) REFERENCES Payments (ID),
    FOREIGN KEY (AddressID) REFERENCES Address (ID),
    FOREIGN KEY (ShippingID) REFERENCES Shipping (ID)
);
