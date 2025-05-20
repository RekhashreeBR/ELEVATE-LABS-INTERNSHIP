create database sales ;
show databases;
use sales;
show tables;
select * from sales_data ;

# ADDING A MONTH_ONLY COLUMN INTHE DATASET 
alter table sales_data add column month_only int ;
SET SQL_SAFE_UPDATES = 0 ;
update sales_data set month_only = EXTRACT(month from OrderDate);
SET SQL_SAFE_UPDATES = 1 ;
select * from sales_data ;


# volumn oF orders in each month 
select  month_only, count(OrderID)  from sales_data group by month_only order by month_only;

# volumn of orders more than 100
select  month_only, count(OrderID)  from sales_data group by month_only having count(OrderID)> 100 ;

#  top 7 months with highest orders
select month_only, count(OrderID) from sales_data group by month_only order by count(OrderID) desc limit 7;


# revenue generated in each month with the orders placed
select month_only , sum(Amount), count(OrderID) from sales_data group by month_only ;

# top 7 months with highest revenue
select month_only,sum(Amount), count(OrderID) from sales_data group by month_only order by count(OrderID) desc limit 7;

# count distinct order id
select count(distinct OrderID) from sales_data ;

# distinct order id iN each month
select month_only ,count(distinct OrderID) from sales_data group by month_only ;

# count distinct order id of top 7 months along with revenue
select month_only,sum(Amount) ,count(distinct OrderID) from sales_data group by month_only order by count(OrderID) desc limit 7;


