Use sakila;

/**Determine the shortest and longest film Duration**/
SELECT 
	min(length) AS min_duration,
    max(length) AS max_duration
FROM film;

/**Average of moviesd duration hours/minuts **/
SELECT 
	floor(AVG(length) / 60) AS avg_hours,
    floor(AVG(length) % 60) AS avg_minutes
From film;

/**Calculate the number of days the company has been operating**/
SELECT datediff(
	(SELECT MAX(rental_date) FROM rental),
    (SELECT MIN(rental_date) FROM rental)
) AS days_operating;

/**Retrieve rental information and add two columns for the month and weekday of the rental**/
SELECT 
	rental_id,
    customer_id,
    staff_id,
    rental_date,
    month(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
Limit20;

/**Bonus: Retrieve rental info and add a DAY_TYPE column indicating weekend or workday**/
SELECT 
	rental_id,
    customer_id,
    staff_id,
    rental_date,
    case
		WHEN dayofweek(rental_date) IN (1 , 7) THEN "weekend"
		ELSE "workday"
	END AS DAY_TYPE
FROM rental
Limit 20;

/** customer easy access on the information**/
SELECT 
	title,
    IFNULL(rental_duration, "NOT Available") AS rental_duration
FROM film
ORDER BY title asc;

/**personalize cutomers marketing email**/
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS short_email
FROM customer
ORDER BY last_name ASC;

-- *** CHALENGE 2 *** --

/** The total number of films that have been released**/
SELECT count(*) AS total_film
FROM film;

/**The number of films for each rating**/
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

/**The number of films for each rating, sorted in descending order of the number of films**/
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

/**Mean film duration for each rating (descending order), rounded to two decimals**/
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

/**Ratings with a mean duration over two hours**/
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

/*** Bonus: Last names not repeated in the actor table**/
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;





