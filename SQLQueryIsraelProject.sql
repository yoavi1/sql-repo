CREATE TABLE Items (
    Code int not null IDENTITY PRIMARY KEY,
    [Desc] NVARCHAR(50),
    UnitPrice int not null,
    Available int not null,
    Saved int not null,
    Waiting int not null,
    Subscript int not null,
    Freq int not null,
    SuppDate DATE not null,
    OrderPercnt FLOAT not null
);



CREATE TABLE ExOrders (
 [DATE] DATE not null,
 OrderNo int not null IDENTITY PRIMARY KEY,
 CustID int not null ,
Delivery nvarchar(10) not null ,
[Address] nvarchar(50) not null ,
[Status] nvarchar (50) not null,
SuppDate date not null 
);

create table Invoices(
 [DATE] DATE not null,
 OrderNo int not null,
 UnitDesc nvarchar (50),
 UnitPrice int not null,
 InvNo int IDENTITY PRIMARY KEY,
 TotAmount int not null 
 );


 create table Subscription (
  --OrderNo int not null,
  OrderNo int FOREIGN KEY (OrderNo) REFERENCES ExOrders(OrderNo),
  [Status] nvarchar (50) not null,
  CustID int not null,
  Freq int not null,
  Delivery nvarchar(10) not null,
  NextOrder DATE not null,
  Expiration DATE not null
 );

 create table Customers (
 CustID int not null PRIMARY KEY,
 CustType int not null ,
 CustStatus nvarchar (50) not null ,
 FreezCode int ,
 OverCount int,
 CustName nvarchar (50) not null,
 DelivAddrss nvarchar (50) not null,
 MailAddrss nvarchar (50) not null,
 CreditCard int not null
 );

 create table Receipt (
 PymtDate date not null,
 RecNo int not null PRIMARY KEY,
 InvNo int not null,
 OrderNo int not null,
 PaidAmt int not null
 );

 CREATE TABLE Accounting (
 [Date] date  not null,
 Amount int not null ,
 CrdtDebt nvarchar (50) not null,
 InvNo int ,
 OrderNo int ,
 --ReceiptNo int
 RecNo int FOREIGN KEY (RecNo) REFERENCES Receipt (RecNo)
 );

  CREATE TABLE StockOrder(
   OrderNo int not null IDENTITY PRIMARY KEY,
   StockDate date not null,
   Code int not null,
   Descr nvarchar (50) not null ,
   Quant int not null
  );

  CREATE TABLE DeliveryFees (
    Delivery VARCHAR(10) PRIMARY KEY,
    [Desc] VARCHAR(50),
    DelFee int
);


CREATE TABLE Discounts (
    CustType VARCHAR(10) PRIMARY KEY,
    Discnt int
);


CREATE TABLE Numbers (
    LastOrder INT,
    LastSubsc INT,
    LastStock INT,
    LastReciept INT,
    LastInvoice INT
);


  CREATE TABLE orderDetails (
  OrderNo int FOREIGN KEY (OrderNo) REFERENCES ExOrders(OrderNo),
  code int FOREIGN KEY (code) REFERENCES items(code),
  Quant int
  );



  -- Insert into Items
INSERT INTO Items ([Desc], UnitPrice, Available, Saved, Waiting, Subscript, Freq, SuppDate, OrderPercnt)
VALUES 
('drill', 100, 50, 5, 10, 1, 7, '2024-08-01', 0.15),
('nail', 200, 40, 8, 15, 1, 14, '2024-08-05', 0.10),
('hamer', 150, 30, 4, 5, 1, 7, '2024-08-10', 0.20),
('5kg wood', 300, 20, 2, 3, 1, 30, '2024-08-15', 0.25),
('big nail', 400, 10, 1, 2, 1, 7, '2024-08-20', 0.30);

-- Insert into ExOrders
INSERT INTO ExOrders ([DATE], CustID, Delivery, [Address], [Status], SuppDate)
VALUES 
('2024-08-01', 1, 'Yes', '123 Main St', 'Pending', '2024-08-05'),
('2024-08-02', 2, 'No', '456 Elm St', 'Shipped', '2024-08-06'),
('2024-08-03', 3, 'Yes', '789 Oak St', 'Delivered', '2024-08-07'),
('2024-08-04', 4, 'Yes', '101 Pine St', 'Pending', '2024-08-08'),
('2024-08-05', 5, 'No', '202 Cedar St', 'Cancelled', '2024-08-09');

