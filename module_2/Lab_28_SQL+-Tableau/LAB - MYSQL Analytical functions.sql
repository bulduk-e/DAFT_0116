/* find the running total of rental payments for each customer in the payment table, 
ordered by payment date. By selecting the customer_id, payment_date, and amount columns from the payment table, 
and then applying the SUM function to the amount column within each customer_id partition, ordering by payment_date.
*/

USE sakila;
SELECT 
	customer_id, 
    payment_date,
    amount,
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total_payment
FROM payment;

/* find the rank and dense rank of each payment amount within each payment date by selecting 
the payment_date and amount columns from the payment table, and then applying the RANK and 
DENSE_RANK functions to the amount column within each payment_date partition, ordering by amount in descending order.
*/
SELECT 
    DATE(payment_date),
    amount,
    RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS rank_payment,
    DENSE_RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS dense_rank_payment
FROM payment;

/* find the ranking of each film based on its rental rate, within its respective category */

SELECT
	category.name,
    film.title,
    film.rental_rate,
    RANK() OVER (PARTITION BY DATE(film.rental_rate) ORDER BY film.rental_rate DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY DATE(film.rental_rate) ORDER BY film.rental_rate DESC) AS dens_rnk    
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id;

/* update the previous query from above to retrieve only the top 5 films within each category */
SELECT * FROM
(
	SELECT
		category.name,
		film.title,
		film.rental_rate,
		RANK() OVER (PARTITION BY DATE(film.rental_rate) ORDER BY film.rental_rate DESC) AS rnk,
		DENSE_RANK() OVER (PARTITION BY DATE(film.rental_rate) ORDER BY film.rental_rate DESC) AS dens_rnk,
		ROW_NUMBER() OVER (PARTITION BY DATE(film.rental_rate) ORDER BY film.rental_rate DESC) AS row_num 
	FROM film
	INNER JOIN film_category ON film.film_id = film_category.film_id
	INNER JOIN category ON film_category.category_id = category.category_id
) x
WHERE row_num <6;

/* find the difference between the current and previous payment amount and the difference 
between the current and next payment amount, for each customer in the payment table */

SELECT
	payment_id,
    customer_id,
    amount,
    payment_date,
    amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS diff_from_prev,
    amount - LEAD(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS diff_from_next
FROM payment;