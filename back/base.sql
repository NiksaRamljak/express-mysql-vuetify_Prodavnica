CREATE TABLE PaymentProviders
(
    ID   INTEGER PRIMARY KEY,
    Name VARCHAR(20),
    Thumb VARCHAR(80) DEFAULT NULL
);
CREATE TABLE Manufacturer
(
    ID   INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Name VARCHAR(20) NOT NULL
);
CREATE TABLE ShippingMethods
(
    ID   INTEGER PRIMARY KEY,
    Name VARCHAR(20),
    CostModifier DECIMAL(10, 2),
    Thumb VARCHAR(80)
);
CREATE TABLE Status
(
    ID INTEGER PRIMARY KEY,
    Status VARCHAR(20)
);
CREATE TABLE Product
(
    ID          INTEGER PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ManufacturerID INTEGER NOT NULL,
    Description TEXT,
    Thumb VARCHAR(80) DEFAULT NULL,
    Price       DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer (ID)
);
CREATE TABLE Categories
(
    ID   INTEGER PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Thumb VARCHAR(50) DEFAULT NULL
);
CREATE TABLE ProductCategories
(
    PRIMARY KEY (ProductID, CategoryID),
    ProductID   INTEGER NOT NULL,
    CategoryID  INTEGER NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product (ID),
    FOREIGN KEY (CategoryID) REFERENCES Categories (ID)
);
CREATE TABLE Inventory
(
    ProductID INTEGER PRIMARY KEY NOT NULL,
    Quantity  INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (ProductID) REFERENCES Product (ID)
);

