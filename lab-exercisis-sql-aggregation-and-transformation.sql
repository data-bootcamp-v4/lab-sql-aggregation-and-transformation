USE sakila;

-- Challenge 1
-- 1 : You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 : Determine the **shortest and longest movie durations** and name the values as `max_duration`
-- 			and `min_duration`.
SELECT 
	MAX(length) AS 'max_duration',
    MIN(length) AS 'min_duration'
FROM film;
-- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
SELECT
	FLOOR(AVG(length)/ 60) AS avg_hours,
    ROUND(AVG(length) - FLOOR(AVG(length) / 60) * 60) AS avg_minutes
    FROM film;
-- 2 : You need to gain insights related to rental dates:
-- 2.1 Calculate the **number of days that the company has been operating**.
SELECT 
	MAX(rental_date) AS 'latest_rental_date',
    MIN(rental_date) AS 'first_rental_date'
FROM rental;
SELECT 
	DATEDIFF(MAX(rental_date), MIN(rental_date))
    AS days_open
FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show the **month and
-- 		weekday of the rental**. Return 20 rows of results.
SELECT 
	rental.*,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- Or:
SELECT 
	rental.*,
    MONTH(rental_date) AS rental_month,
    DAYOFWEEK(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- Or:
SELECT 
	rental.*,
    MONTH(rental_date) AS rental_month,
    WEEKDAY(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- I personally like this combination best:
SELECT 
	rental.*,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- 2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE`
-- 		with values **'weekend' or 'workday'**, depending on the day of the week.*
SELECT 
	rental.*,
    CASE
		WHEN WEEKDAY(rental_date) IN (0, 1, 2, 3, 4) 
		THEN 'workday'
		ELSE 'weekend'
		END AS DAY_TYPE
FROM rental
LIMIT 20;
-- 3. You need to ensure that customers can easily access information about the movie collection.
-- 		To achieve this, retrieve the **film titles and their rental duration**.
-- 		If any rental duration value is **NULL, replace** it with the string **'Not Available'**.
-- 		Sort the results of the film title in ascending order.
SELECT
	title,
	IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
-- 4. *Bonus: The marketing team for the movie rental company now needs to create a personalized
-- 		email campaign for customers. To achieve this, you need to retrieve the **concatenated first
-- 		and last names of customers**, along with the **first 3 characters of their email** address,
-- 		so that you can address them by their first name and use their email address to send
-- 		personalized recommendations. The results should be ordered by last name in ascending order
-- 		to make it easier to use the data.*
SELECT 
	CONCAT (first_name, ' ', last_name) AS `Full name`,
    SUBSTRING(email, 1, 3) AS `First 3 char of email`
FROM customer
ORDER BY last_name ASC;



-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights.
-- 		Using the `film` table, determine:
-- 1.1 The **total number of films** that have been released.
SELECT
	COUNT(film_id) AS total_films
FROM film;
-- - 1.2 The **number of films for each rating**.
SELECT
	rating,
	COUNT(film_id) AS total_films
FROM film
GROUP BY rating;
--  1.3 The **number of films for each rating, sorting** the results in descending order of
-- 		the number of films.
-- 		This will help you to better understand the popularity of different film ratings
-- 		and adjust purchasing decisions accordingly.
SELECT
	rating,
	COUNT(film_id) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;
-- 2. Using the `film` table, determine:
-- 2.1 The **mean film duration for each rating**, and sort the results in descending order of
-- 		the mean duration. Round off the average lengths to two decimal places. This will help
-- 		identify popular movie lengths for each category.
SELECT
	rating,
	ROUND(AVG(length), 2) as avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration ASC;
-- - 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select
-- 			films for customers who prefer longer movies.
SELECT
	rating,
	ROUND(AVG(length), 2) as avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration ASC;
-- 3. *Bonus: determine which last names are not repeated in the table `actor`.*
SELECT 
	last_name
FROM actor
GROUP BY (last_name)
HAVING COUNT(*) = 1;






















