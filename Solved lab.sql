USE sakila;

SELECT length AS max_duration
FROM film
ORDER BY length DESC
LIMIT 1;

SELECT length AS min_duration
FROM film
ORDER BY length
LIMIT 1;

SELECT round(AVG(length),0) as  avg_duration_min
FROM film;

SELECT round(AVG(length),0) as  avg_duration_min
FROM film;

SELECT floor(AVG(length) / 60) AS duration_in_hours
FROM film;

SELECT DATEDIFF(MAX(return_date), MIN(rental_date)) AS total_days_operational
FROM rental;

SELECT rental_date
FROM rental;

SELECT 
    rental_date,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS day_of_week
FROM 
    rental;
    
SELECT 
    rental_date,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (2, 3, 4, 5, 6) THEN 'workday'
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    END AS day_type
FROM 
    rental;
    
SELECT 
	title, rental_duration
    CAS;
    
    
SELECT 
    title,
    IFNULL(rental_duration, 0) AS rental_duration
FROM 
    film;
    
SELECT 
    title,
    CASE
        WHEN rental_duration = 0 THEN 'Not Available'
        ELSE CAST(rental_duration AS CHAR)
    END AS rental_duration_status
FROM 
    film;
    
SELECT 
    title,
    CASE
        WHEN rental_duration = 0 THEN 'Not Available'
        ELSE CAST(rental_duration AS CHAR)
    END AS rental_duration_status
FROM 
    film;
    
SELECT release_year, COUNT(*) AS total_films
FROM film
GROUP BY release_year
ORDER BY release_year;

SELECT rating, count(title) AS films_rating
FROM film
GROUP BY rating;

SELECT rating, count(title) AS films_rating
FROM film
GROUP BY rating
ORDER BY films_rating DESC;

SELECT rating, AVG(length) AS avg_dur_by_rating
FROM film
GROUP BY rating;

SELECT rating, 
       AVG(length) AS avg_dur_by_rating,
       CASE 
           WHEN AVG(length) > 120 THEN 'long'
           ELSE 'short/medium'
       END AS duration_category
FROM film
GROUP BY rating
ORDER BY avg_dur_by_rating DESC;

