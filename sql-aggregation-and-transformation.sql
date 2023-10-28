/* 1. As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
	- 1.1 Determine the **shortest and longest movie durations** and name the values as max_duration and min_duration.*/
SELECT *
FROM sakila.film;

SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM sakila.film;
       
	#- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals. *Hint: look for floor and round functions.*

#SELECT ROUND(AVG(sakila.film.length),0);

SELECT CONCAT(FLOOR(AVG(sakila.film.length)/60)," ", 'hours', " ", ROUND(AVG(length) %60), " ", 'minutes') as duration 
FROM sakila.film;

	/*- 2.1 Calculate the **number of days that the company has been operating**. 
    *Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from 
    the latest date.*/
    
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM sakila.rental;
    
	/* 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. 
    Return 20 rows of results.*/
    
    SELECT *, MONTH(rental_date) AS month, DAYNAME(rental_date) as weekday
    FROM sakila.rental
    LIMIT 20;
        
	/*- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values **'weekend' or 'workday'**, 
    depending on the day of the week. *Hint: use a conditional expression.*/
 
SELECT *, MONTH(rental_date) AS month, DAYNAME(rental_date) as weekday
FROM sakila.rental;
 
SELECT *, DAYNAME(rental_date) as weekday,
CASE
WHEN DAYNAME(rental_date) IN ('sunday', 'saturday') 
THEN 'Weekend'
ELSE 'Workday'
END as DAY_TYPE
FROM sakila.rental;

/* 3. film title and rental duration
- if rental duration "null" ---> "Not Available"
- Sort list by title ASC */

SELECT title, IFNULL(rental_duration, "Not Available") as availability
FROM sakila.film
ORDER BY sakila.film.title ASC;

/*4.  retrieve the concatenated first and last names of our customers
along with the first 3 characters of their email address, 
results should be ordered by last name in ascending order */

SELECT *
FROM sakila.customer;

SELECT CONCAT(first_name, " ", last_name) as customer_name, LEFT(email, 3) as email_3
FROM sakila.customer
ORDER BY last_name ASC;

/* CHALLANGE 2
1. Using the film table, determine:
1.1 The total number of films that have been released.*/

SELECT COUNT(film_id) AS films_released
FROM sakila.film;

# 1.2 The number of films for each rating.

SELECT DISTINCT COUNT(film_id) as num_film, film.rating
FROM sakila.film
GROUP BY film.rating;

/*1.3 The number of films for each rating, and sort the results in descending order of the number of films. 
This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.*/

SELECT DISTINCT COUNT(film_id) as num_film, film.rating 
FROM sakila.film 
GROUP BY film.rating
ORDER BY film.rating, num_film DESC;

/* 2. Using the rental table, determine the number of rentals processed by each employee. */
SELECT DISTINCT staff_id, COUNT(rental_id) as num_rental
FROM sakila.rental
GROUP BY staff_id;

/* 3. Using the film table, determine:
3.1 The mean film duration for each rating,
sort the results in descending order of the mean duration. 
Round off the average lengths to two decimal places. */

SELECT DISTINCT (rating), ROUND(AVG(length),2) as avg_len
FROM sakila.film
GROUP BY rating
ORDER BY avg_len DESC;

#3.2 Identify which ratings have a mean duration of over two hours

SELECT DISTINCT (rating), ROUND(AVG(length),2) as avg_len
FROM sakila.film
GROUP BY rating
HAVING AVG(length) >= 120
ORDER BY avg_len DESC;


# 4. Determine which last names are not repeated in the table actor.
SELECT last_name, COUNT(*) as num_last_name
FROM sakila.actor 
GROUP BY last_name
HAVING num_last_name = 1;