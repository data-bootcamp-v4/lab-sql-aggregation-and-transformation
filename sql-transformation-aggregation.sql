USE sakila;

-- CHALLENGE 1
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT * FROM film;
SELECT MAX(length) AS max_duration
FROM film;
SELECT MIN(length) AS min_duration
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals
SELECT 
  FLOOR(AVG(length) / 60) AS hours,
  FLOOR(MOD(AVG(length), 60)) AS minutes
FROM film;

-- 2.1 Calculate the number of days that the company has been operating
SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results
SELECT * FROM rental;
SELECT *,
  DATE_FORMAT(rental_date, '%M') AS month,
  DATE_FORMAT(rental_date, '%W') AS day
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT * FROM rental;
SELECT rental_date,
CASE 
     WHEN DATE_FORMAT(rental_date, '%W') = 'Saturday' OR 'Sunday' THEN 'weekend'
    ELSE 'weekday'
END AS 'DAY_TYPE'
FROM rental;

-- 3 Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title,
  CASE 
    WHEN rental_duration IS NULL THEN 'Not Available'
    ELSE rental_duration
  END AS rental_duration
FROM film
ORDER BY title ASC;

-- 4 Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address;
-- Sort by last name in ascending order
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3) AS email_3
FROM customer
ORDER BY last_name ASC;


-- CHALLENGE 2

-- 1.1 Find the total number of films that have been released
SELECT * FROM film;
SELECT COUNT(*) AS total_released FROM film
WHERE release_year IS NOT NULL;

-- 1.2 The number of films for each rating
SELECT * FROM film;
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places
SELECT rating, ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

-- 3 Determine which last names are not repeated in the table actor
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
