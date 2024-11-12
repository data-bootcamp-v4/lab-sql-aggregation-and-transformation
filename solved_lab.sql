-- Challenge 1

-- 1.1
SELECT 
    MIN(LENGTH) AS min_duration,
    MAX(LENGTH) AS max_duration
FROM 
    FILM;
    
-- 1.2
SELECT 
    FLOOR(AVG(LENGTH) / 60) AS avg_hours,
    ROUND(MOD(AVG(LENGTH), 60)) AS avg_minutes
FROM 
    FILM;

-- 2.1
SELECT 
    DATEDIFF(MAX(RENTAL_DATE), MIN(RENTAL_DATE)) AS operating_days
FROM 
    RENTAL;

-- 2.2
SELECT 
    RENTAL_ID, 
    RENTAL_DATE, 
    MONTH(RENTAL_DATE) AS rental_month,
    DAYNAME(RENTAL_DATE) AS rental_weekday
FROM 
    RENTAL
LIMIT 20;

-- 2.3
SELECT 
    RENTAL_ID, 
    RENTAL_DATE, 
    MONTH(RENTAL_DATE) AS rental_month,
    DAYNAME(RENTAL_DATE) AS rental_weekday,
    CASE 
        WHEN DAYNAME(RENTAL_DATE) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
    RENTAL
LIMIT 20;

-- 3
SELECT 
    TITLE, 
    IFNULL(RENTAL_DURATION, 'Not Available') AS rental_duration
FROM 
    FILM
ORDER BY 
    TITLE ASC;

-- bonus
SELECT 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS full_name,
    LEFT(EMAIL, 3) AS email_prefix
FROM 
    CUSTOMER
ORDER BY 
    LAST_NAME ASC;

-- Challenge 2

-- 1.1
SELECT COUNT(*) AS total_films FROM FILM;
    
-- 1.2
SELECT RATING, COUNT(*) AS film_count FROM FILM
GROUP BY RATING;

-- 1.3
SELECT RATING, COUNT(*) AS film_count FROM FILM
GROUP BY RATING
ORDER BY film_count DESC;

-- 2.1
SELECT RATING, ROUND(AVG(LENGTH), 2) AS avg_duration FROM FILM
GROUP BY RATING
ORDER BY avg_duration DESC;

-- 2.2
SELECT RATING, ROUND(AVG(LENGTH), 2) AS avg_duration FROM FILM
GROUP BY RATING
HAVING AVG(LENGTH) > 120;

-- bonus
SELECT LAST_NAME FROM ACTOR
GROUP BY LAST_NAME
HAVING COUNT(*) = 1;