-- Insert into Invoices
INSERT INTO Invoices ([DATE], OrderNo, UnitDesc, UnitPrice, TotAmount)
VALUES 
('2024-08-05', 1, 'drill', 100, 500),
('2024-08-06', 2, 'drill', 200, 800),
('2024-08-07', 3, 'nail', 150, 450),
('2024-08-08', 4, '5kg wood', 300, 900),
('2024-08-09', 5, 'big nail', 400, 1200);

-- Insert into Subscription
INSERT INTO Subscription (OrderNo, [Status], CustID, Freq, Delivery, NextOrder, Expiration)
VALUES 
(1, 'Active', 1, 7, 'Yes', '2024-08-10', '2025-08-10'),
(2, 'Active', 2, 14, 'No', '2024-08-20', '2025-08-20'),
(3, 'Inactive', 3, 7, 'Yes', '2024-08-15', '2025-08-15'),
(4, 'Pending', 4, 30, 'Yes', '2024-08-25', '2025-08-25'),
(5, 'Active', 5, 7, 'No', '2024-08-30', '2025-08-30');

-- Insert into Customers
INSERT INTO Customers (CustID, CustType, CustStatus, FreezCode, OverCount, CustName, DelivAddrss, MailAddrss, CreditCard)
VALUES 
(1, 1, 'Active', NULL, 0, 'John Doe', '123 Main St', 'john@example.com', 12345),
(2, 2, 'Inactive', 1, 2, 'Jane Smith', '456 Elm St', 'jane@example.com', 23456),
(3, 1, 'Active', NULL, 1, 'Bob Brown', '789 Oak St', 'bob@example.com', 345678),
(4, 3, 'Pending', 2, 3, 'Alice Green', '101 Pine St', 'alice@example.com', 456789),
(5, 2, 'Cancelled', NULL, 0, 'Charlie Black', '202 Cedar St', 'charlie@example.com', 567890);

-- Insert into Receipt
INSERT INTO Receipt (PymtDate, RecNo, InvNo, OrderNo, PaidAmt)
VALUES 
('2024-08-05', 1, 1, 1, 500),
('2024-08-06', 2, 2, 2, 800),
('2024-08-07', 3, 3, 3, 450),
('2024-08-08', 4, 4, 4, 900),
('2024-08-09', 5, 5, 5, 1200);

-- Insert into Accounting
INSERT INTO Accounting ([Date], Amount, CrdtDebt, InvNo, OrderNo, RecNo)
VALUES 
('2024-08-05', 500, 'Credit', 1, 1, 1),
('2024-08-06', 800, 'Credit', 2, 2, 2),
('2024-08-07', 450, 'debt', 3, 3, 3),
('2024-08-08', 900, 'debt', 4, 4, 4),
('2024-08-09', 1200, 'debt', 5, 5, 5);

-- Insert into StockOrder
INSERT INTO StockOrder (StockDate, Code, Descr, Quant)
VALUES 
('2024-08-01', 1, 'Items A', 50),
('2024-08-02', 2, 'Items B', 40),
('2024-08-03', 3, 'Items C', 30),
('2024-08-04', 4, 'Items D', 20),
('2024-08-05', 5, 'Items E', 10);

-- Insert into orderDetails
INSERT INTO orderDetails (OrderNo, Code, Quant)
VALUES 
(1, 1, 5),
(1, 2, 8),
(3, 1, 3),
(4, 4, 2),
(5, 5, 1);

INSERT INTO DeliveryFees (Delivery, [Desc], DelFee)
VALUES 
('DL', 'Standard Delivery', 50),
('PS', 'Postal Service', 20),
('PR', 'Customer Pickup', 0);

INSERT INTO Discounts (CustType, Discnt)
VALUES 
('1', 10), 
('2', 15), 
('3', 5);   


INSERT INTO Numbers (LastOrder, LastSubsc, LastStock, LastReciept, LastInvoice)
VALUES 
(1005, 505, 305, 2005, 1505);







--6.1A
DECLARE @MyVariable1 INT;
SET @MyVariable1 = 3;
SELECT  Code, [Desc], Waiting, Saved, Subscript, UnitPrice, Freq, SuppDate, OrderPercnt
FROM     Items
WHERE   (Code =  @MyVariable1)

