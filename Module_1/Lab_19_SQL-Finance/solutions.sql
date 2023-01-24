use olist;

# Question 1 : From order_items Highest priced order
SELECT price FROM order_items 
ORDER BY price DESC
LIMIT 1; 
# Answer: 6735

# Question 1 : From order_items Lowest priced order
SELECT price FROM order_items  
ORDER BY price ASC
LIMIT 1; 
# Answer: 0.85

# Question 2 : From order_items range of shipping_limit_day
SELECT MIN(shipping_limit_date), MAX(shipping_limit_date) FROM order_items
;
# Answer : 2016-09-19 02:15:34 -	2020-04-10 00:35:08

# Question 3: From customers find the states with the greatest number of customers
SELECT  customer_state, count(customer_state) FROM customers
GROUP BY customer_state
ORDER BY count(customer_state) DESC
LIMIT 1;
# Answer: SP	41746

# Question 4 :  From customers within the state with the greatest number of customers, find the cities with the greatest number of customers.
SELECT customer_city, count(customer_city) FROM customers
WHERE customer_state = "SP"
GROUP BY customer_city
ORDER BY count(customer_city) DESC
LIMIT 1;
# Answer: sao paulo	15540

# Question 5: From closed_deals how many distinct business segments are there (not including null)
SELECT COUNT(DISTINCT(business_segment)) FROM closed_deals
WHERE business_segment IS NOT NULL ;
# Answer: 33

# Question 6:  From closed_deals sum the declared_monthly_revenue for duplicate row values in business_segment 
# and find the 3 business segments with the highest declared monthly revenue
SELECT business_segment, sum(declared_monthly_revenue) FROM closed_deals
GROUP BY business_segment
ORDER BY sum(declared_monthly_revenue) DESC
LIMIT 3;
# Answer: construction_tools_house_garden	50695006 ; phone_mobile	8000000 ; home_decor	710000

# Question 7: From order_reviews find the total number of distinct review score values
SELECT DISTINCT(review_score) FROM order_reviews;
SELECT count(DISTINCT(review_score)) FROM order_reviews;
# Answer: 5 (1, 2, 3, 4, 5)

# Question 8: order_reviews table, create a new column with a description that corresponds to each number category 
# for each review score from 1 - 5, then find the review score and category occurring most frequently 
# in the table
# 5: Excellent / 4: Good / 3: Average / 2: Bad / 1: Horrible
ALTER TABLE order_reviews ADD review_description VARCHAR(20);

UPDATE order_reviews
SET review_description = 'Excellent'
WHERE review_score = 5;

UPDATE order_reviews
SET review_description = 'Good'
WHERE review_score = 4;

UPDATE order_reviews
SET review_description = 'Average'
WHERE review_score = 3;

UPDATE order_reviews
SET review_description = 'Bad'
WHERE review_score = 2;

UPDATE order_reviews
SET review_description = 'Horrible'
WHERE review_score = 1;

# Checking if it works
SELECT review_score, review_description FROM order_reviews;

# Find the review score & category
SELECT review_description, COUNT(review_description) FROM order_reviews
GROUP BY review_description
ORDER BY COUNT(review_description) DESC;
#Excellent	57420
#Good	19200
#Horrible	11858
#Average	8287
#Bad	3235

# Find the review score & category
SELECT review_score, COUNT(review_score) FROM order_reviews
GROUP BY review_score
ORDER BY COUNT(review_score) DESC;
# Answer : 
#5	57420
#4	19200
#1	11858
#3	8287
#2	3235

#Answer: same value

# Question 9 : order_reviews table, find the review value occurring most frequently and how many times it occurs.
SELECT review_description, COUNT(review_description) FROM order_reviews
GROUP BY review_description
ORDER BY COUNT(review_description) DESC
LIMIT 1;