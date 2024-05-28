-- ###CHALLENGE 1###
-- EX1
SELECT title, length from film
WHERE length = (SELECT MAX(length) AS max_duration from film);
SELECT title, length from film
WHERE length = (SELECT MIN(length) AS min_duration from film);

SELECT 
	FLOOR(AVG(length) / 60) as avg_hours,
    ROUND(MOD(AVG(length), 60),0) as avg_minutes
FROM 
    film;
    
-- EX2
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) from rental;
SELECT
	rental_id,
    rental_date,
    MONTH(rental_date) as rental_month,
    DAYNAME(rental_date) as rental_weekday
FROM rental
LIMIT 20;
SELECT
rental_id,
rental_date,
CASE
	WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
    ELSE 'workday'
END AS DAY_TYPE
FROM
	rental;
    
-- EX3
SELECT *, IFNULL(rental_duration,'Not Available')
FROM film
ORDER BY title ASC;

-- BONUS
SELECT
	CONCAT(first_name,' ',last_name," email: ",LEFT(email,3)) as full_name_and_mail
FROM customer;

-- ##CHALLENGE 2##
-- EX 1

SELECT COUNT(release_year) from film
WHERE release_year IS NOT NULL;
SELECT rating, COUNT(title)
FROM film
GROUP BY rating;
SELECT rating, COUNT(title)
FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- EX 2
SELECT rating, AVG(rental_duration) as avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;  

-- EX 3
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
    
