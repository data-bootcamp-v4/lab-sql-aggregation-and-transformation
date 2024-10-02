use sakila;

#length: The duration of the film, in minutes.
#Challenge 1:
#1.1
select MAX(length) AS max_duration
from film;

select MIN(length) AS min_duration
from film;

#1.2 average movie duration in hours and minutes
select  ROUND(AVG(length)/60,0) AS average_hour , ROUND(AVG(length),0) AS average_minutes
from film;

#2.1 Calculate the number of days that the company has been operating
select  SUM(DATEDIFF(return_date , rental_date)) AS number_days
from rental; 

#2.2 
SELECT *, DATE_FORMAT(rental_date, '%M') AS rental_month, DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

# 2.3 Bonus Retrieve rental information and add an additional column 
# called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *, 
CASE
	WHEN DATE_FORMAT(rental_date, '%w') in (0,6) THEN 'weekend'
    WHEN DATE_FORMAT(rental_date, '%w') BETWEEN 2 AND 5 THEN 'workday'
END as DAY_TYPE
FROM rental;

# 3 You need to ensure that customers can easily access information about the movie collection.
# To achieve this, retrieve the film titles and their rental duration. 
# If any rental duration value is NULL, replace it with the string 'Not Available'.
# Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration,'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#4 Bonus: personalized email campaign for customers.
SELECT CONCAT(first_name , substring(email,1,3) )
FROM customer;

#Challenge 2:
# 1.1 The total number of films that have been released.
select  COUNT(release_year)
from film
WHERE release_year IS NOT NULL;

#1.2 The number of films for each rating.
SELECT rating,SUM(film_id) AS number_per_rating
FROM film
GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating,SUM(film_id) AS number_per_rating
FROM film
GROUP BY rating
ORDER BY SUM(film_id) DESC;

#2.1  The mean film duration for each rating
SELECT rating,ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

#2.2 
select ROUND(AVG(length)/60,0) AS average_hour
from film;

# 2.2 Identify which ratings have a mean duration of over two hours in order
# to help select films for customers who prefer longer movies.
select DISTINCT rating
from film
WHERE (select  ROUND(AVG(length)/60,0)
from film) ;

# 3 Bonus: determine which last names are not repeated in the table actor.
select last_name AS last_name_not_repeated
from actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;


