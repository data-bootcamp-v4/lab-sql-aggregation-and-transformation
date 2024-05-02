USE sakila;

SELECT MAX(length) AS max_duration FROM film;
SELECT MIN(length) AS min_duration FROM film;
SELECT ROUND(AVG(length),2) AS avg_duration FROM film;

SELECT * FROM rental;
SELECT DATEDIFF(MAX(return_date), MIN(rental_date)) FROM rental;
ALTER TABLE rental ADD COLUMN month_rental VARCHAR(20);
ALTER TABLE rental ADD COLUMN weekday VARCHAR(20);
ALTER TABLE rental ADD COLUMN month_rental VARCHAR(20);
ALTER TABLE rental ADD COLUMN weekday_rental VARCHAR(20);
SET SQL_SAFE_UPDATES = 0;

UPDATE rental
SET 
month_rental = DATE_FORMAT(rental_date, "%M")
LIMIT 20;

SELECT * FROM rental;
UPDATE rental
SET 
weekday = DATE_FORMAT(rental_date, "%W")
LIMIT 20;

ALTER TABLE rental ADD COLUMN day_type VARCHAR(20);
ALTER TABLE rental
DROP COLUMN day_type;
SELECT *,
CASE
WHEN DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7 THEN 'Weekend'
ELSE 'Workday'
END AS day_type
FROM rental;

SELECT title, IFNULL(rental_duration, "Not Available!") FROM film;

SELECT COUNT(title) FROM film;

SELECT COUNT(title), rating FROM film
GROUP BY rating;

SELECT COUNT(title) film_num, rating FROM film
GROUP BY rating
ORDER BY film_num DESC;


SELECT ROUND(AVG(length),2) avg_length, rating FROM film
GROUP BY rating
HAVING avg_length > 120
ORDER BY avg_length DESC;