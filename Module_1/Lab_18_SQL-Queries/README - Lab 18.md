![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)
# Lab | My first queries

Please, download the file applestore.csv.
Install MySQL/Postgresql on your computer.
Create a database
Upload the file as a new table of your database

Use the *data* table to query the data about Apple Store Apps and answer the following questions: 

**1. What are the different genres?**
SELECT DISTINCT prime_genre FROM ironhack_examples.applestore

**2. Which is the genre with the most apps rated?**
SELECT prime_genre, sum(rating_count_tot)
FROM ironhack_examples.applestore 
GROUP BY prime_genre
ORDER BY sum(rating_count_tot) DESC
LIMIT 1;

**3. Which is the genre with most apps?**
SELECT DISTINCT prime_genre, count(prime_genre) from ironhack_examples.applestore
GROUP BY prime_genre
ORDER BY count(prime_genre) DESC
LIMIT 1;

**4. Which is the one with least?**
SELECT DISTINCT prime_genre, count(prime_genre) from ironhack_examples.applestore  
GROUP BY prime_genre
ORDER BY count(prime_genre) ASC
LIMIT 1;

**5. Find the top 10 apps most rated.**
SELECT track_name, rating_count_tot 
FROM ironhack_examples.applestore
ORDER BY rating_count_tot DESC
LIMIT 10;

**6. Find the top 10 apps best rated by users.**
SELECT track_name, user_rating
FROM ironhack_examples.applestore
ORDER BY user_rating DESC
LIMIT 10;

**7. Take a look at the data you retrieved in question 5. Give some insights.**
# mostly social network (2), and games in this top10 (4 games), others are more lifestyle but still diverse (bible, calorie counter)

**8. Take a look at the data you retrieved in question 6. Give some insights.**
# various types of app , no clear pattern

**9. Now compare the data from questions 5 and 6. What do you see?**
# not at all the same games !

**10. How could you take the top 3 regarding both user ratings and number of votes?**
SELECT track_name, rating_count_tot, user_rating       
FROM ironhack_examples.applestore
ORDER BY user_rating DESC, rating_count_tot DESC
LIMIT 3;
# top 3 regarding both user ratings and number of votes

**11. Do people care about the price of an app?** Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
# I am selecting the rating count and user rating, to give an idea of quantity and quality of the apps. I am also adding a count of track_name because I don't want to include in the analysis app that have very few
SELECT price, sum(rating_count_tot), avg(user_rating), count(track_name)
FROM ironhack_examples.applestore
GROUP BY price
ORDER BY price
# although prices doesn't affect much users rating (except free vs 0-3$), it does affect the number of ratings, until a certain point (no pattern for price above 4$). Above 5 dollars there isn't enough rating to investigate rigourously those ratings (>30 sample)

## Deliverables 
You need to submit a `.sql` file that includes the queries used to answer the questions above, as well as an `.md` file including your answers. 






