Lesson 3: Importing and Exporting Data
✅ Importing Data (BULK INSERT, Excel, Text) 
✅ Exporting Data (Excel, Text) 
✅ Comments, Identity column, NULL/NOT NULL values 
✅ Unique Key, Primary Key, Foreign Key, Check Constraint 
✅ Differences between UNIQUE KEY and PRIMARY KEY

Notes before doing the tasks:
-Tasks should be solved using SQL Server.
-Case insensitivity applies.
-Alias names do not affect the score.
-Scoring is based on the correct output.
-One correct solution is sufficient.

Easy-Level Tasks (10)
1. Define and explain the purpose of BULK INSERT in SQL Server
BULK INSERT is a command in SQL Server that allows you to import a large amount of data from a data file (like .txt or .csv) directly into a SQL Server table.
Purpose: It's used for fast and efficient data import, especially useful for big datasets.
BULK INSERT Products
FROM 'C:\Data\products.csv' WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2)
2. List four file formats that can be imported into SQL Server
CSV – Comma Separated Values
TXT – Plain text files
XML – Extensible Markup Language
JSON – JavaScript Object Notation
3. Create a table Products
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10, 2))
4. Insert three records into the Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (1, 'Laptop', 999.99), (2, 'Mouse', 25.50), (3, 'Keyboard', 45.00);
5. Explain the difference between NULL and NOT NULL
NULL means the value is unknown, missing, or not applicable. It allows the column to remain empty.
NOT NULL means the column must have a value and cannot be left empty.
6. Add a UNIQUE constraint to the ProductName column
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
7. Write a comment in a SQL query explaining its purpose
-- This query inserts a new product into the Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (4, 'Monitor', 150.00);
8. Add CategoryID column to the Products table
ALTER TABLE Products
ADD CategoryID INT;
9. Create Categories table with constraints
CREATE TABLE Categories (CategoryID INT PRIMARY KEY, CategoryName VARCHAR(50) UNIQUE);
10. Explain the purpose of the IDENTITY column in SQL Server
The IDENTITY column in SQL Server is used to automatically generate unique values for a column, usually for primary keys.
You define a starting value and an increment. For example:
CREATE TABLE Orders (OrderID INT IDENTITY(1,1) PRIMARY KEY,OrderDate DATE);

Medium-Level Tasks (10)
11. Use BULK INSERT to import data from a text file into the Products table
BULK INSERT Products
FROM 'C:\Data\products.txt' -- full path to your file
WITH (FIELDTERMINATOR = ',', -- assuming it's a CSV ROWTERMINATOR = '\n', FIRSTROW = 2 -- if the first row contains headers);
Make sure SQL Server has access to the file location, and the file format matches the table structure.
12. Create a FOREIGN KEY in the Products table that references the Categories table
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);
This ensures that any CategoryID entered into Products must already exist in the Categories table.
13. Explain the differences between PRIMARY KEY and UNIQUE KEY
Feature	PRIMARY KEY	UNIQUE KEY
Uniqueness	Must be unique	Must be unique
NULLs	Cannot contain NULL	Can contain one NULL value (in most DBs)
Number per table	Only one PRIMARY KEY per table	Can have multiple UNIQUE keys
Main purpose	Identifies each row uniquely	Enforces uniqueness on one or more columns
14. Add a CHECK constraint to the Products table ensuring Price > 0
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive
CHECK (Price > 0);
This prevents inserting or updating records where Price is less than or equal to 0.
15. Modify the Products table to add a column Stock (INT, NOT NULL)
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;
Since it’s NOT NULL, we provide a DEFAULT value to avoid errors on existing rows.
16. Use the ISNULL function to replace NULL values in Price column with a 0
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price, Stock FROM Products; ISNULL(Price, 0) will display 0 instead of NULL when the Price is missing.
17. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server
A FOREIGN KEY is used to enforce referential integrity between two related tables.
It ensures that the value in a column (or group of columns) in one table matches a value in the PRIMARY KEY or UNIQUE column in another table.
Example use case: A product belongs to a category → the CategoryID in Products must exist in Categories.
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
This prevents "orphaned" data — e.g., a product assigned to a non-existent category.
Hard-Level Tasks (10)
18.Create a Customers table with a CHECK constraint ensuring Age >= 18
CREATE TABLE Customers (CustomerID INT PRIMARY KEY, CustomerName VARCHAR(100), Age INT, CONSTRAINT CHK_Customer_Age CHECK (Age >= 18));
This ensures that no customer younger than 18 can be inserted into the table.
19.Create a table with an IDENTITY column starting at 100 and incrementing by 10
CREATE TABLE Invoices (InvoiceID INT IDENTITY(100, 10) PRIMARY KEY, InvoiceDate DATE, TotalAmount DECIMAL(10, 2));
Each new InvoiceID will be 100, 110, 120, etc.
20.Create a composite PRIMARY KEY in a new table OrderDetails
CREATE TABLE OrderDetails (OrderID INT, ProductID INT, Quantity INT, Price DECIMAL(10,2), CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID));
This ensures that each combination of OrderID and ProductID is unique (i.e., no duplicate product per order).
21.Explain the use of COALESCE and ISNULL for handling NULL values
Function	Description
ISNULL(a, b)	Returns a if it's not NULL, otherwise returns b. Only 2 arguments.
COALESCE(a, b, c, ...)	Returns the first non-NULL value in the list. Can take multiple arguments.
Examples:
-- ISNULL
SELECT ISNULL(Price, 0) AS SafePrice FROM Products;
-- COALESCE (more flexible)
SELECT COALESCE(DiscountPrice, SalePrice, 0) AS FinalPrice FROM Products;
22.Create a table Employees with PRIMARY KEY on EmpID and UNIQUE key on Email
CREATE TABLE Employees (EmpID INT PRIMARY KEY, FullName VARCHAR(100), Email VARCHAR(100) UNIQUE);
This ensures each employee has a unique ID and no duplicate email addresses.
23.Create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE
CREATE TABLE Orders (OrderID INT PRIMARY KEY, CustomerID INT, OrderDate DATE, CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) 
REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE);
This means:
If a customer is deleted, their orders are also deleted.
If a customer's ID is updated, it will automatically update in the Orders table too.
