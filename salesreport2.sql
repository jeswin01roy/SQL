-- manually creating null values
select *from sales;

insert into sales (SaleDate,SPID,PID,Amount,Boxes)
VALUES('2026-01-01','SP110','P110',NULL,NULL);

SELECT *
FROM sales
WHERE Amount IS NULL;

-- COALESCE is a function used to handle NULL values.

-- It returns the first non-NULL value from a list of values.

-- Using COALESCE (replace NULL values)

SELECT Amount,COALESCE(Amount, 0) AS Clean_Amount
FROM sales;

-- Replace NULL Boxes with 0

select SaleDate,Amount,coalesce(Boxes,0) as Boxes
from sales;

select *from people;

INSERT INTO people ( Salesperson,SPID, Team,Location)
VALUES ("Kenny",'SP220', NULL, NULL);

-- Replace NULL Team with 'No Team'

select Salesperson,coalesce(Team,'No Team') as Team
from people
order by Salesperson;

-- WHERE → filters rows before grouping
-- HAVING → filters groups after aggregation

-- HAVING = filter results after applying aggregate functions (SUM, AVG, COUNT, etc.)-- 

-- Shows only salespersons with total sales > 1500000

SELECT SPID, SUM(Amount) AS Total_Sales
FROM sales
GROUP BY SPID
HAVING SUM(Amount) > 1500000;

-- Count number of sales per SPID
select SPID,count(*) as Total_Orders
from sales
group by SPID
having count(*)>300;

-- treating null values in amount column with 0
SELECT SPID, SUM(COALESCE(Amount, 0)) AS Total_Sales
FROM sales
GROUP BY SPID
HAVING SUM(COALESCE(Amount, 0)) > 1500000;

select * from sales;

SELECT SPID,SUM(Amount) AS Total_Sales
FROM sales
WHERE Boxes > 5
GROUP BY SPID
HAVING SUM(Amount) > 200000;




-- LIMIT
-- Show first 5 rows from sales


SELECT *
FROM sales
LIMIT 10;


-- lowest first 5 sales
SELECT *
FROM sales
ORDER BY Amount 
LIMIT 20;


-- highest 5 sales
SELECT *
FROM sales
ORDER BY Amount DESC
LIMIT 5;


-- skipping first 5 and extracting next 5 rows
SELECT *
FROM sales
ORDER BY Amount 
LIMIT 5 OFFSET 5;

-- 1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
select *from sales
where Amount>2000 and Boxes<100;

-- 2. How many shipments (sales) each of the sales persons had in the month of January 2022?
select s.SPID,p.Salesperson,count(s.SPID)
from sales s
left join people p on s.spid=p.spid
where year(s.SaleDate)='2022' and month(s.SaleDate)=1
group by s.SPID;

-- 3. Which product sells more boxes? Milk Bars or Eclairs?

select pr.Product,sum(s.Boxes)
from sales s
left join products pr on s.pid=pr.pid
where pr.Product in ('Milk Bars','Eclairs')
group by pr.product
order by  sum(s.Boxes) desc;

-- 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
select pr.Product,sum(s.Boxes) as total_boxes
from sales s
left join products pr on s.pid=pr.pid
where pr.Product in ('Milk Bars','Eclairs') and s.SaleDate between '2022-02-1' and '2022-02-07'
group by pr.product
order by total_boxes desc;

-- 5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select SPID,Customers,Amount,dayname(SaleDate) as days
from sales 
where Customers < 100 and Boxes < 100 and day(SaleDate)=2;

SELECT p.SPID, p.Salesperson
FROM people p
LEFT JOIN sales s ON p.SPID = s.SPID
WHERE s.SPID IS NULL;

-- 1. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
SELECT p.SPID, p.Salesperson, COUNT(s.SPID) AS ShipmentCount
FROM people p
LEFT JOIN sales s ON p.SPID = s.SPID 
where s.SaleDate BETWEEN '2022-01-01' AND '2022-01-07'
GROUP BY p.SPID, p.Salesperson;


-- 2. Which salespersons did not make any shipments in the first 7 days of January 2022?

SELECT p.SPID, p.Salesperson, COUNT(s.SPID) AS ShipmentCount
FROM people p
LEFT JOIN sales s ON p.SPID = s.SPID 
and s.SaleDate BETWEEN '2022-01-01' AND '2022-01-07'
where s.SPID IS NULL 
GROUP BY p.SPID, p.Salesperson;

-- 3. How many times we shipped more than 1,000 boxes in each month?


-- 4. Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?



-- 5. India or Australia? Who buys more chocolate boxes on a monthly basis?



