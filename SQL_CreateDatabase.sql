--create database
create database Ecommerce
use Ecommerce


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    CustomerEmail NVARCHAR(100) NOT NULL UNIQUE,
    CustomerGender NVARCHAR(10) CHECK (CustomerGender IN ('Male', 'Female')),
    CustomerAddress NVARCHAR(100)
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0)
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails (
	OrderDetailID int primary key not null,
    OrderID INT NOT NULL,
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    ProductID INT NOT NULL,
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    Quantity INT NOT NULL
);


CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    ProductID INT NOT NULL,
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    ReviewText NVARCHAR(255),
    ReviewDate DATE NOT NULL
);


CREATE TABLE WebsiteVisits (
    VisitID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
	foreign key (CustomerID) references Customers(CustomerID),
    PageVisited NVARCHAR(50) NOT NULL,
    VisitDuration DECIMAL(5, 2) NOT NULL CHECK (VisitDuration >= 0),
    VisitDate DATE NOT NULL
);