SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

SELECT ROUND(AVG(length) / 60.0,2) AS average_duration
FROM film;

SELECT 
    CONCAT(FLOOR(AVG(length) / 60), ":", ROUND((AVG(length) / 60 - FLOOR(AVG(length) / 60)) * 60)) AS duration
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS "number of days that the company has been operating"
FROM rental;

SELECT 
    MONTH(rental_date) AS month,
    DAY(rental_date) AS day,
    CASE DAYOFWEEK(rental_date)
        WHEN 1 THEN 'weekend'  
        WHEN 7 THEN 'weekend'  
        ELSE 'workday'
    END AS day_type
FROM rental;

SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration
FROM film
ORDER BY title DESC;

SELECT CONCAT(first_name, " ", last_name, " ", SUBSTRING(email, 1, 3)) AS marketing
FROM customer 
ORDER BY last_name ASC;

SELECT COUNT(*)
FROM film;

SELECT COUNT(*) AS number_of_film, rating
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

SELECT ROUND(AVG(length),2) AS mean_duration, rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY AVG(length) DESC;

SELECT COUNT(*) AS "last names that are not repeated", last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) <= 1