CREATE TABLE Customer
(
    ID        INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    UserName  VARCHAR(15) NOT NULL UNIQUE,
    Password  CHAR(60) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName  VARCHAR(50) NOT NULL,
    Email     VARCHAR(100) NOT NULL
);
CREATE TABLE Address
(
    ID         INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    CustomerID INTEGER NOT NULL,
    Address    VARCHAR(100) NOT NULL,
    City       VARCHAR(50) NOT NULL,
    State      VARCHAR(50),
    PostCode   VARCHAR(20) NOT NULL,
    Country    VARCHAR(50) NOT NULL,
    IsDelivery BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (CustomerID) REFERENCES Customer (ID)
);
CREATE TABLE PaymentMethods
(
    ID   INTEGER PRIMARY KEY AUTO_INCREMENT,
    CustomerID INTEGER NOT NULL,
    PaymentProviderID INTEGER NOT NULL,
    BillingAccount VARCHAR(64) NOT NULL,
    ExpiryDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer (ID),
    FOREIGN KEY (PaymentProviderID) REFERENCES PaymentProviders (ID)
);
CREATE TABLE Orders
(
    ID         INTEGER PRIMARY KEY AUTO_INCREMENT,
    CustomerID INTEGER NOT NULL,
    StatusID   INTEGER NOT NULL DEFAULT 1,
    Total      DECIMAL(10, 2) NOT NULL DEFAULT 0.0,
    FOREIGN KEY (CustomerID) REFERENCES Customer (ID),
    FOREIGN KEY (StatusID) REFERENCES Status (ID)
);
CREATE TABLE OrderItems
(
    ID        INTEGER PRIMARY KEY AUTO_INCREMENT,
    OrderID   INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Quantity  INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (OrderID) REFERENCES Orders (ID),
    FOREIGN KEY (ProductID) REFERENCES Product (ID)
);
CREATE TABLE Shipping
(
    ID               INTEGER PRIMARY KEY AUTO_INCREMENT,
    OrderID          INTEGER NOT NULL,
    ShippingMethodID INTEGER NOT NULL,
    ShippingCost     DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders (ID),
    FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethods (ID)
);
CREATE TABLE Payments
(
    ID       INTEGER PRIMARY KEY AUTO_INCREMENT,
    OrderID         INTEGER NOT NULL,
    Amount          DECIMAL(10, 2) NOT NULL,
    PaymentMethodID INTEGER NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders (ID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods (ID)
);


INSERT INTO PaymentProviders (ID, Name, Thumb) VALUES (1, 'Visa','http://localhost:4390/img/Visa.png');
INSERT INTO PaymentProviders (ID, Name, Thumb) VALUES (2, 'Mastercard','http://localhost:4390/img/Mastercard.png');
INSERT INTO PaymentProviders (ID, Name, Thumb) VALUES (3, 'Bitcoin','http://localhost:4390/img/Bitcoin.png');
INSERT INTO PaymentProviders (ID, Name, Thumb) VALUES (4, 'Ethereum','http://localhost:4390/img/Ethereum.png');
INSERT INTO PaymentProviders (ID, Name) VALUES (5, 'Cash on delivery');
INSERT INTO PaymentProviders (ID, Name, Thumb) VALUES (6, 'Litecoin','http://localhost:4390/img/Litecoin.png');
INSERT INTO PaymentProviders (ID, Name, Thumb) VALUES (7, 'PayPal','http://localhost:4390/img/PayPal.png');
INSERT INTO PaymentProviders (ID, Name, Thumb) VALUES (8, 'Monero','http://localhost:4390/img/Monero.png');

INSERT INTO Manufacturer (Name) VALUES ('ElectroParts Inc.');
INSERT INTO Manufacturer (Name) VALUES ('ComponentMakers');
INSERT INTO Manufacturer (Name) VALUES ('TechComponents');
INSERT INTO Manufacturer (Name) VALUES ('ElectroGoods');
INSERT INTO Manufacturer (Name) VALUES ('PartsFactory');
INSERT INTO Manufacturer (Name) VALUES ('TechParts Ltd.');
INSERT INTO Manufacturer (Name) VALUES ('ElectroTech');
INSERT INTO Manufacturer (Name) VALUES ('ComponentPros');
INSERT INTO Manufacturer (Name) VALUES ('TechMakers');

INSERT INTO ShippingMethods (ID, Name, CostModifier, Thumb) VALUES (1, 'FedEx', 0.02, 'http://localhost:4390/img/FedEx.png');
INSERT INTO ShippingMethods (ID, Name, CostModifier, Thumb) VALUES (2, 'UPS', 0.1, 'http://localhost:4390/img/UPS.png');
INSERT INTO ShippingMethods (ID, Name, CostModifier, Thumb) VALUES (3, 'DHL', 0.05, 'http://localhost:4390/img/DHL.png');

INSERT INTO Status (ID, Status) VALUES (1, 'pending');
INSERT INTO Status (ID, Status) VALUES (2, 'ordered');
INSERT INTO Status (ID, Status) VALUES (3, 'cancelled');
INSERT INTO Status (ID, Status) VALUES (4, 'backordered');
INSERT INTO Status (ID, Status) VALUES (5, 'processing');
INSERT INTO Status (ID, Status) VALUES (6, 'shipped');
INSERT INTO Status (ID, Status) VALUES (7, 'on hold');
INSERT INTO Status (ID, Status) VALUES (8, 'delivered');

INSERT INTO Categories (ID, Name) VALUES (1, 'THT');
INSERT INTO Categories (ID, Name) VALUES (2, 'SMD');
INSERT INTO Categories (ID, Name, Thumb) VALUES (3, 'resistor', 'http://localhost:4390/img/resistor.jpeg');
INSERT INTO Categories (ID, Name, Thumb) VALUES (4, 'capacitor', 'http://localhost:4390/img/capacitor.jpeg');
INSERT INTO Categories (ID, Name, Thumb) VALUES (5, 'transistor', 'http://localhost:4390/img/transistor.jpeg');
INSERT INTO Categories (ID, Name, Thumb) VALUES (6, 'diode', 'http://localhost:4390/img/diode.jpeg');
INSERT INTO Categories (ID, Name, Thumb) VALUES (7, 'inductor', 'http://localhost:4390/img/inductor.jpeg');
INSERT INTO Categories (ID, Name, Thumb) VALUES (8, 'IC chip', 'http://localhost:4390/img/IC.jpeg');
INSERT INTO Categories (ID, Name, Thumb) VALUES (9, 'LED', 'http://localhost:4390/img/led.jpeg');
INSERT INTO Categories (ID, Name, Thumb) VALUES (10, 'relay', 'http://localhost:4390/img/relay.jpeg');
INSERT INTO Categories (ID, Name, Thumb) VALUES (11, 'potentiometer', 'http://localhost:4390/img/potentiometer.jpeg');

/*Resistors*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (1, 'EI1234', 7, 'High-precision resistor with 1kΩ resistance, ±0.1% tolerance, 0.125W power rating, 0805 package', 'http://localhost:4390/img/product/EI1234.jpeg', 64.3);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (2, 'CM5678', 1, 'Low-noise resistor with 10kΩ resistance, ±1% tolerance, 0.25W power rating, 1206 package', 'http://localhost:4390/img/product/CM5678.jpeg', 71.42);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (3, 'TC9012', 2, 'High-stability resistor with 100Ω resistance, ±5% tolerance, 0.5W power rating, axial package', 'http://localhost:4390/img/product/TC9012.jpeg', 57.72);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (4, 'EG3456', 5, 'Power resistor with 470Ω resistance, ±2% tolerance, 1W power rating, radial package', 'http://localhost:4390/img/product/EG3456.jpeg', 69.51);
/*Capacitors*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (5, 'PF7890', 1, 'High-capacitance ceramic capacitor with 10µF capacitance, 16V voltage rating, low ESR, 0805 package', 'http://localhost:4390/img/product/PF7890.jpeg', 14.33);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (6, 'TP2345', 7, 'Low-leakage tantalum capacitor with 4.7µF capacitance, 25V voltage rating, high reliability, 1206 package', 'http://localhost:4390/img/product/TP2345.jpeg', 48.62);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (7, 'ET6789', 5, 'High-frequency MLCC capacitor with 1pF capacitance, 50V voltage rating, stable temperature coefficient, 0603 package', 'http://localhost:4390/img/product/ET6789.jpeg', 80.71);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (8, 'CP1234', 3, 'Electrolytic capacitor with 100µF capacitance, 35V voltage rating, long lifespan, radial package', 'http://localhost:4390/img/product/CP1234.jpeg', 31.04);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (9, 'TM5678', 3, 'Polyester film capacitor with 0.1µF capacitance, 63V voltage rating, high stability, axial package', 'http://localhost:4390/img/product/TM5678.jpeg', 20.4);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (10, 'EI0987', 4, 'High-voltage ceramic capacitor with 2.2µF capacitance, 100V voltage rating, low dissipation factor, radial package', 'http://localhost:4390/img/product/EI0987.jpeg', 10.0);
/*Relays*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (11, 'CM6543', 9, 'High-current relay with 10A switching capacity, 12V coil voltage, low power consumption, SOP-16 package', 'http://localhost:4390/img/product/CM6543.jpeg', 67.57);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (12, 'TC2109', 3, 'Compact relay with 5A switching capacity, 24V coil voltage, high reliability, DIP-8 package', 'http://localhost:4390/img/product/TC2109.jpeg', 82.83);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (13, 'EG8765', 4, 'Power relay with 15A switching capacity, 5V coil voltage, long mechanical life, PCB package', 'http://localhost:4390/img/product/EG8765.jpeg', 21.34);
/*Inductors*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (14, 'PF4321', 4, 'High-current inductor with 10A current rating, 1.2µH inductance, low DCR, 2520 package', 'http://localhost:4390/img/product/PF4321.jpeg', 61.07);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (15, 'TP1098', 2, 'Power inductor with 5A current rating, 4.7µH inductance, high efficiency, radial package', 'http://localhost:4390/img/product/TP1098.jpeg', 40.0);
/*LEDs*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (16, 'ET7654', 5, 'High-brightness LED with 20mA forward current, 2.0V forward voltage, 120° viewing angle, PLCC-2 package', 'http://localhost:4390/img/product/ET7654.jpeg', 58.59);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (17, 'CP3210', 3, 'Low-power LED with 10mA forward current, 1.8V forward voltage, 140° viewing angle, SOT-23 package', 'http://localhost:4390/img/product/CP3210.jpeg', 58.13);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (18, 'TM9876', 2, 'High-efficiency LED with 30mA forward current, 2.2V forward voltage, 100° viewing angle, T-1 3/4 package', 'http://localhost:4390/img/product/TM9876.jpeg', 74.05);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (19, 'EI5432', 5, 'Ultra-bright LED with 25mA forward current, 2.1V forward voltage, 160° viewing angle, 5mm package', 'http://localhost:4390/img/product/EI5432.jpeg', 26.5);
/*Potentiometers*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (20, 'CM0987', 1, 'Precision potentiometer with 10kΩ resistance, ±1% tolerance, 0.25W power rating, 3.5mm package', 'http://localhost:4390/img/product/CM0987.jpeg', 66.3);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (21, 'TC6543', 5, 'High-durability potentiometer with 100kΩ resistance, ±5% tolerance, 0.5W power rating, 10.3mm package', 'http://localhost:4390/img/product/TC6543.jpeg', 19.8);
/*Diodes*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (22, 'EG2109', 7, 'High-efficiency Schottky diode with 1A forward current, 40V reverse voltage, low forward voltage drop, SOD-123 package', 'http://localhost:4390/img/product/EG2109.jpeg', 42.22);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (23, 'PF8765', 7, 'Fast recovery diode with 2A forward current, 200V reverse voltage, low leakage current, DO-214AC package', 'http://localhost:4390/img/product/PF8765.jpeg', 36.38);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (24, 'TP4321', 7, 'Zener diode with 5.1V breakdown voltage, 500mW power dissipation, tight tolerance of ±5%, DO-35 package', 'http://localhost:4390/img/product/TP4321.jpeg', 19.33);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (25, 'ET1098', 4, 'High-speed switching diode with 100mA forward current, 75V reverse voltage, low capacitance, DO-41 package', 'http://localhost:4390/img/product/ET1098.jpeg', 38.98);
/*Transistors*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (26, 'CP7654', 8, 'High-gain transistor with 1A collector current, 40V collector-emitter voltage, low saturation voltage, TO-92 package', 'http://localhost:4390/img/product/CP7654.jpeg', 10.61);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (27, 'TM3210', 4, 'Low-noise transistor with 0.5A collector current, 30V collector-emitter voltage, high frequency, TO-220 package', 'http://localhost:4390/img/product/TM3210.jpeg', 12.54);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (28, 'EI9876', 9, 'Power transistor with 10A collector current, 100V collector-emitter voltage, high efficiency, TO-3 package', 'http://localhost:4390/img/product/EI9876.jpeg', 61.72);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (29, 'CM5432', 7, 'Switching transistor with 2A collector current, 60V collector-emitter voltage, fast switching speed, SOT-23 package', 'http://localhost:4390/img/product/CM5432.jpeg', 13.01);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (30, 'TC0987', 6, 'General-purpose transistor with 0.8A collector current, 50V collector-emitter voltage, low power consumption, SOT-223 package', 'http://localhost:4390/img/product/TC0987.jpeg', 75.16);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (31, 'EG6543', 4, 'High-speed transistor with 1.5A collector current, 80V collector-emitter voltage, low capacitance, SOT-89 package', 'http://localhost:4390/img/product/EG6543.jpeg', 20.51);
/*IC*/
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (32, 'PF2109', 1, 'High-speed microcontroller with 128KB Flash memory, 32KB SRAM, operating at 100MHz, QFP-64 package', 'http://localhost:4390/img/product/PF2109.jpeg', 78.33);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (33, 'TP8765', 4, 'Low-power operational amplifier with a supply voltage range of 1.8V to 36V, high input impedance, low offset voltage, SOIC-14 package', 'http://localhost:4390/img/product/TP8765.jpeg', 41.83);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (34, 'ET4321', 1, 'Advanced digital signal processor with 400MHz clock speed, 1MB on-chip memory, integrated peripherals, BGA-256 package', 'http://localhost:4390/img/product/ET4321.jpeg', 13.48);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (35, 'CP1098', 3, 'High-speed USB controller with integrated transceivers, 480Mbps data rate, 32KB FIFO buffer, TQFP-100 package', 'http://localhost:4390/img/product/CP1098.jpeg', 24.9);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (36, 'TM7654', 7, 'Precision voltage regulator with 1.2V to 40V output range, 3A output current, low dropout voltage, TO-220 package', 'http://localhost:4390/img/product/TM7654.jpeg', 48.43);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (37, 'EI3210', 8, 'Versatile analog-to-digital converter with 16-bit resolution, 2MSPS sampling rate, low power consumption, DIP-28 package', 'http://localhost:4390/img/product/EI3210.jpeg', 69.61);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (38, 'CM9876', 3, 'High-performance audio codec with 24-bit resolution, 192kHz sampling rate, integrated headphone amplifier, SIP-16 package', 'http://localhost:4390/img/product/CM9876.jpeg', 57.17);
INSERT INTO Product (ID, Name, ManufacturerID, Description, Thumb, Price) VALUES (39, 'TC5432', 6, 'Robust motor driver IC with 5A output current, wide operating voltage range of 4.5V to 50V, built-in protection features, TO-3 package', 'http://localhost:4390/img/product/TC5432.jpeg', 28.94);

INSERT INTO Inventory (ProductID, Quantity) VALUES (1, 6341);
INSERT INTO Inventory (ProductID, Quantity) VALUES (2, 4551);
INSERT INTO Inventory (ProductID, Quantity) VALUES (3, 8909);
INSERT INTO Inventory (ProductID, Quantity) VALUES (4, 9560);
INSERT INTO Inventory (ProductID, Quantity) VALUES (5, 3278);
INSERT INTO Inventory (ProductID, Quantity) VALUES (6, 770);
INSERT INTO Inventory (ProductID, Quantity) VALUES (7, 4681);
INSERT INTO Inventory (ProductID, Quantity) VALUES (8, 878);
INSERT INTO Inventory (ProductID, Quantity) VALUES (9, 4440);
INSERT INTO Inventory (ProductID, Quantity) VALUES (10, 3508);
INSERT INTO Inventory (ProductID, Quantity) VALUES (11, 1968);
INSERT INTO Inventory (ProductID, Quantity) VALUES (12, 4583);
INSERT INTO Inventory (ProductID, Quantity) VALUES (13, 7982);
INSERT INTO Inventory (ProductID, Quantity) VALUES (14, 8425);
INSERT INTO Inventory (ProductID, Quantity) VALUES (15, 3564);
INSERT INTO Inventory (ProductID, Quantity) VALUES (16, 4669);
INSERT INTO Inventory (ProductID, Quantity) VALUES (17, 1077);
INSERT INTO Inventory (ProductID, Quantity) VALUES (18, 8068);
INSERT INTO Inventory (ProductID, Quantity) VALUES (19, 9559);
INSERT INTO Inventory (ProductID, Quantity) VALUES (20, 4093);
INSERT INTO Inventory (ProductID, Quantity) VALUES (21, 7429);
INSERT INTO Inventory (ProductID, Quantity) VALUES (22, 5164);
INSERT INTO Inventory (ProductID, Quantity) VALUES (23, 180);
INSERT INTO Inventory (ProductID, Quantity) VALUES (24, 5261);
INSERT INTO Inventory (ProductID, Quantity) VALUES (25, 4048);
INSERT INTO Inventory (ProductID, Quantity) VALUES (26, 1172);
INSERT INTO Inventory (ProductID, Quantity) VALUES (27, 9698);
INSERT INTO Inventory (ProductID, Quantity) VALUES (28, 4379);
INSERT INTO Inventory (ProductID, Quantity) VALUES (29, 780);
INSERT INTO Inventory (ProductID, Quantity) VALUES (30, 7831);
INSERT INTO Inventory (ProductID, Quantity) VALUES (31, 6921);
INSERT INTO Inventory (ProductID, Quantity) VALUES (32, 7731);
INSERT INTO Inventory (ProductID, Quantity) VALUES (33, 895);
INSERT INTO Inventory (ProductID, Quantity) VALUES (34, 5235);
INSERT INTO Inventory (ProductID, Quantity) VALUES (35, 3142);
INSERT INTO Inventory (ProductID, Quantity) VALUES (36, 5498);
INSERT INTO Inventory (ProductID, Quantity) VALUES (37, 39);
INSERT INTO Inventory (ProductID, Quantity) VALUES (38, 8651);
INSERT INTO Inventory (ProductID, Quantity) VALUES (39, 2360);

INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (1, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (2, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (3, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (4, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (5, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (6, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (7, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (8, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (9, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (10, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (11, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (12, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (13, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (14, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (15, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (16, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (17, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (18, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (19, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (20, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (21, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (22, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (23, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (24, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (25, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (26, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (27, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (28, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (29, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (30, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (31, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (32, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (33, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (34, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (35, 2);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (36, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (37, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (38, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (39, 1);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (1, 3);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (2, 3);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (3, 3);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (4, 3);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (5, 4);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (6, 4);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (7, 4);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (8, 4);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (9, 4);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (10, 4);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (11, 10);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (12, 10);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (13, 10);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (14, 7);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (15, 7);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (16, 9);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (17, 9);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (18, 9);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (19, 9);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (20, 11);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (21, 11);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (22, 6);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (23, 6);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (24, 6);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (25, 6);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (26, 5);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (27, 5);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (28, 5);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (29, 5);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (30, 5);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (31, 5);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (32, 8);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (33, 8);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (34, 8);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (35, 8);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (36, 8);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (37, 8);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (38, 8);
INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (39, 8);