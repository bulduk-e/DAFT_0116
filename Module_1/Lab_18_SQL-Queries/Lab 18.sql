SELECT DISTINCT prime_genre FROM ironhack_examples.applestore; # 1. different genres

SELECT prime_genre, sum(rating_count_tot) # 2. genre with most apps rated
FROM ironhack_examples.applestore 
GROUP BY prime_genre;
ORDER BY sum(rating_count_tot) DESC
LIMIT 1;

SELECT DISTINCT prime_genre, count(prime_genre) from ironhack_examples.applestore    # 3. genre with most apps
GROUP BY prime_genre
ORDER BY count(prime_genre) DESC
LIMIT 1;

SELECT DISTINCT prime_genre, count(prime_genre) from ironhack_examples.applestore    # 4. genre with least apps
GROUP BY prime_genre
ORDER BY count(prime_genre) ASC
LIMIT 1;

SELECT track_name, rating_count_tot # 5 - top 10 apps most rated
FROM ironhack_examples.applestore
ORDER BY rating_count_tot DESC
LIMIT 10;

SELECT track_name, user_rating # 6 - top 10 apps best rated
FROM ironhack_examples.applestore
ORDER BY user_rating DESC
LIMIT 10;

# 7 - Question 5 insight: mostly social network (2), and games in this top10 (4 games), others are more life style (bible, calorie counter)

# 8 - Question 7 insight: various types of games, no clear pattern

# 9 - Comparing data from question 5 and 7: not at all the same games !

SELECT track_name, rating_count_tot, user_rating        # 10 - top 3 regarding both user ratings and number of votes
FROM ironhack_examples.applestore
ORDER BY user_rating DESC, rating_count_tot DESC
LIMIT 3;

SELECT price, sum(rating_count_tot), avg(user_rating), count(track_name)
FROM ironhack_examples.applestore
GROUP BY price
ORDER BY price;

