# Target Business Case 
# 1 Exploratory Analysis

# 1.1 Data type of all columns in the "`target.customers`" table.

select column_name, data_type
from `target.INFORMATION_SCHEMA.COLUMNS`
where table_name = 'customers';


# 1.2 Get the time range between which the orders were placed.
select min(order_purchase_timestamp) as min_order_time, 
max(order_purchase_timestamp) as max_order_time
from `target.orders`;

# 1.3 Count the Cities & States of `target.customers` who ordered during the given period.
select customer_id, count(customer_city) as Cities_count, count(customer_state) as State_count
from `target.customers` group by customer_id;

# 2. In-depth Exploration:

# 2.1 Is there a growing trend in the no. of orders placed over the past years?
select extract(year from order_purchase_timestamp) as order_year,
count(*) as count_orders
from `target.orders`
group by order_year
order by order_year;
# Yes according to the order placed by the `target.customers` over the year there is increase in orders year by year

# 2.2 Can we see some kind of monthly seasonality in terms of the no. of orders being placed?
select extract(month from order_purchase_timestamp) as order_month,
count(*) as count_orders
from `target.orders`
group by order_month
order by order_month;


# 2.3 During what time of the day, do the Brazilian `target.customers` mostly place their orders? (Dawn, Morning, Afternoon or Night)
# 0-6 hrs : Dawn
# 7-12 hrs : Mornings
# 13-18 hrs : Afternoon
# 19-23 hrs : Night
select 
case 
  when extract(hour from order_purchase_timestamp) between 0 and 6
  then 'Dawn'
  when extract(hour from order_purchase_timestamp) between 7 and 12
  then 'Mornings'
  when extract(hour from order_purchase_timestamp) between 13 and 18
  then 'Afternoon'
  else 'Night'
end as time_of_day,
count(*) as no_of_orders
from `target.orders`
group by time_of_day;

# 3. Evolution of E-commerce orders in the Brazil region:

-- 3.1 Get the month-on-month number of orders placed in each state
with customer_orders as 
(select * from `target.orders` as o 
inner join `target.customers` as c 
on o.customer_id = c.customer_id)

select extract(month from order_purchase_timestamp) as month,
customer_state,
count(*) as no_of_orders
from customer_orders
group by month, customer_state
order by month, customer_state;

-- 3.2 How are the `target.customers` distributed across all the states?
select customer_state,count(distinct customer_id) as No_of_target_customers
from `target.customers`
group by customer_state
order by customer_state;

# 4. Impact on Economy: Analyse the money movement by e-commerce by looking at order prices, freight and others.

# 4.1 Get the % increase in the cost of orders from year 2017 to 2018 (include months between Jan to Aug only). You can use the "payment_value" column in the payments table to get the cost of orders.
with percentage_increase as
(select extract(year from o.order_purchase_timestamp) as year,
sum(p.payment_value) as cost_of_orders 
from `target.orders` as o 
join `target.payments` as p
on o.order_id = p.order_id
where order_purchase_timestamp between '2017-01-01' and '2018-08-31'
group by year)

select round((cost_of_orders - lag(cost_of_orders) over(order by cost_of_orders)) / lag(cost_of_orders) over(order by cost_of_orders), 2) * 100 as percentage_increase 
from percentage_increase;

# 4.2  Calculate the Total & Average value of order price for each state.
select c.customer_state,
sum(p.payment_value) as Total_Price_of_orders,
avg(p.payment_value) as Average_Price_of_orders
from `target.orders` as o 
join 
`target.payments` as p 
on o.order_id = p.order_id
join `target.customers` as c 
on o.customer_id = c.customer_id
group by c.customer_state;


# 4.3 Calculate the Total & Average value of order freight for each state.
select c.customer_state,
sum(oi.freight_value) as Total_Order_freight,
avg(oi.freight_value) as Average_Order_freight
from `target.order_items` as oi
join `target.orders` as o
on oi.order_id = o.order_id
join `target.customers` as c 
on o.customer_id = c.customer_id
group by c.customer_state;

# 5. Analysis based on sales, freight and delivery time.

# 5.1 Find the no. of days taken to deliver each order from the order’s purchase date as delivery time. Also, calculate the difference (in days) between the estimated & actual delivery date of an order.
select date_diff(order_delivered_customer_date, order_purchase_timestamp,day) as Delivered_in,
order_estimated_delivery_date - order_delivered_customer_date as Difference
from `target.orders`;

