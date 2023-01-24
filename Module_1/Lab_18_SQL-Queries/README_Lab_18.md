![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)
# Lab | My first queries

Please, download the file applestore.csv.
Install MySQL/Postgresql on your computer.
Create a database
Upload the file as a new table of your database

Use the *data* table to query the data about Apple Store Apps and answer the following questions: 

**1. What are the different genres?**
Games
Productivity
Weather
Shopping
Reference
Finance
Music
Utilities
Travel
Social Networking
Sports
Business
Photo & Video
Navigation
Entertainment
Education
Lifestyle
Food & Drink
News
Health & Fitness
Medical
Book

**2. Which is the genre with the most apps rated?**
Games	8717381

**3. Which is the genre with most apps?**
Games	169

**4. Which is the one with least?**
Medical	1

**5. Find the top 10 apps most rated.**
Facebook	2974676
Pandora - Music & Radio	1126879
Pinterest	1061624
Bible	985920
Angry Birds	824451
Fruit Ninja Classic	698516
Solitaire	679055
PAC-MAN	508808
Calorie Counter & Diet Tracker by MyFitnessPal	507706
The Weather Channel: Forecast, Radar & Alerts	495626

**6. Find the top 10 apps best rated by users.**
The Photographer's Ephemeris	5
J&J Official 7 Minute Workout	5
Daily Audio Bible App	5
Plants vs. Zombies	5
Learn English quickly with MosaLingua	5
Domino's Pizza USA	5
Kurumaki Calendar -month scroll calendar-	5
Fragment's Note	5
Dragon Island Blue	5
TurboScan Pro - document & receipt scanner: scan multiple pages and photos to PDF	5

However, there are slightly more option with max ratings (5)

**7. Take a look at the data you retrieved in question 5. Give some insights.**
Mostly social network (2), and games in this top10 (4 games), others are more lifestyle but still diverse (bible, calorie counter)

**8. Take a look at the data you retrieved in question 6. Give some insights.**
Various types of app , no clear pattern

**9. Now compare the data from questions 5 and 6. What do you see?**
Not at all the same apps !

**10. How could you take the top 3 regarding both user ratings and number of votes?**
Plants vs. Zombies	426463	5
Domino's Pizza USA	258624	5
Plants vs. Zombies HD	163598	5
The top 3 regarding ratings count among those with 5 as rating

**11. Do people care about the price of an app?** Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
I am selecting the rating count and user rating, to give an idea of quantity and quality of the apps. I am also adding a count of track_name because I don't want to include in the analysis app that have very few.
Although prices doesn't affect much users rating (except free vs 0-3$), it does affect the number of ratings, until a certain point (no pattern for price above 4$). Above 5 dollars there isn't enough rating to investigate rigourously those ratings (>30 sample)

The request:
SELECT price, sum(rating_count_tot), avg(user_rating), count(track_name)
FROM ironhack_examples.applestore
GROUP BY price
ORDER BY price


## Deliverables 
You need to submit a `.sql` file that includes the queries used to answer the questions above, as well as an `.md` file including your answers. 






