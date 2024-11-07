--CREATE THE FOLLOWING TABLE
CREATE TABLE Location (
		Location_Id INT PRIMARY KEY,
		City VARCHAR(100));
INSERT INTO Location (Location_ID, City) VALUES (122, 'New York'),(123, 'Dallas'),(124, 'Chicago'),(167, 'Boston');
SELECT * FROM Location;

CREATE TABLE Department (
		Department_Id INT PRIMARY KEY,
		Name VARCHAR(100),
		Location_ID INT FOREIGN KEY REFERENCES Location(Location_Id)
		);
INSERT INTO Department (Department_Id, Name, Location_Id) 
VALUES (10, 'Accounting', 122),(20, 'Sales', 124),(30, 'Research', 123),(40, 'Operations', 167);
SELECT * FROM Department;

CREATE TABLE Job (
		Job_Id INT PRIMARY KEY,
		Designation VARCHAR (100));
INSERT INTO Job (Job_ID, Designation) 
VALUES (667,'Clerk'),(668,'Staff'),(669,'Analyst'),(670,'Sales Person'),(671,'Manager'),(672,'President');
SELECT * FROM Job;

CREATE TABLE Employee (
		Employee_Id INT PRIMARY KEY,
		Last_Name VARCHAR(100),
		First_Name VARCHAR(100),
		Middle_Name VARCHAR(100),
		Job_Id INT FOREIGN KEY REFERENCES Job(Job_Id),
		Hire_Date DATE,
		Salary INT,
		Commission INT,
		Department_Id INT FOREIGN KEY REFERENCES Department(Department_Id));
INSERT INTO Employee VALUES
(7369,'Smith','John','Q',667,'17-Dec-84',800,NULL,20),
(7499,'Allen','Kevin','J',670,'20-Feb-85',1600,300,30),
(755,'Doyle','Jean','K',671,'04-Apr-85',2850,NULL,30),
(756,'Dennis','Lynn','S',671,'15-May-85',2750,NULL,30),
(757,'Baker','Leslie','D ',671,'10-Jun-85',2200,NULL,40),
(7521,'Wark','Cynthia','D ',670,'22-Feb-85',1250,50,30);
SELECT * FROM Employee;

SELECT * FROM Location;
SELECT * FROM Department;
SELECT * FROM Job;
SELECT * FROM Employee;


--Simple Queries:
--1. List all the employee details.
SELECT * FROM Employee;

--2. List all the department details.
SELECT * FROM Department;

--3. List all job details.
SELECT * FROM Job;

--4. List all the locations.
SELECT * FROM Location;

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT First_Name, Last_Name, Salary, Commission FROM Employee;

--6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
SELECT Employee_Id AS ID_of_the_Employee, Last_Name AS Name_of_the_Employee, Department_Id AS Dep_Id FROM Employee; 

--7. List out the annual salary of the employees with their names only.
SELECT First_name+' '+Middle_Name+' '+Last_Name AS Name, Salary FROM Employee;


--WHERE Condition:
--1. List the details about "Smith".
SELECT * FROM Employee WHERE Last_Name='Smith';

--2. List out the employees who are working in department 20.
SELECT * FROM Employee WHERE Department_Id=20;

--3. List out the employees who are earning salary between 2000 and 3000.
SELECT * FROM Employee WHERE Salary BETWEEN 2000 AND 3000;

--4. List out the employees who are working in department 10 or 20.
SELECT * FROM Employee WHERE Department_Id IN (10,20);

--5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM Employee WHERE Department_Id NOT IN (10,30);

--6. List out the employees whose name starts with 'L'.
SELECT * FROM Employee WHERE First_Name LIKE 'L%';

--7. List out the employees whose name starts with 'L' and ends with 'E'.
SELECT * FROM Employee WHERE First_Name LIKE 'L%' AND First_Name LIKE '%E';
SELECT * FROM Employee WHERE First_Name LIKE 'L%' AND Last_Name LIKE '%E';

--8. List out the employees whose name length is 4 and start with 'J'.
SELECT * FROM Employee WHERE LEN(First_Name) = 4 AND First_Name LIKE 'J%';

--9. List out the employees who are working in department 30 and draw the salaries more than 2500.
SELECT * FROM Employee WHERE Department_Id=30 AND Salary>2500;

--10. List out the employees who are not receiving commission.SELECT * FROM Employee WHERE Commission IS NULL;--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
SELECT Employee_ID, Last_Name FROM Employee ORDER BY Employee_Id;

--2. List out the Employee ID and Name in descending order based on salary.
SELECT Employee_ID, First_Name+' '+Middle_Name+' '+Last_Name AS Name, Salary FROM Employee ORDER BY Salary DESC;

--3. List out the employee details according to their Last Name in ascending-order.
SELECT * FROM Employee ORDER BY Last_Name DESC;

