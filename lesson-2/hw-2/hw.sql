Lesson 2: DDL and DML Commands
Notes before doing the tasks:
All tasks should be performed using SQL Server.

-Case sensitivity does not apply.
-Alias names do not affect the result.
-Correct output determines the score.
-One correct solution is enough.
Basic-Level Tasks (10)
1.Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(100), Category VARCHAR(50), Price DECIMAL(10,2) CHECK (Price > 0), Description VARCHAR(200))
2.Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
-- 1-usul: 
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali Karimov', 6000.00)
-- 2-usul: 
INSERT INTO Employees VALUES (2, 'Dilshod Usmonov', 4500.00)
-- 3-usul: ko‘p qatorda kiritish
INSERT INTO Employees (EmpID, Name, Salary) VALUES (3, 'Gulnoza Azizova', 5200.00);
3.Update the Salary of an employee to 7000 where EmpID = 1.
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;
4.Delete a record from the Employees table where EmpID = 2.
DELETE FROM Employees
WHERE EmpID = 2;
5.Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
- DELETE: Jadvaldagi ma’lumotlarni o‘chiradi, lekin strukturani saqlaydi. WHERE bilan ishlaydi.
- TRUNCATE: Barcha ma’lumotlarni o‘chiradi, lekin strukturani saqlaydi. Tezroq, lekin WHERE ishlamaydi.
- DROP: Jadvalni butunlay o‘chiradi (strukturasi bilan birga).
6.Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);
7.Add a new column Department (VARCHAR(50)) to the Employees table.
ALTER TABLE Employees
ADD Department VARCHAR(50);
8.Change the data type of the Salary column to FLOAT.
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;
9.Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50));
10.Remove all records from the Employees table without deleting its structure.
TRUNCATE TABLE Employees;
Intermediate-Level Tasks (6)
11.Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'Boshqaruv' UNION ALL
SELECT 2, 'Moliya' UNION ALL
SELECT 3, 'IT' UNION ALL
SELECT 4, 'Marketing' UNION ALL
SELECT 5, 'HR';
12.Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;
13.Write a query that removes all employees but keeps the table structure intact.
TRUNCATE TABLE Employees;
14.Drop the Department column from the Employees table.
ALTER TABLE Employees
DROP COLUMN Department;
15.Rename the Employees table to StaffMembers using SQL commands.
EXEC sp_rename 'Employees', 'StaffMembers';
16.Write a query to completely remove the Departments table from the database.
DROP TABLE Departments;
Advanced-Level Tasks (9)
17.Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(100), Category VARCHAR(50), Price DECIMAL(10,2) CHECK (Price >0), Description VARCHAR(200));
18.Add a CHECK constraint to ensure Price is always greater than 0.
19.Modify the table to add a StockQuantity column with a DEFAULT value of 50.
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;
20.Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';
21.Insert 5 records into the Products table using standard INSERT INTO queries.
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES 
(1, 'Laptop', 'Electronics', 1200.00, 'HP Laptop'),
(2, 'Mouse', 'Electronics', 20.50, 'Wireless Mouse'),
(3, 'Chair', 'Furniture', 85.99, 'Office Chair'),
(4, 'Notebook', 'Stationery', 2.00, 'A5 Notebook'),
(5, 'Backpack', 'Bags', 35.00, 'Travel Backpack');
22.Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT * INTO Products_Backup
FROM Products;
23.Rename the Products table to Inventory.
EXEC sp_rename 'Products', 'Inventory';
24.Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
25.Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.
-- 1. Yangi jadval bilan nusxa olish
SELECT 
    IDENTITY(INT, 1000, 5) AS ProductCode,
    ProductID, ProductName, ProductCategory, Price, Description, StockQuantity
INTO Inventory_New
FROM Inventory;
-- 2. Eski jadvalni o‘chirish (agar kerak bo‘lsa):
-- DROP TABLE Inventory;
-- 3. Yangi jadvalni qayta nomlash:
-- EXEC sp_rename 'Inventory_New', 'Inventory';
