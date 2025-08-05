Lesson 1: Introduction to SQL Server and SSMS
Notes before doing the tasks:
Tasks should be solved using SQL Server.
Case insensitivity applies.
Alias names do not affect the score.
Scoring is based on the correct output.
One correct solution is sufficient.
 Easy
1. Define the following terms:
Data: Any facts, numbers, text, symbols, etc. Example: “Ali”, 25, “Tashkent”.
Database: A structured collection of data that can be stored, managed, and processed. SQL Server is a database management system.
Relational Database: A database that stores data in related tables using keys (e.g., primary key, foreign key).
Table: A structure that stores data in rows and columns.
2. List five key features of SQL Server:
Relational Database – data is stored in related tables.
Stored Procedures & Triggers – used for business logic automation.
Security – supports authentication, permissions, and encryption.
Backup and Restore – ability to save and recover data.
Integration Services – supports ETL (Extract, Transform, Load) processes.
3. What are the different authentication modes in SQL Server? (At least 2)
Windows Authentication – uses the Windows account to connect.
SQL Server Authentication – uses a login and password defined within SQL Server.
Medium
4. Create a new database in SSMS named SchoolDB.
5. CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT)
insert into Students values (137378494, 'John', 6), (212345, 'Jack', 5)
select * from Students
6. Explain the differences between SQL Server, SSMS, and SQL:
SQL Server. A server-based software system designed to store and manage databases. It physically stores data and provides tools to work with it.
SSMS (SQL Server Management Studio). A graphical user interface (GUI) used to interact with SQL Server. It allows users to connect to databases, write queries, create and edit tables.
SQL (Structured Query Language). A special programming language used to work with data. SQL is used to insert, delete, update, and query data.
Hard
7.Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
DQL (Data Query Language) – Used to query data.
Example:
SELECT * FROM Students
DML (Data Manipulation Language) – Used to manipulate data (insert, update, delete).
Example:
INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'Ali', 20)
UPDATE Students SET Age = 21 WHERE StudentID = 1
DELETE FROM Students WHERE StudentID = 1
DDL (Data Definition Language) – Used to define and manage database objects.
Example:
CREATE TABLE Teachers (TeacherID INT PRIMARY KEY, Name VARCHAR(50))
DROP TABLE Teachers
DCL (Data Control Language) – Used to manage access permissions.
Example:
GRANT SELECT ON Students TO User1
REVOKE SELECT ON Students FROM User1
TCL (Transaction Control Language) – Used to manage transactions.
Example:
BEGIN TRANSACTION
UPDATE Students SET Age = 22 WHERE StudentID = 1
COMMIT
--or
ROLLBACK
8. Write a query to insert three records into the Students table.
INSERT INTO Students (StudentID, Name, Age) VALUES  (1, 'Ali', 20), (2, 'Zarina', 21), (3, 'Bekzod', 19)
    
