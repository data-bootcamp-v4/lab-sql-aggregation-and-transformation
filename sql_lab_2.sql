USE sakila;
#challenge 1
#1.1 Determine the shortest and longest movie durations 
#and name the values as max_duration and min_duration

SELECT max(length) as max_duration, min(length) as min_duration
FROM film; 



#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.

SELECT 
  FLOOR(AVG(length) / 60) AS avg_hours, #for int typ
  ROUND(AVG(length)) % 60 AS avg_minutes
FROM film;

#You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating
#Hint: To do this, use the rental table, and the DATEDIFF() 
#function to subtract the earliest date in the rental_date column from the latest date

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select rental_id, date_format(rental_date, "%M") as month,
date_format(rental_date, "%W") as mwd
from rental;




#You need to ensure that customers can easily access information about the movie collection.
# To achieve this, retrieve the film titles and their rental duration. 
#If any rental duration value is NULL, replace it with the string 'Not Available'. 
#Sort the results of the film title in ascending order.

SELECT title,
    CASE 
        WHEN ISNULL(rental_duration) THEN 'Not Available'
        ELSE "available"
    END AS availability_movie
FROM film;


#challenge 2
#Next, you need to analyze the films in the collection to gain some more insights. 
#Using the film table, determine:
# The total number of films that have been released.

SELECT count(release_year) as released_movie
FROM film;

#The number of films for each rating.
SELECT rating, COUNT(film_id) AS rating_film
FROM film
group by rating
order by rating_film;

#The number of films for each rating, sorting the results in descending order of the number of films. 
#This will help you to better understand the popularity of different film ratings 
#and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) AS num_film
FROM film
group by rating
order by num_film desc;

# 2 
#Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending 
#order of the mean duration. Round off the average lengths to two decimal places. 
#This will help identify popular movie lengths for each category.

select rating, round(avg(length)) as mean_duration
from film
group by rating
order by mean_duration DESC;

 
#2.2 Identify which ratings have a mean duration of over two hours in order 
#to help select films for customers who prefer longer movies.
select rating, round(avg(length)) as mean_duration
from film
group by rating
having mean_duration > 120
order by mean_duration DESC;