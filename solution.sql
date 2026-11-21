USE sakila;

-- Challenge 1.1.1: minimum and maximum runtime in minutes.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM film;

-- Challenge 1.1.2: round once before splitting the duration.
SELECT FLOOR(avg_minutes / 60) AS hours, MOD(avg_minutes, 60) AS minutes
FROM (SELECT ROUND(AVG(length)) AS avg_minutes FROM film) AS durations;

-- Challenge 1.2.1: elapsed calendar days from first to last rental.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days FROM rental;

-- Challenge 1.2.2: first 20 rentals in chronological order.
SELECT r.*, MONTHNAME(r.rental_date) AS rental_month,
       DAYNAME(r.rental_date) AS rental_weekday
FROM rental AS r ORDER BY r.rental_date, r.rental_id LIMIT 20;

-- Challenge 1.2.3 (bonus): WEEKDAY returns 5 and 6 for Saturday and Sunday.
SELECT r.*, CASE WHEN WEEKDAY(r.rental_date) IN (5, 6) THEN 'weekend'
                 ELSE 'workday' END AS DAY_TYPE
FROM rental AS r ORDER BY r.rental_date, r.rental_id;

-- Challenge 1.3: keep the fallback and numeric values in one text column.
SELECT title, IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film ORDER BY title, film_id;

-- Challenge 1.4 (bonus): customer name and email prefix.
SELECT CONCAT(first_name, ' ', last_name) AS customer_name,
       SUBSTRING(email, 1, 3) AS email_prefix
FROM customer ORDER BY last_name, first_name, customer_id;

-- Challenge 2.1.1: total films.
SELECT COUNT(*) AS total_films FROM film;

-- Challenge 2.1.2: film count by rating.
SELECT rating, COUNT(*) AS film_count FROM film GROUP BY rating;

-- Challenge 2.1.3: film count by rating, ranked by count.
SELECT rating, COUNT(*) AS film_count
FROM film GROUP BY rating ORDER BY film_count DESC, rating;

-- Challenge 2.2.1: round for display and sort by the unrounded average.
SELECT rating, ROUND(AVG(length), 2) AS avg_duration_minutes
FROM film GROUP BY rating ORDER BY AVG(length) DESC, rating;

-- Challenge 2.2.2: compare the unrounded average against 120 minutes.
SELECT rating, ROUND(AVG(length), 2) AS avg_duration_minutes
FROM film GROUP BY rating HAVING AVG(length) > 120 ORDER BY AVG(length) DESC, rating;

-- Challenge 2.3 (bonus): surnames that occur exactly once.
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1 ORDER BY last_name;
