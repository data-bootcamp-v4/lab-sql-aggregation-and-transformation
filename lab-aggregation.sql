USE sakila;

SELECT title, length
FROM film
ORDER BY length ASC;

SELECT
	MAX(length) AS max_duration,
    MIN(length) AS min_duration
    FROM film;
    
  SELECT ROUND(AVG(length)%60) AS avg_minutes
  FROM film;  
  
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

SELECT * ,
		MONTH(rental_date) AS month,
        date_format(rental_date, "%W") AS weekday
FROM rental;

WITH cte_day_type as (SELECT *,
		MONTH(rental_date) AS month,
        date_format(rental_date, "%W") AS weekday
		FROM rental)
SELECT *,
 CASE 
			WHEN weekday IN("Saturday","Sunday") THEN "weekend"
            ELSE "workday"
		END AS day_type;

SELECT title, 
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT
	COUNT(*) as total_films_releases
FROM film;

SELECT rating,
	COUNT(*) as total_films
FROM film
GROUP BY rating;


SELECT rating,
	COUNT(*) as total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

SELECT rating,
	ROUND(AVG(length), 2) as avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration;

SELECT rating,
	ROUND(AVG(length), 2) as avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration;
