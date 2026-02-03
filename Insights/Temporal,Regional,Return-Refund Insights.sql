-- 4.	Temporal Trends
-- 4.1.	What are the monthly sales trends over the past year?

select YEAR(OrderDate) as 'Year',
	   MONTH(OrderDate) as 'Month',
       SUM(OD.Quantity*P.Price) as TotalRevenue
from orders O
join orderdetails OD on OD.OrderID=O.OrderID
join products P on OD.ProductID=P.ProductID
where OrderDate>=current_date()-Interval 12 month
group by Year(OrderDate),Month(OrderDate)
order by Year(OrderDate),Month(OrderDate);

-- 4.2.	How does the average order value (AOV) change by month or week?

select date_format(OrderDate,"%Y-%M") as Period,
	   ROUND(sum(OD.Quantity*P.Price)/ count(distinct O.OrderID),2) as AOV
from orderdetails OD
join orders O on O.OrderID=OD.OrderID
join products P on P.ProductID=OD.ProductID
group by Period
order by Period;


-- 5.	Regional Insights
-- 5.1.	Which regions have the highest order volume and which have the lowest?

select RegionName,
	   count(O.OrderID) as Volume
from orders O
join customers C on C.CustomerID=O.CustomerID
join regions R on R.RegionID=C.RegionID
group by R.RegionName
order by Volume desc;

-- 5.2.	What is the revenue per region and how does it compare across different regions?

select RegionName,
	   SUM(OD.Quantity*P.Price) as Revenue
from orders O
join orderdetails OD on O.OrderID=OD.OrderID
join products P on P.ProductID=OD.ProductID
join customers C on C.CustomerID=O.CustomerID
join regions R on R.RegionID=C.RegionID
group by R.RegionName
order by Revenue desc;

-- 6.	Return & Refund Insights
-- 6.1.	What is the overall return rate by product category?

select Category,
	   round(SUM(CASE when isReturned =1 then 1 else 0 end)/count(O.OrderID),2) as RR
from orders O
join orderdetails OD on O.OrderID=OD.OrderID
join products P on P.ProductID=OD.ProductID
group by Category
order by RR desc;

-- 6.2.	What is the overall return rate by region?


select RegionName,
	   round(SUM(CASE when isReturned =1 then 1 else 0 end)/count(O.OrderID),2) as RR
from orders O
join customers C on C.CustomerID=O.CustomerID
join regions R on R.RegionID=C.RegionID
group by RegionName
order by RR desc;

-- 6.3.	Which customers are making frequent returns?

select C.CustomerID,CustomerName,count(O.OrderID) as ReturnCount
from customers C
join orders O on O.CustomerID=C.CustomerID
where IsReturned=1
group by C.CustomerID,C.CustomerName
order by ReturnCount desc;
