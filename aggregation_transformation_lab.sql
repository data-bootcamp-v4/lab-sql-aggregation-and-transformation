use sakila;

#CHALLENGE 1

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT max(length) as max_duration, min(length) as min_duration
FROM film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(length)/60) as hours, FLOOR(AVG(length))%60 as minutes
FROM film;

#2.1 Calculate the number of days that the company has been operating
# Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT datediff(max(rental_date),min(rental_date)) as number_of_days_open
FROM rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT 
    rental.*,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

# 3. You need to ensure that customers can easily access information about the movie collection. 
# To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, 
# replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
 
 SELECT title, rental_duration,
	CASE
		WHEN rental_duration IS NULL THEN 'Not Available'
        WHEN rental_duration > 0 THEN 'Available'
        END AS availability
 from film
 ORDER BY title ASC;

#CHALLENGE 2

#1. Analyze the films in the collection to gain some more insights. Using the film table, determine
#1.1 The total number of films that have been released

select count(title) AS movies_released
from film;

#1.2 The number of films for each rating

select rating, count(title) as number_of_films
from film
group by rating;

#1.3 The number of films for each rating sorting the result in escending order of the number of films

select rating, count(title) as number_of_films
from film
group by rating
order by number_of_films DESC;

#2.1

select rating, round(avg(length),2) as average_duration_time, count(title) as number_of_films
from film
group by rating
order by number_of_films DESC;

#2.2
SELECT rating, ROUND(AVG(length),2) as avglength
FROM film
GROUP BY rating
HAVING  avglength > 120;