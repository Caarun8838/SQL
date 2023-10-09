select * from sales;
select * from product;
select * from users;
select * from  goldusers_signup;


1) what is the total amount each customer spent on zomato?

select sales.user_id,sum(product.price) total_amt_spent from sales inner join product on sales.product_id=product.product_id
group by sales.user_id;


2) how many days has each customer visited zomato?

select user_id,count (distinct created_at) distinct_days from sales group by user_id;

3)what was the first product purchased by the each customer?
select * from
(select *,rank() over (partition by user_id order by created_at) rnk from sales) a where rnk =1

4) what is the most purchased item on the menu and how many times was it purchased by all customers?

select user_id,count(product_id) cnt from sales where product_id =
(select top 1 product_id from sales group by product_id order by count(product_id) desc)
group by User_id;

5)which item was the most popular for each customer?
select * from
(select *,rank() over(partition by user_id order by cnt desc)rnk from 
(select user_id,product_id,count(product_id) cnt from sales group by user_id,product_id)sales)
b where rnk = 2