# 5.2 Find out the top 5 states with the highest & lowest average freight value.
with states_avg_payment as (
  select c.customer_state, avg(p.payment_value) as avg_freight
  from `target.orders` o
  join `target.payments` p on o.order_id = p.order_id
  join `target.customers` c on o.customer_id = c.customer_id
  group by c.customer_state  
)
select * from  
(
  select customer_state, avg_freight
  from states_avg_payment
  order by avg_freight desc
  limit 5
) highest  
union all
select * from
(
  select customer_state, avg_freight
  from states_avg_payment
  order by avg_freight asc 
  limit 5
) lowest;

# 5.3 Find out the top 5 states with the highest & lowest average delivery time.

with average_delivery as 
( 
  select c.customer_state,
  avg(date_diff(o.order_delivered_customer_date,o.order_purchase_timestamp,day)) as average_delivery_time
  from `target.orders` as o  
  join 
  `target.customers` as c
  on o.customer_id = c.customer_id
  group by c.customer_state
)

select * from
(select customer_state, average_delivery_time from average_delivery order by average_delivery_time desc limit 5) as high
union all
select * from 
(select customer_state, average_delivery_time from average_delivery order by average_delivery_time limit 5) as low;


# 5.4 Find out the top 5 states where the order delivery is really fast as compared to the estimated date of delivery. You can use the difference between the averages of actual & estimated delivery date to figure out how fast the delivery was for each state
with state_delivery as (
  select c.customer_state,  
    avg(date_diff(o.order_delivered_customer_date, o.order_purchase_timestamp,day)) as avg_actual_delivery,
    avg(date_diff(o.order_estimated_delivery_date , o.order_delivered_customer_date,day)) as avg_estimated_delivery 
  from target.orders o
  join target.customers c on o.customer_id = c.customer_id
  group by c.customer_state
)  
select customer_state, 
  avg_actual_delivery, 
  avg_estimated_delivery,
  (avg_estimated_delivery - avg_actual_delivery) as delivery_diff
from state_delivery
order by delivery_diff desc
limit 5;

# 6. Analysis based on the payments:

# 6.1 Find the month on month no. of orders placed using different payment types.
select format_date('%Y-%m',order_purchase_timestamp) as order_month,  
       payment_type, 
       count(*) as num_orders
from `target.orders` o
join `target.payments` p on o.order_id = p.order_id
group by order_month, payment_type
order by order_month;

# 6.2 2. Find the no. of orders placed on the basis of the payment instalments that have been paid.
select payment_installments,  
       count(*) as num_orders
from `target.orders` o 
join `target.payments` p on o.order_id = p.order_id
where payment_installments is not null
group by payment_installments
order by payment_installments;


# Actionable Insights and Recommendations

# 1. Top Customers by order Spend
select c.customer_id, 
       sum(p.payment_value) as total_spend
from `target.orders` o 
join `target.payments` p on o.order_id = p.order_id
join `target.customers` c on o.customer_id = c.customer_id
group by c.customer_id
order by total_spend desc
limit 10;


#2. Fatest Growing Categories
with yearly_sales as 
(
  select p.product_category, 
       extract(year from o.order_purchase_timestamp) as year,
       count(oi.order_id) as category_sales
from `target.order_items` oi
join `target.products` p on oi.product_id = p.product_id 
join `target.orders` o on oi.order_id = o.order_id
group by p.product_category, year
)

select product_category, year, category_sales,
lead(category_sales) over (partition by product_category order by year) as next_year_sales,
(lead(category_sales) over (partition by product_category order by year) - category_sales)/category_sales as growth_rate
from yearly_sales;

#3. Top Selling products
select p.product_id, 
       sum(oi.price) as total_sales
from `target.order_items` as oi
join `target.products` as p on oi.product_id = p.product_id
group by p.product_id
order by total_sales desc
limit 5;

# 4 Customer Review Analysis

# Average review score per product category
select
    p.product_category,
    avg(r.review_score) as avg_review_score
from
    `target.order_reviews` as r
join
    `target.order_items` as oi on r.order_id = oi.order_id
join 
    `target.products` p on oi.product_id = p.product_id
  
group by
    p.product_category
order by
    avg_review_score desc;


# 5. Optimizing Shipping Efficiency:
# Recommendation: Investigate and potentially optimize shipping processes in states with longer delivery times.
-- find states with longer delivery times
select
    c.customer_state,
    avg(date_diff(order_delivered_customer_date, order_purchase_timestamp, day)) as avg_delivery_time
from
    `target.orders` o
join
    `target.customers` c on o.customer_id = c.customer_id
where
    order_delivered_customer_date is not null
group by
    c.customer_state
order by
    avg_delivery_time desc;


# 6. analyze payment types and instalment usage trends
select
    extract(month from order_purchase_timestamp) as order_month,
    payment_type,
    count(*) as num_orders
from
    `target.payments` p
join
    `target.orders` o on p.order_id = o.order_id
group by
    order_month, payment_type
order by
    order_month;


