USE sakila;

SELECT 
	min(length) as min_duration, 
    max(length) as max_duration 
FROM film;

SELECT 
	floor(avg(length)/60) as hours, 
    round(avg(length)%60) as minutes, 
    concat(floor(avg(length)/60),':',round(avg(length)%60)) as avg_length 
FROM film;

SELECT 
	datediff(max(rental_date),
	min(rental_date)) 
FROM rental;

SELECT 
	*, 
    DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%M') as month,
	DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%W') as weekday  
FROM rental 
LIMIT 20;

SELECT 
	*, 
    DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%M') as month,
	DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%W') as weekday, 
CASE 
WHEN DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%W') in ('Saturday','Sunday') THEN 'weekend'
ELSE 'workday'
END AS 'day_type'
FROM rental;
 
 SELECT title, 
 CASE
 WHEN isnull(rental_duration) THEN 'Not Available'
 ELSE rental_duration
 END AS rental_duration
 FROM film;
 
SELECT 
	concat(first_name,' ',last_name) as full_name, 
    left(email,3) as email_id 
FROM customer 
ORDER BY last_name;
 
 SELECT 
	count(*) 
 FROM film;
 
 SELECT
	rating,
    count(film_id) as number_films 
FROM film 
GROUP BY rating;
 
SELECT 
	rating,
    count(film_id) as number_films 
FROM film 
GROUP BY rating 
ORDER BY number_films DESC;
 
SELECT 
	rating, 
    round(avg(length),2) as avg_length 
FROM film 
GROUP BY rating 
ORDER BY avg_length DESC;
 
 SELECT 
	rating, 
    round(avg(length),2) as avg_length 
FROM film 
GROUP BY rating 
HAVING avg_length >120 
ORDER BY avg_length DESC ;
 
SELECT last_name 
FROM actor 
GROUP BY last_name 
HAVING count(last_name)=1;
 