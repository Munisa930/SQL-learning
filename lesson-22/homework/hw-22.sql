
# Lesson 22: Aggregated Window Functions


```sql
CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')

```



## Easy Questions

1. **Compute Running Total Sales per Customer**
  SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS RunningTotal
FROM sales_data;

2. **Count the Number of Orders per Product Category**
  SELECT 
    product_category,
    COUNT(*) OVER (PARTITION BY product_category) AS OrdersPerCategory,
    product_name
FROM sales_data;

3. **Find the Maximum Total Amount per Product Category**
  SELECT 
    product_category,
    product_name,
    MAX(total_amount) OVER (PARTITION BY product_category) AS MaxAmount
FROM sales_data;

4. **Find the Minimum Price of Products per Product Category**
  SELECT 
    product_category,
    product_name,
    MIN(unit_price) OVER (PARTITION BY product_category) AS MinPrice
FROM sales_data;

5. **Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)**
  SELECT 
    order_date,
    total_amount,
    AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg3Days
FROM sales_data;

6. **Find the Total Sales per Region**
  SELECT 
    region,
    SUM(total_amount) OVER (PARTITION BY region) AS TotalSalesPerRegion
FROM sales_data;

7. **Compute the Rank of Customers Based on Their Total Purchase Amount**
  SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS TotalSpent,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS PurchaseRank
FROM sales_data
GROUP BY customer_id, customer_name;

8. **Calculate the Difference Between Current and Previous Sale Amount per Customer**
  SELECT 
    customer_id,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS DiffPrev
FROM sales_data;

9. **Find the Top 3 Most Expensive Products in Each Category**
  SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS PriceRank
    FROM sales_data
) AS ranked
WHERE PriceRank <= 3;

10. **Compute the Cumulative Sum of Sales Per Region by Order Date**
  SELECT 
    region,
    order_date,
    SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS CumulativeSales
FROM sales_data;

---

## Medium Questions

11. **Compute Cumulative Revenue per Product Category**
  SELECT 
    product_category,
    order_date,
    SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS CumulativeRevenue
FROM sales_data;

12. **Here you need to find out the sum of previous values. Please go through the sample input and expected output.**

**Sample Input**
```
| ID |
|----|
|  1 |
|  2 |
|  3 |
|  4 |
|  5 |
```

**Expected Output**
```
| ID | SumPreValues |
|----|--------------|
|  1 |            1 |
|  2 |            3 |
|  3 |            6 |
|  4 |           10 |
|  5 |           15 |
```
SELECT 
    ID,
    SUM(ID) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM (VALUES (1),(2),(3),(4),(5)) AS t(ID);

13. **Sum of Previous Values to Current Value**

```sql
CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);
```

**Sample Input**
```
| Value |
|-------|
|    10 |
|    20 |
|    30 |
|    40 |
|   100 |
```
**Expected Output**
```
| Value | Sum of Previous |
|-------|-----------------|
|    10 |              10 |
|    20 |              30 |
|    30 |              50 |
|    40 |              70 |
|   100 |             140 |
```
SELECT 
    Value,
    SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;

14. **Find customers who have purchased items from more than one product_category**
  SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;

15. **Find Customers with Above-Average Spending in Their Region**
  SELECT 
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS TotalSpent
FROM sales_data
GROUP BY customer_id, customer_name, region
HAVING SUM(total_amount) > (
    SELECT AVG(SUM(total_amount)) 
    FROM sales_data 
    GROUP BY region
);

16. **Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank.**
  SELECT 
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS TotalSpent,
    RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS RegionRank
FROM sales_data
GROUP BY customer_id, customer_name, region;

17. **Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.**
  SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS CumulativeSales
FROM sales_data;

18. **Calculate the sales growth rate (growth_rate) for each month compared to the previous month.**
  SELECT 
    FORMAT(order_date, 'yyyy-MM') AS Month,
    SUM(total_amount) AS MonthlySales,
    LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) AS PrevMonthSales,
    (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')))
        * 100.0 / LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) AS GrowthRate
FROM sales_data
GROUP BY FORMAT(order_date, 'yyyy-MM');

19. **Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)**
  SELECT 
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS PrevOrder,
    CASE 
        WHEN total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) 
        THEN 'Increased'
        ELSE 'Not Increased'
    END AS Status
FROM sales_data;

---

## Hard Questions

20. **Identify Products that prices are above the average product price**
  SELECT 
    product_name,
    product_category,
    unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);

21. **In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. The challenge here is to do this in a single select. For more details please see the sample input and expected output.**

```sql
CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);
```

**Sample Input**
```
| Id  | Grp | Val1 | Val2 |  
|-----|-----|------|------|  
|  1  |  1  |   30 |   29 |  
|  2  |  1  |   19 |    0 |  
|  3  |  1  |   11 |   45 |  
|  4  |  2  |    0 |    0 |  
|  5  |  2  |  100 |   17 |
```


**Expected Output**
```
| Id | Grp | Val1 | Val2 | Tot  |
|----|-----|------|------|------|
| 1  | 1   | 30   | 29   | 134  |
| 2  | 1   | 19   | 0    | NULL |
| 3  | 1   | 11   | 45   | NULL |
| 4  | 2   | 0    | 0    | 117  |
| 5  | 2   | 100  | 17   | NULL |
```
SELECT 
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
    END AS Tot
FROM MyData;

22. **Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details.**

```sql
CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);
```

**Sample Input**
```
| Id   | Cost | Quantity |  
|------|------|----------|  
| 1234 |   12 |      164 |  
| 1234 |   13 |      164 |  
| 1235 |  100 |      130 |  
| 1235 |  100 |      135 |  
| 1236 |   12 |      136 | 
```

**Expected Output**
```
| Id   | Cost | Quantity |
|------|------|----------|
| 1234 | 25   | 164      |
| 1235 | 200  | 265      |
| 1236 | 12   | 136      |
```
SELECT 
    ID,
    SUM(Cost) AS Cost,
    SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;

23. **From following set of integers, write an SQL statement to determine the expected outputs**

```sql
CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 
```

**Output:**
```
---------------------
|Gap Start	|Gap End|
---------------------
|     1     |	6	|
|     8     |	12	|
|     16    |	26	|
|     36    |	51	|
---------------------
```
WITH Numbered AS (
    SELECT 
        SeatNumber,
        ROW_NUMBER() OVER (ORDER BY SeatNumber) AS rn
    FROM Seats
),
Groups AS (
    SELECT 
        SeatNumber,
        SeatNumber - rn AS grp
    FROM Numbered
)
SELECT 
    MIN(SeatNumber) + 1 AS [Gap Start],
    MAX(SeatNumber) - 1 AS [Gap End]
FROM Groups
GROUP BY grp
HAVING MIN(SeatNumber) <> (SELECT MIN(SeatNumber) FROM Seats)
   OR MAX(SeatNumber) <> (SELECT MAX(SeatNumber) FROM Seats);
