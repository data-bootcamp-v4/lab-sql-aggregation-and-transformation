-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;

-- Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(ROUND(AVG(length)) / 60) AS hours,
    ROUND(AVG(length)) % 60 AS minutes
FROM film;

-- Calculate the number of days that the company has been operating.
SELECT MIN(rental_date), MAX(rental_date)
FROM rental;

SELECT DATEDIFF('2006/02/14', '2005/05/24') AS number_days_operating;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_date,
    MONTHNAME(rental_date)   AS rental_month,
    DAYNAME(rental_date)     AS rental_weekday
FROM rental
LIMIT 20;

-- Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT
    rental_id,
    rental_date,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental;

-- Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- The total number of films that have been released.
SELECT COUNT(release_year) as total_films
FROM film;

-- The number of films for each rating.
-- The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT
    rating,
    COUNT(title) AS number_films
FROM film
GROUP BY rating
ORDER BY number_films DESC;

-- The mean film duration for each rating, and sort the results in descending order of the mean duration.
-- Identify which ratings have a mean duration of over two hours: PG-13
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- Determine which last names are not repeated in the table actor.
SELECT last_name, COUNT(last_name) AS n_last
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)= 1;
