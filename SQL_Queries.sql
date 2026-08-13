select * from customer limit 10;

--q1) total revenue generate by mal
select gender, sum(purchase_amount) as revenue
from customer 
group by gender;

--q2) Which customeru used a discount but still spend more than the avg purchase amount?
select customer_id, purchase_amount
from customer 
where discount_applied = 'Yes' and purchase_amount >= (select avg(purchase_amount) from customer);

--q3) Which are top 5 products with the highest avg review rating?
select item_purchased,round(avg(review_rating :: numeric),2) as avg_review_rating
from customer
group by item_purchased order by avg_review_rating desc limit 5;

--q4) Compare the avg purchase amounts between standard and express shipping.
select shipping_type, round(avg(purchase_amount),2) as avg_purchase_amount
from customer
where shipping_type in ('Standard','Express')
group by shipping_type order by avg_purchase_amount desc;

--q5) Do subscribed customers spend more? Compare avg spend and total revenue between subscribers and non-subscribers.
select subscription_status, count(customer_id) as total_customers,  round(avg(purchase_amount),2) as avg_spend, sum(purchase_amount) as total_revenue
from customer
group by subscription_status
order by total_revenue desc;

--q6) Which 5 products have the highest % of purchases with discounts applied?
select item_purchased, round(avg(case when discount_applied = 'Yes' then 1 else 0 end)* 100.0,2) as percentage_of_purchase
from customer
group by item_purchased
order by percentage_of_purchase desc
limit 5;

--q7) Segment customers into new, returning and loyal based on their total number of previous purchases, and show the count of each segment.
with t1 as(select customer_id, previous_purchases, 
case when previous_purchases between 2 and 10 then 'Returning Customer'
when previous_purchases > 10 then 'Loyal Customer'
else 'New Customer' end as customer_segements
from customer)
select customer_segements, count(customer_id) as total_customers
from t1
group by customer_segements
order by total_customers desc;

--q8) What are the top 3 most purchased(best sellers) products within each category?
with t1 as(
select category, item_purchased,count(item_purchased) as total_purchases, row_number() over(partition by category order by count(item_purchased) desc) as rn
from customer
group by category, item_purchased
)
select rn,category,item_purchased, total_purchases from t1
where rn <= 3;

--q9) Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
select subscription_status, sum(case when previous_purchases > 5 then 1 else 0 end) as total_customers
from customer
group by subscription_status
order by total_customers desc;

--q10) what is the revenue contribution of each age group?
select age_group, sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc; 