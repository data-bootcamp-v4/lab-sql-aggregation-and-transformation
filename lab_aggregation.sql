USE  sakila;
#Challenge 1
#1
#1.1
SELECT MAX(f.length) AS max_duration, MIN(f.length) AS min_duration FROM sakila.film AS f;

#1.2
SELECT SEC_TO_TIME(ROUND(AVG(f.length) * 60, -2)) AS avg_duration FROM sakila.film AS f;

#2
#2.1
SELECT DATEDIFF(
  (SELECT MAX(rental_date) FROM sakila.rental),
  (SELECT MIN(rental_date) FROM sakila.rental)
) AS nr_of_days_open;

#2.2
-- SELECT *, EXTRACT(MONTH FROM rental_date) AS month, DAYOFWEEK(rental_date) AS day_of_week FROM sakila.rental;
SELECT *, EXTRACT(MONTH FROM rental_date) AS month,
  CASE
	WHEN DAYOFWEEK(rental_date) = 1  THEN 'Sunday'
    WHEN DAYOFWEEK(rental_date) = 2  THEN 'Monday'
    WHEN DAYOFWEEK(rental_date) = 3  THEN 'Tuesday'
    WHEN DAYOFWEEK(rental_date) = 4  THEN 'Wednesday'
    WHEN DAYOFWEEK(rental_date) = 5  THEN 'Thursday'
	WHEN DAYOFWEEK(rental_date) = 6  THEN 'Friday'
    ELSE 'Saturday' 
  END AS day_of_week
FROM sakila.rental;

#2.3
SELECT *,
CASE
	WHEN DAYOFWEEK(rental_date) = 1  THEN 'Weekend'
    WHEN DAYOFWEEK(rental_date) = 2  THEN 'Workday'
    WHEN DAYOFWEEK(rental_date) = 3  THEN 'Workday'
    WHEN DAYOFWEEK(rental_date) = 4  THEN 'Workday'
    WHEN DAYOFWEEK(rental_date) = 5  THEN 'Workday'
	WHEN DAYOFWEEK(rental_date) = 6  THEN 'Weekend'
END AS day_type
FROM sakila.rental;

#3
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration FROM sakila.film
ORDER BY title ASC;

#4
SELECT *, CONCAT(first_name, last_name, SUBSTRING(email, 1, 3)) AS personalized_email FROM sakila.customer
ORDER BY last_name ASC;

#Challenge 2
#1
#1.1
SELECT * FROM sakila.film;
SELECT COUNT(*) as n_films_released FROM sakila.film;

#1.2
SELECT rating, COUNT(*) AS nr_of_films FROM sakila.film
GROUP BY rating;

#1.3
SELECT rating, COUNT(*) AS nr_of_films FROM sakila.film
GROUP BY rating
ORDER BY nr_of_films DESC;

#2.
#2.1
SELECT rating, ROUND(AVG(length), 2) AS avg_length FROM sakila.film
GROUP BY rating
ORDER BY avg_length DESC;

#2.2
SELECT rating, ROUND(AVG(length), 2) AS avg_length FROM sakila.film
WHERE (SELECT ROUND(AVG(length), 2) > 120)
GROUP BY rating
ORDER BY avg_length DESC;

#3
SELECT DISTINCT last_name AS unique_last_names FROM sakila.actor