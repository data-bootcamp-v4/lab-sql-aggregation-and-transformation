USE sakila;

SELECT COUNT(DISTINCT film_id) as total_number_film FROM sakila.film;

SELECT rating, count(*) FROM film GROUP BY rating;

SELECT rating, count(*) FROM film GROUP BY rating ORDER BY count(*) DESC;

SELECT rating, ROUND(AVG(length), 2) FROM film GROUP BY rating ORDER BY ROUND(AVG(length), 2) DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM film GROUP BY rating HAVING mean_duration > 120 ORDER BY mean_duration DESC;

SELECT last_name, count(*) as count_name FROM sakila.actor GROUP BY last_name HAVING count_name = 1;