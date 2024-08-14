SELECT
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM
    film
WHERE
    length IS NOT NULL;
    
SELECT 
    FLOOR(COALESCE(AVG(LENGTH), 0) / 60) AS avg_hours, 
    MOD(FLOOR(COALESCE(AVG(LENGTH), 0)), 60) AS avg_minutes
FROM 
    FILM;
    
SELECT 
    DATEDIFF(MAX(RENTAL_DATE), MIN(RENTAL_DATE)) AS operating_days
FROM 
    RENTAL;
    
SELECT 
    RENTAL_ID, 
    RENTAL_DATE, 
    EXTRACT(MONTH FROM RENTAL_DATE) AS rental_month,
    TO_CHAR(RENTAL_DATE, 'Day') AS rental_weekday
FROM 
    RENTAL
ORDER BY 
    RENTAL_ID
LIMIT 20;

SELECT 
    RENTAL_ID, 
    RENTAL_DATE, 
    CASE 
        WHEN TO_CHAR(RENTAL_DATE, 'D') IN ('1', '7') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
    RENTAL
ORDER BY 
    RENTAL_ID
LIMIT 20;

SELECT 
    TITLE, 
    IFNULL(CAST(RENTAL_DURATION AS CHAR), 'Not Available') AS rental_duration
FROM 
    FILM
ORDER BY 
    TITLE ASC;
    
SELECT 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS full_name,
    SUBSTR(EMAIL, 1, 3) AS email_prefix
FROM 
    CUSTOMER
ORDER BY 
    LAST_NAME ASC;
    
SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

SELECT rating, 
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT rating, 
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

SELECT COUNT(*) AS total_films FROM film;

SELECT rating, COUNT(*) AS number_of_films FROM film GROUP BY rating;

SELECT rating, COUNT(*) AS number_of_films FROM film GROUP BY rating ORDER BY number_of_films DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM film GROUP BY rating ORDER BY mean_duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM film GROUP BY rating HAVING mean_duration > 120;

SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1;




    
