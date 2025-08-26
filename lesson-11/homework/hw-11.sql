Easy-Level (7)
  
1. Orders after 2022 + customer name
SELECT o.OrderID,
       c.FirstName + ' ' + c.LastName AS CustomerName,
       o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '2022-12-31';

2. Employees in Sales or Marketing
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales','Marketing');

3. Max salary per department
SELECT d.DepartmentName,
       MAX(e.Salary) AS MaxSalary
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

4. USA customers with orders in 2023
SELECT c.FirstName + ' ' + c.LastName AS CustomerName,
       o.OrderID,
       o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 2023;

5. Customer + total orders
SELECT c.FirstName + ' ' + c.LastName AS CustomerName,
       COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

6. Products from Gadget Supplies or Clothing Mart
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies','Clothing Mart');

7. Most recent order per customer
SELECT c.FirstName + ' ' + c.LastName AS CustomerName,
       MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

 Medium-Level (6)
1. Customers with orders > 500
SELECT c.FirstName + ' ' + c.LastName AS CustomerName,
       o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;

2. Sales in 2022 or amount > 400
SELECT p.ProductName, s.SaleDate, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;

3. Product + total sales amount
SELECT p.ProductName,
       SUM(s.SaleAmount) AS TotalSalesAmount
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;

4. HR employees with salary > 60000
SELECT e.Name AS EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources' AND e.Salary > 60000;

5. Products sold in 2023 with stock > 100
SELECT p.ProductName, s.SaleDate, p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100;

6. Sales dept employees OR hired after 2020
SELECT e.Name AS EmployeeName, d.DepartmentName, e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR e.HireDate > '2020-12-31';

 Hard-Level (6)
1. USA customers with address starting with 4 digits
SELECT c.FirstName + ' ' + c.LastName AS CustomerName,
       o.OrderID, c.Address, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';

2. Electronics OR sales > 350
SELECT p.ProductName, p.Category, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE p.Category = 'Electronics' OR s.SaleAmount > 350;

3. Count of products per category
SELECT c.Category AS CategoryName,
       COUNT(p.ProductID) AS ProductCount
FROM Products p
JOIN (SELECT DISTINCT Category FROM Products) c ON p.Category = c.Category
GROUP BY c.Category;

4. LA customers + orders > 300
SELECT c.FirstName + ' ' + c.LastName AS CustomerName,
       c.City, o.OrderID, o.TotalAmount AS Amount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300;

5. HR or Finance employees OR name with ≥4 vowels
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Human Resources','Finance')
   OR (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'a',''))
      + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'e',''))
      + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'i',''))
      + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'o',''))
      + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name),'u',''))) >= 4;

6. Sales/Marketing employees with salary > 60000
SELECT e.Name AS EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales','Marketing') AND e.Salary > 60000;
