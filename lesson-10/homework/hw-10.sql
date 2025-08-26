Easy-Level Answers (10)
  
1. Employees – 50k dan katta oylik
SELECT e.Name AS EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000;

2. Customers – 2023-yildagi buyurtmalar
SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;

3. Employees – hamma xodimlar (departament bo‘lmasa ham)
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

4. Suppliers – hamma ta’minotchilar (mahsulotsiz ham)
SELECT s.SupplierName, p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID;

5. Orders & Payments – hamma buyurtmalar va to‘lovlar
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o
FULL OUTER JOIN Payments p ON o.OrderID = p.OrderID;

6. Employees – manageri bilan
SELECT e.Name AS EmployeeName, m.Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

7. Students – Math 101 kursidagilar
SELECT s.StudentName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';

8. Customers – 3 tadan ortiq buyurtma qilgan
SELECT c.FirstName, c.LastName, o.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;

9. Employees – Human Resources bo‘limidagilar
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';

10.Hamma Customers va Orders (hatto buyurtmasizlar ham)
SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

 Medium-Level Answers (9)
   
1. Departments – 5 tadan ortiq xodim
SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 5;

2. Products – hech qachon sotilmagan
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SaleID IS NULL;

3. Customers – kamida 1 ta buyurtma qilgan
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

4. Employees & Departments – faqat mavjudlari (NULLsiz)
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

5. Employees – bir xil managerga ishlovchilar
SELECT e1.Name AS Employee1, e2.Name AS Employee2, e1.ManagerID
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID;

6. Orders – 2022-yildagi buyurtmalar va mijozlar
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

7. Employees – Sales bo‘limida, 60k+ oylik
SELECT e.Name AS EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' AND e.Salary > 60000;

8. Orders – faqat to‘lov bilan
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID;

9. Products – hech qachon buyurtma qilinmagan
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;

Hard-Level Answers (9)
  
1. Employees – o‘z bo‘limi o‘rtacha oyligidan ko‘p oladiganlar
SELECT e.Name AS EmployeeName, e.Salary
FROM Employees e
JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > d.AvgSalary;

2. Orders – 2020 dan oldin, to‘lovsiz
SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL AND o.OrderDate < '2020-01-01';

3. Products – kategoriyasiz
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL;

4. Employees – bir xil manager + 60k dan katta
SELECT e1.Name AS Employee1, e2.Name AS Employee2, e1.ManagerID, e1.Salary
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID AND e1.Salary > 60000 AND e2.Salary > 60000;

5. Employees – bo‘limi “M” harfi bilan boshlanadigan
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

6. Sales – summasi 500 dan katta
SELECT s.SaleID, p.ProductName, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 500;

7. Students – Math 101 ga yozilmaganlar
SELECT s.StudentID, s.StudentName
FROM Students s
WHERE s.StudentID NOT IN (
    SELECT e.StudentID
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE c.CourseName = 'Math 101'
);

8. Orders – to‘lovsiz
SELECT o.OrderID, o.OrderDate, p.PaymentID
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

9. Products – Electronics yoki Furniture kategoriyasi
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');
