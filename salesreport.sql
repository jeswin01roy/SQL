select *from sales;

select *from people;

select s.SPID,s.SaleDate,s.Amount,p.Salesperson
from sales s
left join people p on s.spid=p.spid
order by Salesperson;

select *from products;

select s.SPID,s.SaleDate,s.Amount,pr.Product
from sales s
left join products pr on s.pid=pr.pid;

-- saledate,product category
select s.SaleDate,pr.Product,pr.Category
from sales s
left join products pr on s.pid=pr.pid;

-- sale date,region

select *from geo;

select s.SaleDate,g.Region
from sales s
left join geo g on s.geoid=g.geoid;



select s.SaleDate,s.Amount,p.Salesperson,p.Team,pr.Product
from sales s
left join people p on s.spid=p.spid
left join products pr on s.pid=pr.pid
where amount<500 -- 433
and Team='Delish'; -- 140

select *from people;

select s.SaleDate,s.Amount,p.Salesperson,p.Team,pr.Product
from sales s
left join people p on s.spid=p.spid
left join products pr on s.pid=pr.pid
where amount<500
and p.Team=''; -- 55

select *from geo;

select s.SaleDate,s.Amount,p.Salesperson,p.Team,pr.Product,g.Geo
from sales s
left join people p on s.spid=p.spid
left join products pr on s.pid=pr.pid
left join geo g on s.geoid=g.geoid
where amount<500
and p.Team='Delish'
and g.Geo in ('New Zealand','India');

select s.SaleDate,s.Amount,p.Salesperson,p.Team,pr.Product
from sales s
left join people p on s.spid=p.spid
left join products pr on s.pid=pr.pid
left join geo g on s.geoid=g.geoid
where amount<500
and p.Team='Delish'
and g.Geo in ('New Zealand','India')
order by s.SaleDate;

select *from sales;
select *from geo;

select g.GeoID,sum(Amount),avg(Amount),sum(Boxes)
from sales
group by GeoID;

select g.Geo,sum(Amount),avg(Amount),sum(Boxes)
from sales s
left join geo g on s.GeoID=g.GeoID
group by g.Geoid;

select pr.Category,sum(Amount)
from sales s
left join products pr on s.pid=pr.pid
group by pr.Category
order by sum(amount) desc;

select monthname(SaleDate) as per,sum(Amount) as revenew
from sales
group by per
order by revenew desc;


select s.spid,p.Salesperson,sum(Amount) as revenew 
from sales s
left join people p on s.spid=p.spid
group by s.spid
order by revenew desc;

select g.Geo,sum(Boxes) as box_count
from sales s 
left join products pr on s.pid=pr.pid
left join geo g on g.geoid=s.geoid
group by g.Geo
order by box_count desc;

-- 10. Count Products in Each Category
select Category,count(Product) as product_count
from products
group by Category;

-- 11. Display SaleDate, Amount, and Boxes from sales where Boxes are greater than 20
select *from sales;

select SaleDate,Amount,Boxes
from sales 
where Boxes>20;

-- 2. Join sales and people tables and display Salesperson and Amount only for records where Amount is greater than 800

select p.Salesperson,s.Amount
from sales s
left join people p on s.spid=p.spid
where Amount>800;

-- 3. Join sales and products tables and display Product name and Boxes sold

select pr.Product,s.Boxes as box_sold
from sales s
left join products pr on s.pid=pr.pid;


-- 4. Display all sales records where SaleDate is after '2022-01-01'

select *from sales where SaleDate > '2022-01-01';

-- 5. Join sales and geo tables and display Geo and total Boxes sold for each Geo (use GROUP BY)

select g.Geo,sum(s.Boxes) as boxes_sold
from sales s
left join geo g on s.geoid=g.geoid
group by g.Geo;

-- 6. Display team-wise total Boxes sold by joining sales and people tables

select p.Team,sum(Boxes) as boxes_sold
from sales s
left join people p on s.spid=p.spid
group by p.Team;


