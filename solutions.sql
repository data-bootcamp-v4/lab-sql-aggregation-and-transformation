USE sakila;

---------------------------------------------------
-- CHALLENGE 1
---------------------------------------------------

-- 1.1 Shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;


-- 1.2 Average movie duration in hours and minutes (sin decimales)
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    MOD(FLOOR(AVG(length)), 60) AS avg_minutes
FROM film;


-- 2.1 Number of days the company has been operating
-- (diferencia entre la fecha más antigua y la más reciente de rental_date)
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;


-- 2.2 Rental info + month + weekday (20 filas)
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;


-- 2.3 BONUS: Rental info + month + weekday + DAY_TYPE (weekend / workday)
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'   -- domingo (1) y sábado (7)
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;


-- 3. Film titles + rental_duration, reemplazando NULL por 'Not Available'
SELECT 
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 4. BONUS: nombre completo + primeros 3 caracteres del email, ordenado por apellido
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_first3
FROM customer
ORDER BY last_name ASC, first_name ASC;



---------------------------------------------------
-- CHALLENGE 2
---------------------------------------------------

-- 1.1 Total number of films
SELECT 
    COUNT(*) AS total_films
FROM film;


-- 1.2 Number of films for each rating
SELECT 
    rating,
    COUNT(*) AS films_per_rating
FROM film
GROUP BY rating;


-- 1.3 Number of films for each rating, sorted DESC by number of films
SELECT 
    rating,
    COUNT(*) AS films_per_rating
FROM film
GROUP BY rating
ORDER BY films_per_rating DESC;


-- 2.1 Mean film duration for each rating, rounded to 2 decimals, sorted DESC
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;


-- 2.2 Ratings with mean duration over 2 hours (120 minutes)
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120;


-- 3. BONUS: last names not repeated in actor table
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;
