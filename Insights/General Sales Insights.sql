-- 1.	General Sales Insights
-- 1.1.	What is the total revenue generated over the entire period?

show tables;

select sum(P.Price*OD.quantity) as 'Total Revenue'
from products P
join orderdetails OD on P.ProductID=OD.ProductID;


-- 1.2.	Revenue Excluding Returned Orders

select sum(P.Price*OD.quantity) as 'Total Revenue'
from products P
join orderdetails OD on P.ProductID=OD.ProductID
join orders O on OD.OrderID=O.OrderID
where O.IsReturned=0;

-- 1.3.	Total Revenue per Year / Month

select Year(OrderDate) as 'Year', Month(OrderDate) as 'Month', sum(P.Price*OD.quantity) as 'Total Revenue'
from products P
join orderdetails OD on P.ProductID=OD.ProductID
join orders O on O.OrderID=OD.OrderID
group by Year(OrderDate),Month(OrderDate)
order by Year(OrderDate),Month(OrderDate);


-- 1.4.	Revenue by Product / Category

select P.ProductName, P.Category, sum(P.Price*OD.quantity) as 'Total Revenue'
from products P
join orderdetails OD on P.ProductID=OD.ProductID
group by P.ProductName,P.Category
order by P.ProductName,P.Category;

-- 1.5.	What is the average order value (AOV) across all orders? [AOV=Total Revenue/Number of orders]

select ROUND(sum(P.Price*OD.quantity) / (select count( DISTINCT OrderID) from orderdetails),2) as AOV
from products P
join orderdetails OD on P.ProductID=OD.ProductID;

--                   OR 

-- [FASTER]

select avg(TotalOrderValue)
from (select OrderID,sum(P.Price * OD.quantity) as TotalOrderValue
from products P
join orderdetails OD on P.ProductID=OD.ProductID
group by OrderID) as T;


-- 1.6.	AOV per Year / Month

select YEAR(OrderDate) as Year, MONTH(OrderDate) as Month, round(avg(TotalOrderValue),2) as AOV
from (select O.OrderID, OrderDate,sum(P.Price * OD.quantity) as TotalOrderValue
	  from products P
	  join orderdetails OD on P.ProductID=OD.ProductID
	  join orders O on O.OrderID=OD.OrderID
	  group by OD.OrderId) as T
group by Year,Month
order by Year,Month;

-- 1.7.	What is the average order size by region?

select RegionName,round(avg(Order_Size),2) as 'Avg Order Size'
from (select O.OrderID, R.RegionName,sum(OD.Quantity) as Order_Size
	  from orderdetails OD
	  join orders O on O.OrderID=OD.OrderID
	  join customers C on C.CustomerID=O.CustomerID
	  join regions R on R.RegionID=C.RegionID
	  group by O.OrderID) T
group by RegionName;


select count(distinct OrderID) from orders;