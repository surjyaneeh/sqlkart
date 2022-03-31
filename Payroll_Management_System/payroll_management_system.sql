DROP DATABASE IF EXISTS `payroll_management_system`;
CREATE SCHEMA `payroll_management_system` ;
USE `payroll_management_system` ;

CREATE TABLE Employee(
  Employee_Id INT,
  First_Name VARCHAR(25),
  Last_Name VARCHAR(25),
  Hire_Date DATE,
  City VARCHAR(25),
  State VARCHAR(25),
  CONSTRAINT EMPLOYEE_PK PRIMARY KEY (Employee_Id));

  CREATE TABLE Department(
  Department_Id INT,
  Department_Name VARCHAR(30),
  CONSTRAINT DEPARTMENT_PK PRIMARY KEY (Department_Id)
  );
  
  CREATE TABLE AccountDetails(
  Account_Id INT,
  Bank_Name VARCHAR(50),
  Account_Number VARCHAR(50),
  Employee_Id INT,
  CONSTRAINT Account_PK PRIMARY KEY (Account_Id),
  FOREIGN KEY (Employee_Id)
        REFERENCES Employee(Employee_Id)
  );
  
  CREATE TABLE Salary(
  Salary_Id INT,
  Gross_Salary INT,
  Hourly_Pay INT,
  State_Tax INT,
  Federal_Tax INT,
  Account_Id INT,
  CONSTRAINT SALARY_PK PRIMARY KEY (Salary_Id),
  FOREIGN KEY (Account_Id)
        REFERENCES AccountDetails(Account_Id)
  );
  
  CREATE TABLE Project(
  Project_Id INT,
  Project_Name VARCHAR(50),
  Project_Description VARCHAR(50),
  CONSTRAINT Project_PK PRIMARY KEY (Project_Id)
  );
  
  CREATE TABLE DepartmentProject(
  Department_Id INT,
  Project_Id INT,
  CONSTRAINT DEPTPROJECT_PK PRIMARY KEY (Department_Id,Project_Id),
  FOREIGN KEY (Department_Id)
        REFERENCES Department(Department_Id),
  FOREIGN KEY (Project_Id)
        REFERENCES Project(Project_Id)
  );
  
  CREATE TABLE Education(
  Education_Id INT,
  Employee_Id INT,
  Degree VARCHAR(30),
  Graduation_Year INT,
  CONSTRAINT Location_PK PRIMARY KEY (Education_Id),
  FOREIGN KEY (Employee_Id)
        REFERENCES Employee(Employee_Id)
  );
  
  CREATE TABLE Customer_Leave(
  Leave_Id INT,
  Employee_Id INT,
  Leave_date DATE,
  CONSTRAINT Leave_PK PRIMARY KEY (Leave_Id),
  FOREIGN KEY (Employee_Id)
        REFERENCES Employee(Employee_Id)
  );
  
  CREATE TABLE Attendance(
  Attendance_Id INT,
  Hours_Worked INT,
  CONSTRAINT Attendance_PK PRIMARY KEY (Attendance_Id)
  );
  
  CREATE TABLE Employee_Attendance(
  Employee_Id INT,
  Attendance_Id INT,
  CONSTRAINT DEPARTMENTPROJECT_PK PRIMARY KEY (Employee_Id,Attendance_Id),
  FOREIGN KEY (Employee_Id)
        REFERENCES Employee(Employee_Id),
  FOREIGN KEY (Attendance_Id)
        REFERENCES Attendance(Attendance_Id)
  );
  
  CREATE TABLE Work_Location(
  Location_Id INT,
  Location VARCHAR(25),
  Number_Of_Employees INT,
  City VARCHAR(25),
  State VARCHAR(25),
  CONSTRAINT Loc_PK PRIMARY KEY (Location_Id)
  );