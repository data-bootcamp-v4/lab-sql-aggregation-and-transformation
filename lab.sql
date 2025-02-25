USE sakila

SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM 
    film;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM 
    rental;
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS day_of_week
FROM 
    rental
LIMIT 
    20;
    
 SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS day_of_week,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'fin de semana'
        ELSE 'día laboral'
    END AS DAY_TYPE
FROM 
    rental
LIMIT 
    20;   
    
SELECT 
    title,
    IFNULL(rental_duration, 'No disponible') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;    
    
 
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM 
    rental;   
  SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS day_of_week
FROM 
    rental
LIMIT 
    20;  
    
 
 SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS day_of_week,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'fin de semana'
        ELSE 'día laboral'
    END AS DAY_TYPE
FROM 
    rental
LIMIT 
    20;
 SELECT 
    COUNT(*) AS total_films
FROM 
    film;


SELECT 
    rating, 
    COUNT(*) AS film_count
FROM 
    film
GROUP BY 
    rating;
    
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_length
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    avg_length DESC;    
    SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_length
FROM 
    film
GROUP BY 
    rating
HAVING 
    AVG(length) > 120
ORDER BY 
    avg_length DESC;