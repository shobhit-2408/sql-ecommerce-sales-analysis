-- 3.	Product & Order Insights
-- 3.1.	What are the top 10 most sold products (by quantity)?

select OD.ProductID,P.ProductName,sum(OD.Quantity) as UnitsSold 
from orderdetails OD
join products P on P.ProductID=OD.ProductID
group by OD.ProductID,P.ProductName
order by UnitsSold desc
limit 10;

-- 3.2.	What are the top 10 most sold products (by revenue)?

select OD.ProductID,P.ProductName,sum(OD.Quantity*P.Price) as Revenue 
from orderdetails OD
join products P on P.ProductID=OD.ProductID
group by OD.ProductID,P.ProductName
order by Revenue desc
limit 10;

-- 3.3.	Which products have the highest return rate? [Return Rate = Return Quantity/Total Quantity]

with UnitsSold as(
	select ProductID,sum(Quantity) as UnitsSold
    from orderdetails
    group by ProductID),
    
Returned as(
	select ProductID,sum(Quantity) as UnitsReturned
    from orderdetails OD
    join orders O on O.OrderID=OD.OrderID
    where isReturned=1
    group by ProductID)

select ProductName,ROUND(UnitsReturned/UnitsSold,2)*100 as ReturnRate
from products P
join UnitsSold S on S.ProductID=P.ProductID
join Returned R on R.ProductID=P.ProductID
order by ReturnRate desc;

-- 3.4.	Return Rate by Category

with UnitsSold as(
	select Category,sum(Quantity) as UnitsSold
    from orderdetails OD
    join products P on P.ProductID=OD.ProductID
    group by Category),
    
Returned as(
	select Category,sum(Quantity) as UnitsReturned
    from orderdetails OD
    join orders O on O.OrderID=OD.OrderID
    join products P on P.ProductID=OD.ProductID
    where isReturned=1
    group by Category)

select R.Category,ROUND(UnitsReturned/UnitsSold,2)*100 as ReturnRate
from Returned R
join UnitsSold S on S.category=R.category
order by ReturnRate desc;

-- 3.5.	What is the average price of products per region? [Average Price= Total Revenue/ Quantity Sold]


select R.RegionName,ROUND(sum(OD.Quantity*P.Price)/sum(OD.Quantity),2) as AvgPrice
from products P	
join orderdetails OD on P.ProductID=OD.ProductID
join orders O on O.OrderID=OD.OrderID
join customers C on C.CustomerID=O.CustomerID
join regions R on R.RegionID=C.RegionID
group by R.RegionName
order by R.RegionName;

-- 3.6.	What is the sales trend for each product category?

select date_format(OrderDate,"%Y-%m") as Period,Category,SUM(OD.Quantity*P.Price) as Revenue
from orderdetails OD
join products P on P.ProductID=OD.ProductID
join orders O on O.OrderID=OD.OrderID
group by Period,Category
order by Period,Category;
