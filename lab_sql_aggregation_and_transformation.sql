-- Question 1.1: Determine the shortest & longest movie durations and name the values as max_duration and min_duration.
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- Q1.2: Express the average movie duration in hours and minutes without using decimals.
SELECT
    FLOOR(AVG(length) / 60) AS average_hours,
    ROUND(AVG(length) % 60) AS average_minutes
FROM film;

-- Q2.1: Calculate the number of days that the company has been operating using the earliest and latest rental_date values.
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- Q 2.2: Retrieve rental information  & add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Q3: Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by film title in ascending order.
SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 2 - Q 1.1: Determine the total number of films that have been released.
SELECT
    COUNT(*) AS total_films
FROM film;

-- Challenge 2 - Q 1.2: Determine the number of films for each rating.
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Challenge 2 - Q 1.3: Determine the number of films for each rating, sorting the results in descending order of the number of films.
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Challenge 2 - Q 2.1: Determine the mean film duration for each rating, sort the results in descending order of the mean duration, and round the average lengths to two decimal places.
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

-- Challenge 2 - Q 2.2: Identify which ratings have a mean duration of over two hours.
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;