## CHALLENGE 1

#1.1
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM sakila.film;

#1.2
#SELECT AVG(length) ROUND(length/ 60, 0) AS hours
FROM sakila.film;

#?????????

#2.1
#SELECT DATEDIFF(DAY, MAX(rental_date), MIN(rental_data) AS days_difference
#FROM sakila.rental;
#??

# 2.2 Retrieve rental information and add two additional columns to show 
#the month and weekday of the rental. Return 20 rows of results.

# monthname e dayname

# 2.3 Retrieve rental information and add an additional column called 
# DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. 
# Hint: use a conditional expression

#3


#4


#CHALLENGE 2

#1.1; 
SELECT COUNT(film_id)
FROM sakila.film;

#1.2
SELECT rating, COUNT(film_id)
FROM sakila.film
GROUP BY rating;

#1.3
SELECT rating, COUNT(film_id)
FROM sakila.film
GROUP BY rating
ORDER BY rating DESC;

#2
SELECT staff_id, COUNT(rental_id)
FROM sakila.rental
GROUP BY staff_id;

#3.1
SELECT rating, AVG(length)
FROM sakila.film
GROUP BY rating;

#3.2
SELECT rating, AVG(length)
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;

SELECT title, length, rating
FROM sakila.film
HAVING length > 120 AND rating = "PG-13";

#4
SELECT DISTINCT last_name
FROM sakila.actor
