USE sakila;

SELECT
MIN(length) AS min_length,
MAX(length) AS max_length

FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM 
   film;

SELECT 
    MIN(rental_date) AS first_rental, 
    MAX(rental_date) AS last_rental,
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS total_operating_days
FROM 
  rental;
SELECT 
    *, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM 
 rental
LIMIT 20;
 SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
  film
ORDER BY 
    title ASC;
SELECT 
    COUNT(*) AS total_films
FROM 
  film;
  
  SELECT 
    rating, 
    COUNT(*) AS number_of_films
FROM 
film
GROUP BY 
    rating;
    
    SELECT 
    rating, 
    COUNT(*) AS number_of_films
FROM 
  film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;
    
   SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM 
 film
GROUP BY 
    rating
ORDER BY 
    avg_duration DESC;
    
    SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM 
   film
GROUP BY 
    rating
HAVING 
    AVG(length) > 120;