--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order
SELECT * FROM Employee ORDER BY Last_Name ASC, Department_Id DESC;

--GROUP BY and HAVING Clause
--1. List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT Department_Id, MIN(Salary) MinimumSalary, MAX(Salary) MaximumSalary, AVG(Salary) AverageSalary 
FROM Employee GROUP BY Department_Id;

--2. List out the job wise maximum salary, minimum salary and average salary of the employees.
SELECT Job_Id, MIN(Salary) MinimumSalary, MAX(Salary) MaximumSalary, AVG(Salary) AverageSalary 
FROM Employee GROUP BY Job_Id;

--3. List out the number of employees who joined each month in ascending order.
SELECT COUNT(Month) EmployeesNoPerMonth, Month FROM (SELECT *, MONTH(Hire_Date) AS Month from Employee)t 
GROUP BY Month ORDER BY EmployeesNoPerMonth;
--Sorted with respect to EmployeesNoPerMonth.
SELECT COUNT(Month) EmployeesNoPerMonth, Month FROM (SELECT *, MONTH(Hire_Date) AS Month from Employee)t 
GROUP BY Month ORDER BY Month;
--Sorted with respect to Month.

--4. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT YEAR(Hire_Date) AS Join_Year, MONTH(Hire_Date) AS Join_Month, COUNT(*) AS Employee_Count
FROM employee
GROUP BY YEAR(Hire_Date), MONTH(Hire_Date)
ORDER BY Join_Year, Join_Month;

--5. List out the Department ID having at least four employees.
SELECT Department_Id, COUNT(Employee_Id) as EmployeeCount FROM Employee GROUP BY Department_Id HAVING COUNT(Employee_Id) >=4;

--6. How many employees joined in February month.
SELECT COUNT(Month) EmployeesNoPerMonth, Month FROM (SELECT *, MONTH(Hire_Date) AS Month from Employee)t 
GROUP BY Month HAVING Month=2;

--7. How many employees joined in May or June month.
SELECT COUNT(Month) EmployeesNoPerMonth, Month FROM (SELECT *, MONTH(Hire_Date) AS Month from Employee)t 
GROUP BY Month HAVING Month IN (5,6);
--Displays seperate records on employee count, one for May and the other for June.
SELECT SUM(EmployeesNoPerMonth) AS Total FROM 
(SELECT COUNT(Month) EmployeesNoPerMonth, Month FROM (SELECT *, MONTH(Hire_Date) AS Month from Employee)t 
GROUP BY Month HAVING Month IN (5,6))u;
--Displays the total count of employees (total employees of May or June)

--8. How many employees joined in 1985?
SELECT COUNT(Year) EmployeesNoPerYear, Year FROM (SELECT *, YEAR(Hire_Date) AS Year from Employee)t 
GROUP BY Year HAVINg Year=1985;

--9. How many employees joined each month in 1985?
SELECT COUNT(Month) EmployeesNoPerMonth, Month, Year 
FROM (SELECT *, MONTH(Hire_Date) AS Month, YEAR(Hire_date) AS Year from Employee)t 
GROUP BY Month,Year HAVING YEAR=1985;

--10. How many employees were joined in April 1985?
SELECT COUNT(Month) EmployeesNoPerMonth, Month, Year 
FROM (SELECT *, MONTH(Hire_Date) AS Month, YEAR(Hire_date) AS Year from Employee)t 
GROUP BY Month,Year HAVING Year=1985 AND Month=4;

--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
SELECT Department_Id, COUNT(Month) EmployeesNoPerMonth, Month, Year 
FROM (SELECT *, MONTH(Hire_Date) AS Month, YEAR(Hire_date) AS Year from Employee)t 
GROUP BY Month,Year,Department_Id HAVING Year=1985 AND Month=4 AND  COUNT(Month)>=3;


--Joins:
--1. List out employees with their department names.
SELECT e.Employee_Id, e.First_Name+' '+e.Middle_Name+' '+e.Last_Name AS Name, d.Name as DepartmentName 
FROM Employee e JOIN Department d ON e.Department_Id=d.Department_Id;

--2. Display employees with their designations.
SELECT e.Employee_Id, e.First_Name+' '+e.Middle_Name+' '+e.Last_Name AS Name, j.Designation as Designation 
FROM Employee e JOIN Job j ON e.Job_Id=j.Job_Id;

--3. Display the employees with their department names and city.
SELECT e.Employee_Id, e.First_Name+' '+e.Middle_Name+' '+e.Last_Name AS Name, d.Name as DepartmentName, l.City
FROM Department d 
JOIN Employee e ON e.Department_Id=d.Department_Id
JOIN Location l ON d.Location_Id=l.Location_Id;

