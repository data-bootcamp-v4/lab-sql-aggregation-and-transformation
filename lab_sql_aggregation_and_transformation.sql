USE sakila;

SELECT
MAX(length) AS 'max_duration',
MIN(length) AS 'min_duration'
FROM film; 

SELECT
ROUND(AVG(length) - FLOOR(AVG(length) / 60) * 60) AS minutos
FROM film; 

SELECT
DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental; 

SELECT*
FROM rental
LIMIT 20;

SELECT
    rental.*,
    MONTH(rental_date) AS mes,
    DAYNAME(rental_date) AS dia_semana
FROM rental
LIMIT 20;

SELECT
	rental.*,
    CASE
		WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE "workday"
        END AS DAY_TYPE
	FROM rental; 
    
    SELECT
    title,
   IFNULL(rental_duration, 'Not Available')
    FROM film
    ORDER BY title ASC;
    
    SELECT
    CONCAT(first_name, ' ', last_name) AS nombre_completo,
    SUBSTRING(email, 1, 3) AS inicio_email
    FROM customer
    ORDER BY last_name ASC;
    
    SELECT
    COUNT(film_id)
    FROM film; 
    
    SELECT
    rating,
    COUNT(film_id)
    FROM film
    GROUP BY
    rating; 
    
	SELECT
    rating,
    COUNT(film_id)
    FROM film
    GROUP BY rating
    ORDER BY COUNT(film_id) DESC;
    
    SELECT
    rating,
    ROUND(AVG(length), 2) AS duracion_media
    FROM film
    GROUP BY rating
    ORDER BY duracion_media DESC;
    
    SELECT
   rating,
ROUND(AVG(length), 2) AS duracion_media
    FROM film
    GROUP BY rating
    HAVING AVG(length) > 120;
    
    SELECT
    last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) = 1;