-- Creating a new database called salesDB
CREATE DATABASE salesDB;
-- Dropping (deleting) the database called demo
DROP DATABASE demo;
-- Query to retrieve checkNumber, paymentDate, and amount from the payments table
SELECT checkNumber, paymentDate, amount
FROM payments;
-- Query to retrieve orderDate, requiredDate, and status of orders that are 'In Process'
SELECT orderDate, requiredDate, status
FROM orders
WHERE status = 'In Process'
ORDER BY orderDate DESC;
-- Query to display firstName, lastName, and email of employees with the job title 'Sales Rep'
SELECT firstName, lastName, email
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY employeeNumber DESC;
-- Query to retrieve all columns and records from the offices table
SELECT * 
FROM offices;
-- Query to fetch productName and quantityInStock, sorted by buyPrice, limiting to 5 records
SELECT productName, quantityInStock
FROM products
ORDER BY buyPrice ASC
LIMIT 5;

-- SQL statement to create a table named student
CREATE TABLE student (
    id INT PRIMARY KEY,            -- ID column, integer, primary key
    fullName VARCHAR(100),         -- fullName column, text field with a maximum of 100 characters
    age INT                        -- age column, integer
);
-- SQL statement to insert 3 records into the student table
INSERT INTO student (id, fullName, age) 
VALUES 
(1, 'John Doe', 18),
(2, 'Jane Smith', 19),
(3, 'Sam Brown', 21);
-- SQL statement to update the age of the student with ID 2 to 20
UPDATE student
SET age = 20
WHERE id = 2;

SELECT paymentDate, SUM(amount) AS total_amount
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate DESC
LIMIT 5;

SELECT customerName, country, AVG(creditLimit) AS avg_credit_limit
FROM customers
GROUP BY customerName, country;

SELECT productCode, quantityOrdered, SUM(priceEach * quantityOrdered) AS total_price
FROM orderdetails
GROUP BY productCode, quantityOrdered;

SELECT checkNumber, MAX(amount) AS highest_payment
FROM payments
GROUP BY checkNumber;

-- Dropping the index IdxPhone from the customers table
DROP INDEX IdxPhone ON customers;
-- Creating a user 'bob' with a password, restricted to localhost
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'S$cu3r3!';
-- Granting INSERT privilege to the user 'bob' on the salesDB database
GRANT INSERT ON salesDB.* TO 'bob'@'localhost';
-- Changing the password for the user 'bob' to 'P$55!23'
ALTER USER 'bob'@'localhost' IDENTIFIED BY 'P$55!23';


-- Query to get employee details along with their office code using INNER JOIN
SELECT 
    e.firstName, 
    e.lastName, 
    e.email, 
    e.officeCode
FROM 
    employees e
INNER JOIN 
    offices o ON e.officeCode = o.officeCode;
-- Query to get product details along with product line and vendor using LEFT JOIN
SELECT 
    p.productName, 
    p.productVendor, 
    p.productLine
FROM 
    products p
LEFT JOIN 
    productlines pl ON p.productLine = pl.productLine;
-- Query to get order details for the first 10 orders using RIGHT JOIN
SELECT 
    o.orderDate, 
    o.shippedDate, 
    o.status, 
    o.customerNumber
FROM 
    customers c
RIGHT JOIN 
    orders o ON c.customerNumber = o.customerNumber
LIMIT 10;


-- Create the normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert normalized data
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert into Orders
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert into OrderDetails
INSERT INTO OrderDetails (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
