-- select every thing from sales
select *from sales;

-- select every thing from people
select *from people;

-- select everything from geo
select *from geo;

-- select every thing from products
select *from products;

-- Show just a few columns from sales table
select SaleDate,Amount
from sales;

-- Adding a calculated column with SQL
select SaleDate,Amount,Boxes,Amount/Boxes
from sales;

-- Adding a calculated column with SQL
select SaleDate,Amount,Boxes,Amount/Boxes as 'Amount per boxes' 
from sales;

-- Using WHERE Clause in SQL
select * from sales
where Amount>10000;

-- Showing sales data where amount is greater than 10,000 by ascending order
select * from sales
where Amount>10000
order by Amount;

-- Showing sales data where amount is greater than 10,000 by descending order
select * from sales
where Amount>10000
order by Amount desc;

-- Showing sales data where geography is g1 by product ID &
-- descending order of amounts

select * from sales
where GeoID='g1'
order by PID,Amount desc;


-- Working with dates in SQL
select * from sales
where Amount>10000 and SaleDate>='2022-01-01';

-- Using year() function to select all data in a specific year
select SaleDate,Amount from sales
where Amount>10000 and year(saledate)=2022
order by Amount desc;
-- 287

-- BETWEEN condition in SQL with < & > operators
select * from sales
where Boxes>=0 and Boxes<=50; -- 741

-- Using the between operator in SQL 
select * from sales
where Boxes between 0 and 50;-- 741

-- Using weekday() function in SQL
select SaleDate,Amount,Boxes,weekday(saledate) as 'Dayofweek' 
from sales
where weekday(saledate)=4;

-- Working with People table
select * from people;

-- OR operator in SQL
select * from people
where team='Delish' or Team='jucies';-- 19

-- IN operator in SQL

select * from people
where team in ('Delish','jucies');-- 19

-- LIKE operator in SQL
select * from people
where Salesperson like 'B%';-- 4

select * from people
where Salesperson like '%y';-- 6

select * from people
where Salesperson like '%B%';

select * from sales;

-- Using CASE to create branching logic in SQL
select SaleDate,Amount,
	case when Amount<1000 then 'under 1k'
		when Amount<5000 then 'under 5k'
        when Amount<10000 then 'under 10k'
	    else '10k and more'
	end as 'amount_category'
		
 from sales
 order by Amount;