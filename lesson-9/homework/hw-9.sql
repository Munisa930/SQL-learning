Easy-Level (10)
-- 1. Products × Suppliers (Cartesian)
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;

-- 2. Departments × Employees (Cartesian)
SELECT d.DepartmentName, e.EmployeeName
FROM Departments d
CROSS JOIN Employees e;

-- 3. Suppliers supplying products (inner join)
SELECT s.SupplierName, p.ProductName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;

-- 4. Customers and Orders
SELECT c.CustomerName, o.OrderID
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 5. Students × Courses (Cartesian)
SELECT st.StudentName, c.CourseName
FROM Students st
CROSS JOIN Courses c;

-- 6. Products and Orders where ProductIDs match
SELECT p.ProductName, o.OrderID
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

-- 7. Employees with their department
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 8. Students and their enrolled course IDs
SELECT st.StudentName, en.CourseID
FROM Students st
INNER JOIN Enrollments en ON st.StudentID = en.StudentID;

-- 9. Payments and Orders (matching ones)
SELECT p.PaymentID, o.OrderID
FROM Payments p
INNER JOIN Orders o ON p.OrderID = o.OrderID;

-- 10. Orders and Products where product price > 100
SELECT o.OrderID, p.ProductName, p.Price
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100;

🟡 Medium-Level (10)
-- 11. Employee-Department mismatched combinations
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID <> d.DepartmentID;

-- 12. Orders vs Products where ordered qty > stock qty
SELECT o.OrderID, p.ProductName, o.Quantity, p.StockQty
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQty;

-- 13. Customers and product IDs where sale ≥ 500
SELECT c.CustomerName, s.ProductID, s.SaleAmount
FROM Customers c
INNER JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleAmount >= 500;

-- 14. Students and course names they’re enrolled in
SELECT st.StudentName, c.CourseName
FROM Enrollments e
INNER JOIN Students st ON e.StudentID = st.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

-- 15. Products & suppliers where supplier name contains "Tech"
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%';

-- 16. Orders vs Payments where payment < total
SELECT o.OrderID, o.TotalAmount, p.PaymentAmount
FROM Orders o
INNER JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentAmount < o.TotalAmount;

-- 17. Employees with their department name
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 18. Products in Electronics or Furniture
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

-- 19. Sales from USA customers
SELECT s.SaleID, c.CustomerName, s.ProductID
FROM Sales s
INNER JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

-- 20. Orders by German customers with total > 100
SELECT o.OrderID, c.CustomerName, o.TotalAmount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount > 100;

🔴 Hard-Level (5)
-- 21. Pairs of employees from different departments
SELECT e1.EmployeeName AS Emp1, e2.EmployeeName AS Emp2
FROM Employees e1
INNER JOIN Employees e2 ON e1.EmployeeID < e2.EmployeeID
WHERE e1.DepartmentID <> e2.DepartmentID;

-- 22. Payments where paid ≠ (Quantity × Product Price)
SELECT p.PaymentID, o.OrderID, p.PaymentAmount, (o.Quantity * pr.Price) AS ExpectedAmount
FROM Payments p
INNER JOIN Orders o ON p.OrderID = o.OrderID
INNER JOIN Products pr ON o.ProductID = pr.ProductID
WHERE p.PaymentAmount <> (o.Quantity * pr.Price);
-- 23. Students not enrolled in any course
SELECT s.StudentID, s.StudentName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IS NULL;

-- 24. Managers earning ≤ person they manage
SELECT m.EmployeeName AS Manager, e.EmployeeName AS Employee, m.Salary AS ManagerSalary, e.Salary AS EmployeeSalary
FROM Employees e
INNER JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE m.Salary <= e.Salary;

-- 25. Customers with orders but no payment
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;
