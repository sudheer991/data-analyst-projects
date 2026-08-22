select * from zepto;

#if is there any null values
select * from zepto where Category is null or `name` is null 
or mrp is null or discountPercent is null or availableQuantity is null 
or discountedSellingPrice is null or weightInGms is null or outOfStock is null 
or quantity is null;

#different product categories
select distinct category from zepto;

#products in stock vs out of stock
select outOfStock,count(category) from zepto group by outOfStock;

#product names present multiple times
select name,count(name) from zepto group by name having count(name)>1 order by count(name) desc;

# data cleaning 
#products with price = 0
select * from zepto where mrp=0 or discountedSellingPrice=0;
delete from zepto where mrp=0;

#convert paise to rupees, before it is there in paise
update zepto set mrp=mrp/100.0, discountedSellingPrice=discountedSellingPrice/100.0;

#1. Find the top 10 best value products based on the discount percentage.
select distinct name,mrp,discountPercent from zepto order by discountPercent desc limit 10;

#2. What are the products with high MRP but out of stock?
select distinct name, mrp from zepto where mrp>300 and outOfStock="true" order by mrp desc;

#3. Calculate estimated revenue for each category
select distinct Category,sum(discountedSellingPrice*availableQuantity) as revenue from zepto group by Category order by revenue ;

#4. Find all products where MRP is greater than 500 and discount is less than 10%
select distinct name,mrp,discountPercent 
from zepto 
where mrp>500 and discountPercent<10 
order by mrp desc;

#5. Identify the top five categories offering the highest average discount percentage
select Category, avg(discountPercent) as avg_dis_per from zepto group by Category order by avg_dis_per desc limit 5;

#6. Find the price per gram for products above 100 gram and sort by best value
select distinct name,weightInGms,discountedSellingPrice, round((discountedSellingPrice/weightInGms),2) as price_per_gram 
from zepto 
where weightInGms>=100 
order by price_per_gram;

#7. Group the products into categories like low, medium, bulk
select distinct name, Category ,weightInGms,
case when weightInGms<1000 then "Low" 
	when weightInGms<5000 then "Medium"
    else "Bulk" end as weight_category from zepto order by weightInGms;

#8. What is the total inventory weight per category?
select distinct Category, sum(availableQuantity*weightInGms)as total_weight 
from zepto 
group by Category 
order by total_weight;

