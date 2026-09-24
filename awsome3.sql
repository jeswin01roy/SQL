select SaleDate,SPID,Boxes
from sales
where Boxes>(
select avg(Boxes)
from sales
);

-- sub quary on IN

select SaleDate,SPID,Amount,Boxes
from sales
where spid in (
select spid
from people
where location='seattle'
);

select SaleDate,SPID,Amount,Boxes
from sales
where pid in (
select pid 
from products
where category='Bars'
);

-- corelate sub quaery
select s.SPID,p.Salesperson,s.SaleDate,s.Amount
from sales s
join people p
on s.spid=p.spid
where s.Amount>(
select avg(s2.Amount)
from sales s2
where s2.spid=s.spid
);

-- exists
select p.SPID,p.Salesperson
from people p
where exists(
select 1
from sales s
where s.spid=p.spid
);

-- not exists
select p.SPID,p.Salesperson
from people p
where not exists(
select 1
from sales s
where s.spid=p.spid
);

-- cte 
-- CTE stands for Common Table Expression.

-- A CTE is a temporary named result set that you
-- create at the beginning of a query using WITH.
-- WITH cte_name AS (
--     SELECT ...
--     FROM ...
--     WHERE ...
-- )
-- SELECT *
-- FROM cte_name;

-- Show all shipments where more than 1,000 boxes were shipped.
select SaleDate,SPID,Boxes,Amount
from sales 
where Boxes>1000;

with large_shipments as (
select SaleDate,SPID,Boxes,Amount
from sales
where Boxes>1000
)
select * from large_shipments;

-- Get all sales from January 2022 and then display them.
with january_sales as (
select * 
from sales
where SaleDate>='2022-01-01'
and SaleDate< '2022-02-01'
)
select *from january_sales ;
WITH salesperson_sales AS (
    SELECT
        SPID,
        SUM(Boxes) AS total_boxes
    FROM sales
    GROUP BY SPID
)
SELECT *
FROM salesperson_sales;

with salesperson_sales as (
	select  SPID,sum(Boxes) as total_boxes
    from sales
    group by SPID
)
SELECT
    p.Salesperson,
    ss.total_boxes
FROM salesperson_sales ss
JOIN people p
    ON ss.SPID = p.SPID
ORDER BY ss.total_boxes DESC;

-- Which salespeople sold more than 10,000 boxes?
with salesperson_sales as(
	select SPID,sum(Boxes) as total_boxes
    from sales
    group by SPID
)
select 
	p.salesperson,
	ss.total_boxes
from salesperson_sales ss
join people p
	on ss.SPID=p.SPID
where ss.total_boxes>10000
order by ss.total_boxes desc;

-- Find total sales and total boxes for each salesperson.
with salesperson_amt as (
select
	SPID,
    sum(Amount) as total_sales
from sales
group by SPID
),
salesperson_boxes as (
select
	SPID,
    sum(Boxes) as total_boxes
from sales
group by SPID
)
select
	p.Salesperson,
    sa.total_sales,
    sb.total_boxes
from people p
join salesperson_amt sa 
	on p.SPID=sa.SPID
join salesperson_boxes sb
	on p.SPID=sb.SPID;
    
    
-- window function
-- What is a Window Function?

-- A window function performs a calculation across a group of related rows without combining those rows into one row.

-- This is the key difference:

-- GROUP BY

SELECT
    SPID,
    SUM(Amount) AS total_sales
FROM sales
GROUP BY SPID;


SELECT
    SPID,
    SaleDate,
    Amount,
    SUM(Amount) OVER(PARTITION BY SPID) AS total_sales
FROM sales;


-- FUNCTION() OVER(
--     PARTITION BY ...
--     ORDER BY ...
-- )

select
	SaleDate,
    SPID,
    Amount
from sales

-- 1. ROW_NUMBER()

-- ROW_NUMBER() gives every row a unique sequential number.

-- Example

-- Number all sales based on sale date.

