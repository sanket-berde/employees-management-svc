
CREATE DATABASE EmployeeDB;

USE EmployeeDB;

CREATE TABLE Employees
(
    EmployeeId INT PRIMARY KEY IDENTITY(1,1),  -- Auto-incremented unique identifier
    FirstName NVARCHAR(50) NOT NULL,            -- Employee's first name
    LastName NVARCHAR(50) NOT NULL,             -- Employee's last name
    DateOfBirth DATE NOT NULL,                  -- Employee's date of birth
    Position NVARCHAR(100),                     -- Job title/position
    Salary DECIMAL(18, 2),                      -- Employee's salary
    HireDate DATE NOT NULL,                     -- Date when the employee was hired
    Email NVARCHAR(100) UNIQUE,                 -- Email address (unique)
    PhoneNumber NVARCHAR(15)                   -- Employee's phone number
);

INSERT INTO Employees (FirstName, LastName, DateOfBirth, Position, Salary, HireDate, Email, PhoneNumber)
VALUES
('John', 'Doe', '1985-03-20', 'Software Developer', 75000.00, '2010-05-15', 'john.doe@email.com', '123-456-7890'),
('Jane', 'Smith', '1990-07-10', 'Project Manager', 85000.00, '2015-08-01', 'jane.smith@email.com', '987-654-3210'),
('Michael', 'Johnson', '1982-02-14', 'HR Specialist', 60000.00, '2012-12-20', 'michael.johnson@email.com', '555-555-5555'),
('Emily', 'Davis', '1988-11-30', 'Sales Executive', 70000.00, '2016-03-10', 'emily.davis@email.com', '444-444-4444');

SELECT * FROM Employees;
