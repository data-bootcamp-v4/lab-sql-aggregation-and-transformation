-- Challenge 1
-- 1.1 shortest and longest movie durations
USE sakila;
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;

-- 1.2 average movie duration in hours and minutes
SELECT FLOOR(ROUND(AVG(length))/60) AS hours,
ROUND(AVG(length) - FLOOR(ROUND(AVG(length))/60) * 60) AS minutes
FROM film;

-- 2.1 number of days the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 month and weekday of rental
SELECT * FROM rental;
SELECT *, DATE_FORMAT (rental_date, "%M") AS month, DATE_FORMAT (rental_date, "%W") as weekday
FROM rental
LIMIT 20;

-- 3. film titles and their rental duration
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title;

-- Challenge 2
-- 1.1 total number of films released
SELECT COUNT(*) AS total_number_films
FROM film;

-- 1.2 number of films per rating
SELECT rating, COUNT(rating) AS number_films_rating
FROM film
GROUP BY rating;

-- 1.3 sorting 1.2 by descending order
SELECT rating, COUNT(rating) AS number_films_rating
FROM film
GROUP BY rating
ORDER BY number_films_rating DESC;

-- 2.1 mean film duration per rating
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 rating with mean duration of over 2 hours
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

-- 3. Bonus: last_names not repeated in actor table
SELECT last_name, COUNT(*) AS occurrences
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;




