-- ============================================
-- LAB | SQL Data Aggregation and Transformation
-- ============================================

-- --------------------------------------------
-- CHALLENGE 1.1 : min / max film duration
-- --------------------------------------------
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- --------------------------------------------
-- CHALLENGE 1.2 : average duration in h/min
-- --------------------------------------------
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

-- --------------------------------------------
-- CHALLENGE 2.1 : days the company has operated
-- --------------------------------------------
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- --------------------------------------------
-- CHALLENGE 2.2 : rental info + month + weekday
-- --------------------------------------------
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- --------------------------------------------
-- CHALLENGE 2.3 (bonus) : DAY_TYPE column
-- --------------------------------------------
SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

-- --------------------------------------------
-- CHALLENGE 3 : titles + rental_duration (NULL safe)
-- --------------------------------------------
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- --------------------------------------------
-- CHALLENGE bonus : customer email campaign
-- --------------------------------------------
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- --------------------------------------------
-- CHALLENGE 2 - 1.1 : total number of films
-- --------------------------------------------
SELECT COUNT(*) AS total_films
FROM film;

-- --------------------------------------------
-- CHALLENGE 2 - 1.2 : number of films per rating
-- --------------------------------------------
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- --------------------------------------------
-- CHALLENGE 2 - 1.3 : films per rating, desc
-- --------------------------------------------
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- --------------------------------------------
-- CHALLENGE 2 - 2.1 : mean duration per rating
-- --------------------------------------------
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- --------------------------------------------
-- CHALLENGE 2 - 2.2 : ratings with mean > 120 min
-- --------------------------------------------
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- --------------------------------------------
-- CHALLENGE 2 - bonus : non-repeated last names
-- --------------------------------------------
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;