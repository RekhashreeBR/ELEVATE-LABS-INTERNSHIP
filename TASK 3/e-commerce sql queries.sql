use ecommerce;
select * from fact_table;
select * from item_dim;
select * from store_dim;
select * from trans_dim;

select division, district, upazila from store_dim where division= "SYLHET" and district = "MAULVIBAZAR";
select * from store_dim where  division in ("RANGPUR","SYLHET","KHULNA","CHITTAGONG");
select item_name, desce, man_country, unit_price from item_dim order by unit_price;
select store_key ,district 
from store_dim 
where store_key 
in (
select sum(store_key) 
from fact_table 
where total_price >=500
);

select desce, count(man_country) 
from item_dim 
group by desce;

select distinct man_country 
from item_dim;

create view item_detail as
select fact_table.item_key ,item_dim.item_name,item_dim.desce,item_dim.supplier, fact_table.quantity,fact_table.unit,fact_table.total_price
from fact_table join item_dim on fact_table.item_key = item_dim.item_key ;

select * from item_detail;
select man_country,avg(quantity) "avg quantity sold",avg(total_price) "avg price recieved "
from item_detail group by man_country;

select fact_table.item_key,item_dim.item_name,fact_table.quantity,fact_table.total_price,fact_table.payment_key,trans_dim.trans_type,trans_dim.bank_name
from fact_table
join item_dim on fact_table.item_key= item_dim.item_key
join trans_dim  on fact_table.payment_key = trans_dim.payment_key
;

create INDEX idx_payment_item on fact_table(item_name(10), quantity(10));
explain
select fact_table.item_key,item_dim.item_name,fact_table.quantity,fact_table.total_price,fact_table.payment_key,trans_dim.trans_type,trans_dim.bank_name
from fact_table
join item_dim on fact_table.item_key= item_dim.item_key
join trans_dim  on fact_table.payment_key = trans_dim.payment_key
;

