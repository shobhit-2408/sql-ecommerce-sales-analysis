-- 2.	Customer Insights
-- 2.1.	Who are the top 10 customers by total revenue spent?

select O.CustomerID,C.CustomerName,sum(OD.Quantity* P.Price) as Total_Revenue 
from orderdetails OD
join orders O on O.OrderID=OD.OrderID
join products P on OD.ProductID=P.ProductID
join customers C on C.CustomerID=O.CustomerID
group by O.CustomerID,C.CustomerName
order by Total_Revenue desc
limit 10;

-- 2.2.	What is the repeat customer rate? [Customers who have placed order more than once]

select (count(CASE when cnt>1 then CustomerID END) / count(*))*100 as CRR
from (select O.CustomerID, COUNT(O.OrderID) as cnt
	  from orders O
	  group by O.CustomerID) T;
      

-- 2.3.	What is the average time between two consecutive orders for the same customer Region-wise?

with RankedOrders as(
	select RegionID,O.CustomerID,OrderDate,
		   ROW_Number() over(partition by CustomerID order by OrderDate) as rnk
    from orders O
    join customers C on C.CustomerID=O.CustomerID),

OrderPairs as(
	select curr.RegionID,curr.CustomerID,DATEDIFF(curr.OrderDate,prev.OrderDate) as DaysBetween
    from RankedOrders curr
    join RankedOrders prev on curr.CustomerID=prev.CustomerID and curr.rnk=prev.rnk+1),
    
RegionName as(
	select RegionName,CustomerID,DaysBetween
    from OrderPairs OP
    join regions R on R.RegionID=OP.RegionID)
    
select RegionName,round(AVG(DaysBetween),2) as ADB
from RegionName
group by RegionName
order by RegionName;


-- 2.4.	Customer Segment (based on total spend)
-- •	Platinum: Total Spend > 1500
-- •	Gold: 1000–1500
-- •	Silver: 500–999
-- •	Bronze: < 500

select C.CustomerID,CustomerName,
	   CASE
		WHEN TotalAmountSpent<500 then 'Bronze'
        WHEN TotalAmountSpent between 500 and 999 then 'Silver'
        WHEN TotalAmountSpent between 1000 and 1500 then 'Gold'
        ELSE 'Platinum'
	   END as CustomerSegment       
from(select CustomerID,sum(OD.quantity*P.Price) as TotalAmountSpent
from orderdetails OD
join products P on P.ProductID=OD.ProductID
join orders O on O.OrderID=OD.OrderID
group by CustomerID) T
join customers C on T.CustomerID=C.CustomerID
order by CustomerSegment;

-- 2.5.	What is the customer lifetime value (CLV)?

select C.CustomerID,CustomerName,sum(OD.quantity*P.Price) as TotalAmountSpent
from orderdetails OD
join products P on P.ProductID=OD.ProductID
join orders O on O.OrderID=OD.OrderID
join customers C on C.CustomerID=O.CustomerID
group by C.CustomerID,CustomerName;
