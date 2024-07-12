CREATE DATABASE Salesdb;
USE Salesdb;

CREATE TABLE productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(4000),
    htmlDescription MEDIUMTEXT,
    image MEDIUMBLOB
);

CREATE TABLE products (
    productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70) NOT NULL,
    productLine VARCHAR(50),
    productScale VARCHAR(10) NOT NULL,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT NOT NULL,
    quantityInStock SMALLINT NOT NULL,
    buyPrice DECIMAL(10,2) NOT NULL,
    MSRP DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

CREATE TABLE offices (
    officeCode VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    territory VARCHAR(10) NOT NULL
);

CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    officeCode VARCHAR(10),
    reportsTo INT,
    jobTitle VARCHAR(50) NOT NULL,
    FOREIGN KEY (officeCode) REFERENCES offices(officeCode),
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber)
);

CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50) NOT NULL,
    salesRepEmployeeNumber INT,
    creditLimit DECIMAL(10,2),
    FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE NOT NULL,
    requiredDate DATE NOT NULL,
    shippedDate DATE,
    status VARCHAR(15) NOT NULL,
    comments TEXT,
    customerNumber INT,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

CREATE TABLE orderdetails (
    orderNumber INT,
    productCode VARCHAR(15),
    quantityOrdered INT NOT NULL,
    priceEach DECIMAL(10,2) NOT NULL,
    orderLineNumber SMALLINT NOT NULL,
    PRIMARY KEY (orderNumber, productCode),
    FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
);

CREATE TABLE payments (
    customerNumber INT,
    checkNumber VARCHAR(50) PRIMARY KEY,
    paymentDate DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

INSERT INTO productlines (productLine, textDescription, htmlDescription, image) VALUES
('Classic Cars', 'Cars from the 1950s and 1960s', NULL, NULL),
('Motorcycles', 'A range of motorcycles', NULL, NULL),
('Planes', 'Various airplane models', NULL, NULL),
('Ships', 'Models of ships', NULL, NULL),
('Trains', 'Collection of train models', NULL, NULL);

INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP) VALUES
('S10_1678', '1969 Harley Davidson Ultimate Chopper', 'Motorcycles', '1:10', 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever.', 7933, 48.81, 95.70),
('S10_1949', '1952 Alpine Renault 1300', 'Classic Cars', '1:10', 'Classic Metal Creations', 'Turnable front wheels; steering function.', 7305, 98.58, 214.30),
('S18_3232', '1980s Black Hawk Helicopter', 'Planes', '1:18', 'Diecast Classics Inc.', 'Authentic helicopter model.', 720, 68.34, 140.50),
('S24_3949', '1957 Vespa GS150', 'Motorcycles', '1:24', 'Classic Metal Creations', 'Detailed Vespa model with accurate features.', 6540, 44.20, 83.20),
('S50_1392', '1969 Dodge Charger', 'Classic Cars', '1:50', 'Highway 66 Mini Classics', 'Detailed Dodge Charger model.', 2782, 55.70, 135.95);

INSERT INTO offices (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory) VALUES
('1', 'San Francisco', '+1 650 219 4782', '100 Market Street', 'Suite 300', 'CA', 'USA', '94080', 'NA'),
('2', 'Boston', '+1 617 219 4782', '1550 Liberty Street', 'Suite 1100', 'MA', 'USA', '02210', 'NA'),
('3', 'NYC', '+1 212 555 3000', '300 Madison Ave', NULL, 'NY', 'USA', '10017', 'NA'),
('4', 'Paris', '+33 1 47 55 60 60', '43 Rue Jouffroy', NULL, NULL, 'France', '75017', 'EMEA'),
('5', 'Tokyo', '+81 3 3546 7000', '1-6-1 Roppongi', 'Minato-ku', NULL, 'Japan', '106-0032', 'Japan');

-- Insert sample data into employees
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) VALUES
(1002, 'Murphy', 'Diane', 'x5800', 'dmurphy@classicmodelcars.com', '1', NULL, 'President'),
(1056, 'Patterson', 'Mary', 'x4611', 'mpatter@classicmodelcars.com', '1', 1002, 'VP Sales'),
(1076, 'Firrelli', 'Jeff', 'x9273', 'jfirrelli@classicmodelcars.com', '1', 1002, 'VP Marketing'),
(1088, 'Patterson', 'William', 'x4871', 'wpatterso@classicmodelcars.com', '1', 1056, 'Sales Manager (APAC)'),
(1102, 'Bondur', 'Gerard', 'x5408', 'gbondur@classicmodelcars.com', '1', 1056, 'Sale Manager (EMEA)');

INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit) VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale', NULL, 'Nantes', NULL, '44000', 'France', 1102, 21000.00),
(112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.', NULL, 'Las Vegas', 'NV', '83030', 'USA', 1056, 71800.00),
(114, 'Australian Collectors, Co.', 'Ferguson', 'Peter', '03 9520 4555', '636 St Kilda Road', 'Level 3', 'Melbourne', 'Victoria', '3004', 'Australia', 1088, 117300.00),
(119, 'La Rochelle Gifts', 'Labrune', 'Janine', '32.65.2655', '67, avenue de l''Europe', NULL, 'Paris', NULL, '75000', 'France', 1102, 118200.00),
(121, 'Baane Mini Imports', 'Bergulfsen', 'Jonas', '07-98 9555', 'Erling Skakkes gate 78', NULL, 'Stavern', NULL, '4110', 'Norway', 1102, 81700.00);

INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber) VALUES
(10100, '2003-01-06', '2003-01-13', '2003-01-10', 'Shipped', NULL, 103),
(10101, '2003-01-09', '2003-01-18', '2003-01-11', 'Shipped', 'Check on availability.', 112),
(10102, '2003-01-10', '2003-01-18', '2003-01-14', 'Shipped', NULL, 114),
(10103, '2003-01-29', '2003-02-07', '2003-01-31', 'Shipped', NULL, 119),
(10104, '2003-01-31', '2003-02-10', '2003-02-02', 'Shipped', NULL, 121);

INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber) VALUES
(10100, 'S10_1678', 30, 95.70, 1),
(10100, 'S10_1949', 50, 98.58, 2),
(10101, 'S18_3232', 22, 68.34, 1),
(10102, 'S24_3949', 49, 44.20, 1),
(10103, 'S50_1392', 24, 55.70, 1);

INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount) VALUES
(103, 'HQ336336', '2004-10-19', 6066.78),
(112, 'JM555205', '2004-10-26', 8141.88),
(114, 'AB438251', '2004-10-19', 9786.66),
(119, 'MO387274', '2004-11-19', 7220.00),
(121, 'AL389287', '2004-11-19', 14571.44);
