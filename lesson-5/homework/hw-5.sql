All the Tasks should be solved using/in MSSQL-SERVER.

✅ Aliases 
✅ UNION, UNION ALL, INTERSECT, EXCEPT 
✅ Creating Conditional Columns with CASE and IIF 
✅ Using IF, WHILE

Notes before doing the tasks:
-Tasks should be solved using SQL Server.
-Case insensitivity applies.
-Alias names do not affect the score.
-Scoring is based on the correct output.
-One correct solution is sufficient.

Easy-Level Tasks
1.Write a query that uses an alias to rename the ProductName column as Name in the Products table.
SELECT TOP 5 * FROM Employees;

2.Write a query that uses an alias to rename the Customers table as Client for easier reference.
SELECT DISTINCT Category FROM Products;

3.Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
SELECT * FROM Products WHERE Price > 100;

4.Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
SELECT * FROM Customers WHERE FirstName LIKE 'A%';

5.Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT SELECT * FROM Products
ORDER BY Price ASC;

6.Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
SELECT * FROM Products
WHERE Price > 50;

7.Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
SELECT *, IIF(StockQuantity > 100, 'Yes', 'No') AS StockOver100
FROM Products_Discounted;

Medium-Level Tasks
8.Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted tables.
SELECT ProductName
FROM Products
UNION
SELECT ProductName
FROM Products_Discounted;

9.Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
SELECT ProductName
FROM Products
EXCEPT
SELECT ProductName
FROM Products_Discounted;

10.Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
SELECT 
    ProductName,
    IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

11.Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
SELECT *
FROM Employees
WHERE Age < 25 
   OR Salary > 60000;

12.Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR' 
   OR EmpID = 5;

Hard-Level Tasks
13.Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
SELECT 
    SaleID,
    SaleAmount,
    CASE 
        WHEN SaleAmount > 500 THEN 'Top Tier'
        WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
        ELSE 'Low Tier'
    END AS SaleTier
FROM Sales;
14.Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Sales table.
SELECT CustomerID
FROM Orders
EXCEPT
SELECT CustomerID
FROM Sales;
15.Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%
SELECT 
    CustomerID,
    Quantity,
    CASE 
        WHEN Quantity = 1 THEN '3%'
        WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
        ELSE '7%'
    END AS DiscountPercentage
FROM Orders;