--6.1B
SELECT  Code, [Desc], Waiting, Saved, Subscript, UnitPrice, Freq, SuppDate, OrderPercnt
FROM     Items

--6.2
DECLARE @MyVariable2 INT;
SET @MyVariable2 = 1;
SELECT  ExOrders.DATE,
orderDetails.code, 
items.UnitPrice * orderDetails.Quant as [sum order price],
orderDetails.Quant,
orderDetails.OrderNo,
ExOrders.Status
FROM     Items INNER JOIN
               orderDetails ON Items.Code = orderDetails.code INNER JOIN
               ExOrders ON orderDetails.OrderNo = ExOrders.OrderNo
			where ExOrders.OrderNo = @MyVariable2
			order by ExOrders.DATE
--6.3
DECLARE @MyVariable3 INT;
SET @MyVariable3 = 23456;
SELECT Customers.CustID, Customers.CustName, Customers.CustStatus, Subscription.OrderNo, ExOrders.Status, orderDetails.code, orderDetails.Quant, Subscription.Freq
FROM  Customers INNER JOIN
         Subscription ON Customers.CustID = Subscription.CustID INNER JOIN
         ExOrders ON Subscription.OrderNo = ExOrders.OrderNo INNER JOIN
         orderDetails ON ExOrders.OrderNo = orderDetails.OrderNo
		 where Customers.CustID = @MyVariable3

--6.4
DECLARE @MyVariable4 nvarchar (50);
SET @MyVariable4 = '2024-08-02';
SELECT Accounting.CrdtDebt, Accounting.OrderNo, Accounting.RecNo, Receipt.PymtDate, Receipt.PaidAmt
FROM  Accounting INNER JOIN
         Receipt ON Accounting.RecNo = Receipt.RecNo
		 WHERE (Accounting.CrdtDebt = 'Credit' and (Receipt.PymtDate) > '2024-08-02'  )
UNION 
SELECT Accounting.CrdtDebt, Accounting.OrderNo, Accounting.RecNo, Receipt.PymtDate, Receipt.PaidAmt
FROM  Accounting INNER JOIN
         Receipt ON Accounting.RecNo = Receipt.RecNo
		 WHERE (Accounting.CrdtDebt = 'debt' and (Receipt.PymtDate) > '2024-08-02'  )

		 SELECT CrdtDebt, sum(Amount) as [sum]
		 FROM  Accounting INNER JOIN
         Receipt ON Accounting.RecNo = Receipt.RecNo
		 where (Receipt.PymtDate > @MyVariable4)  
		group by CrdtDebt
		


--select CrdtDebt sum(paid)
--from Accounting 


   --  code int FOREIGN KEY (code) REFERENCES items(code)
   --Quant int FOREIGN KEY (Quant) REFERENCES items(code)

--  ALTER TABLE Orders
--ADD CONSTRAINT FK_Orders_Customers
--FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);


--CREATE TABLE orderDetail (
--OrderNo int not null 
--code int not 

--);


--CREATE TABLE orderDetail (
--SuppDate date not null
--OrderNo int not null 
--UnitDesc nvarchar (50)
--NoUnits 
--);



---- Insert Item 1
--INSERT INTO Items ([Desc], UnitPrice, Available, Saved, Waiting, Subscript, Freq, SuppDate, OrderPercnt)
--VALUES ('hamer', 100, 50, 20, 15, 30, 5, '2024-08-20', 0.75);

---- Insert Item 2
--INSERT INTO Items ([Desc], UnitPrice, Available, Saved, Waiting, Subscript, Freq, SuppDate, OrderPercnt)
--VALUES ('nail', 200, 30, 10, 5, 15, 7, '2024-08-21', 0.50);

---- Insert Item 3
--INSERT INTO Items ([Desc], UnitPrice, Available, Saved, Waiting, Subscript, Freq, SuppDate, OrderPercnt)
--VALUES ('drill', 150, 20, 8, 12, 25, 6, '2024-08-22', 0.65);


--CREATE TABLE Items (
--    Code int not null IDENTITY PRIMARY KEY,
--    [Desc] NVARCHAR(50),
--    UnitPrice int not null,
--    Available int not null,
--    Saved int not null,
--    Waiting int not null,
--    Subscript int not null,
--    Freq int not null,
--    SuppDate DATE not null,
--    OrderPercnt FLOAT not null
--);