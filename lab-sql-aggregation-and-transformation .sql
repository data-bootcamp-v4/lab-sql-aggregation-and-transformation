USE sakila;

#1 
SELECT min(length) as min_duration,
	   max(length) as max_duration,
       FLOOR(AVG(length) / 60) AS hours,
  ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;


#2.1
SELECT 
DATEDIFF(MAX(last_update),MIN(rental_date)) AS operating_days
FROM rental;

#2.2
SELECT *, 
DATE_FORMAT(rental_date, '%M') AS rental_month,
DATE_FORMAT(rental_date, '%a') AS rental_day
FROM rental
LIMIT 20;

#2.3
SELECT *, 
CASE
    WHEN rental_day = 0 OR rental_day = 6 THEN 'Weekend'
    ELSE 'Workday'
END AS day_type
FROM (SELECT * ,
			DATE_FORMAT(rental_date, '%M') AS rental_month,
			DATE_FORMAT(rental_date, '%w') AS rental_day
			FROM rental) as t
LIMIT 20;

#3
SELECT title,IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#4 
SELECT 
CONCAT(first_name, " ", last_name) AS full_name,
LEFT(email,3) as email_prefix
FROM customer
ORDER BY last_name;

#CHALLENGE 2 
#1.1
SELECT COUNT(*) AS number_of_films
FROM film;
#1.2
SELECT rating, 
	   COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
#1.3
SELECT rating, 
	   COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

#2.1
SELECT rating, ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

#2.2
SELECT rating, ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

#2.3
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;



