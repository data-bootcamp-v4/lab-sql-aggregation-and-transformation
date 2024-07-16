#You need to use SQL built-in functions to gain insights relating to the duration of movies:
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select  max(length) as "max_duration", min(length) as "min_duration"
from film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(AVG(length) / 60) AS Hours,
    ROUND(AVG(length) % 60) AS inutes
FROM 
    film;
#You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(
    (SELECT MAX(rental_date) FROM rental),
    (SELECT MIN(rental_date) FROM rental)
) AS days_operating

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_id, 
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

# Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

select rental_id, rental_date,
CASE
	WHEN DAYNAME(rental_date) = "Saturday" or DAYNAME(rental_date) = "Sunday" THEN "WEEKEND"
    ELSE "Workday"
END AS DAY_TYPE 
FROM rental   ;

#You need to ensure that customers can easily access information about the movie collection. 
#To achieve this, retrieve the film titles and their rental duration. 
#If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

select title, IFNULL(rental_duration, "Not available") as "rental duration"
from film
order by title asc;

#Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.

select count(film_id) as "number of released movies"
from film;

#1.2 The number of films for each rating.

select rating, count(*) as "number of films per rating"
from film
group by rating;

#1.3 The number of films for each rating, sorting the results in 
#descending order of the number of films. 

select rating, count(*) as "number of films per rating"
from film
group by rating
order by count(*) desc;

#2.1 The mean film duration for each rating, and sort the results in 
#descending order of the mean duration. Round off the average lengths 
#to two decimal places. This will help identify popular movie lengths 
#for each category.

select rating, round(avg(length),2) as "avg time per rating"
from film
group by rating
order by avg(length) desc;

#2.2 Identify which ratings have a mean duration of over two hours in 
#order to help select films for customers who prefer longer movies.

select rating, round(avg(length),2) as "avg time per rating"
from film
group by rating
having avg(length) > 120
order by avg(length) desc;

#Bonus: determine which last names are not repeated in the table actor.

select count(*) as "Not repeated last names"
from actor
group by last_name
having count(*) = 0;




