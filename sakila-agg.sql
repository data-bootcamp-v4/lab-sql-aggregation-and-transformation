USE sakila;

SELECT title, length FROM film ORDER BY length ASC LIMIT 1;
SELECT title, length FROM film ORDER BY length DESC LIMIT 1;

SELECT SEC_TO_TIME(ROUND(AVG(length)) * 60) AS avg_running_time FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating FROM rental;

SELECT *,MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_day FROM rental LIMIT 20;

SELECT *, DAYNAME(rental_date) AS rental_day,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

SELECT title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM film 
ORDER BY title ASC;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, LEFT(email, 3) AS email
FROM customer
ORDER BY last_name ASC;

SELECT COUNT(DISTINCT film_id) FROM film;

SELECT rating, COUNT(*) FROM film GROUP BY rating;

SELECT rating, count(*) AS count FROM film GROUP BY rating ORDER BY count DESC;

SELECT rating, ROUND(AVG(length),2) AS duration FROM film GROUP BY rating ORDER BY duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

SELECT last_name, COUNT(last_name) AS count FROM actor GROUP BY last_name HAVING count = 1;

