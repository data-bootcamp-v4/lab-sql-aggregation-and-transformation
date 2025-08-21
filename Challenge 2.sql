SELECT COUNT(*) AS total_films
FROM film;
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;
SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;
