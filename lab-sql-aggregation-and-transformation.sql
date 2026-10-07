# CHallenge 1
# 1.1 Determine the shortest and longest movie durations 
USE sakila;

SELECT MAX(length) AS max_duration, 
	MIN(length) AS min_duration 
FROM film;

# 1.2. Express the average movie duration in hours and minutes
SELECT 
	FLOOR(AVG(length) / 60) AS hours,
	ROUND(AVG(length) % 60) AS minutes
FROM film;

# 2.1 Calculate the number of days that the company has been operating
SELECT 
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
    FROM rental;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental.
SELECT rental_id, rental_date, MONTHNAME(rental_date), DAYNAME(rental_date) 
FROM rental LIMIT 20;

# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week
SELECT rental_id, rental_date, MONTHNAME(rental_date),  
	CASE 
		WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
	ELSE 'workday'
	END AS DAY_TYPE 
FROM rental LIMIT 20;

# 3. You need to ensure that customers can easily access information about the movie collection. 
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

# 4. Bonus retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address
SELECT CONCAT(first_name,' ', last_name) AS customer_info, LEFT (email, 3)
FROM customer
ORDER BY last_name ASC;

# Challenge 2
# 1.1 The total number of films that have been released.
SELECT COUNT(film_id)
FROM film
;

# 1.2: The number of films for each rating
SELECT rating, COUNT(film_id) AS rating_count
FROM film
GROUP BY rating;

# 1.3: The number of films for each rating, sorting the results in descending order of the number of films
SELECT rating, COUNT(film_id) AS rating_count 
FROM film
GROUP BY rating
ORDER BY rating_count DESC;

# 2.1 The mean film duration for each rating
SELECT rating, ROUND(AVG(length) , 2) AS AVG_length
FROM film
GROUP BY rating
ORDER BY AVG_length DESC;

# 2.2 Identify which ratings have a mean duration of over two hours
SELECT rating, ROUND(AVG(length) , 2) AS AVG_length
FROM film
GROUP BY rating
HAVING AVG_length > 120
ORDER BY AVG_length DESC;

# 3. Bonus: determine which last names are not repeated in the table actor.

SELECT last_name 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;