--4. How many employees are working in different departments? Display with department names.
SELECT d.Department_Id,Name DeptName, CountOfEmployees 
FROM Department d JOIN (SELECT COUNT(*) CountOfEmployees,Department_Id FROM Employee GROUP BY Department_Id) t
ON d.Department_Id=t.Department_Id;

--5. How many employees are working in the sales department?
SELECT d.Department_Id,Name  DeptName, CountOfEmployees 
FROM Department d JOIN (SELECT COUNT(*) CountOfEmployees,Department_Id FROM Employee GROUP BY Department_Id) t
ON d.Department_Id=t.Department_Id WHERE d.Name='Sales';

--6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order.
 SELECT d.Department_Id,Name  DeptName, CountOfEmployees 
FROM Department d JOIN (SELECT COUNT(*) CountOfEmployees,Department_Id FROM Employee GROUP BY Department_Id) t
ON d.Department_Id=t.Department_Id WHERE t.CountOfEmployees>=3 Order BY d.Name

--7. How many employees are working in 'Dallas'?
SELECT Count(*) AS Count,l.City
FROM Department d
JOIN Location l ON d.Location_ID=l.Location_Id
JOIN Employee e ON d.Department_Id=e.Department_Id
WHERE l.City='Dallas'
GROUP BY l.City;

--8. Display all employees in sales or operation departments.SELECT e.Employee_Id, e.First_Name+' '+e.Middle_Name+' '+e.Last_Name AS Name, d.Name as DepartmentName
FROM Employee e
JOIN Department d ON d.Department_Id=e.Department_IdWHERE d.Name IN ('Sales','Operations')--CONDITIONAL STATEMENT--1. Display the employee details with salary grades. Use conditional statement to create a grade column.
SELECT *, 
       CASE
       WHEN Salary >= 2000 THEN 'A'
       WHEN Salary >= 1000 AND Salary < 2000 THEN 'B'
       ELSE 'C'
       END AS SalaryGrade
FROM Employee;

--2. List out the number of employees grade wise. Use conditional statement to create a grade column.
SELECT SalaryGrade, COUNT(*) AS EmployeeCount
FROM (
    SELECT *, 
           CASE
             WHEN Salary >= 2000 THEN 'A'
             WHEN Salary >= 1000 AND Salary < 2000 THEN 'B'
             ELSE 'C'
           END AS SalaryGrade
    FROM Employee
) AS SalaryGrades
GROUP BY SalaryGrade;

--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.SELECT SalaryGrade, COUNT(*) AS EmployeeCount
FROM (
    SELECT *, 
           CASE
             WHEN Salary >= 2000 THEN 'A'
             WHEN Salary >= 1000 AND Salary < 2000 THEN 'B'
             ELSE 'C'
           END AS SalaryGrade
    FROM Employee
    WHERE Salary BETWEEN 2000 AND 5000
) AS SalaryGrades
GROUP BY SalaryGrade;--Subqueries:
--1. Display the employees list who got the maximum salary.
SELECT * FROM Employee WHERE Salary = (SELECT MAX(Salary) FROM Employee);

--2. Display the employees who are working in the sales department.
SELECT * FROM Employee WHERE Department_ID = (SELECT Department_ID FROM Department WHERE Name = 'Sales');

--3. Display the employees who are working as 'Clerk'.
SELECT * FROM Employee WHERE Job_Id = (SELECT Job_ID FROM Job WHERE Designation = 'Clerk');

--4. Display the list of employees who are living in 'Boston'.
SELECT * FROM Employee WHERE Department_Id IN (SELECT Department_Id FROM Department WHERE Location_id IN (
		SELECT Location_ID FROM location WHERE City = 'Boston')
);

--5. Find out the number of employees working in the sales department.
SELECT COUNT(*) AS EmployeeCount FROM Employee WHERE Department_Id = (SELECT Department_Id FROM Department WHERE  Name = 'Sales');

--6. Update the salaries of employees who are working as clerks on the basis of 10%.
UPDATE Employee SET Salary = Salary * 1.1 WHERE Job_Id = (SELECT Job_Id FROM Job WHERE Designation = 'Clerk');
SELECT * FROM Employee;

--7. Display the second highest salary drawing employee details.
SELECT * FROM Employee WHERE Salary = (SELECT MAX(Salary) FROM Employee WHERE Salary < (SELECT MAX(Salary) FROM Employee));

--8. List out the employees who earn more than every employee in department 30.
SELECT * FROM Employee WHERE Salary > ALL (SELECT Salary FROM Employee WHERE Department_ID = 30);

--9. Find out which department has no employees.
SELECT Name FROM department WHERE Department_ID NOT IN (SELECT DISTINCT Department_ID FROM Employee);
--10. Find out the employees who earn greater than the average salary for their department.SELECT * FROM Employee e WHERE Salary > (SELECT AVG(Salary) FROM Employee WHERE Department_ID = e.Department_ID);