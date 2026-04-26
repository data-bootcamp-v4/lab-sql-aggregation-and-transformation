USE SAKILA;

SELECT * from film
ORDER BY release_year DESC;

SELECT COUNT(*)
FROM film 
WHERE release_year IS NOT NULL;

SELECT rating,COUNT(*) AS film_rating_count
FROM film
GROUP BY rating;

SELECT rating,COUNT(*) AS film_rating_count
FROM film
GROUP BY rating
ORDER BY film_rating_count DESC;

SELECT rating,ROUND(AVG(film.length) ,2) as mean_length
FROM film
GROUP BY rating
ORDER BY mean_length DESC;


