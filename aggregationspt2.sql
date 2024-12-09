USE sakila;

-- 1.1 Total Number of Films
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Number of Films for Each Rating
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;

-- 1.3 Number of Films for Each Rating (Sorted by Descending Count)
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

-- 2.1 Mean Film Duration for Each Rating (Sorted by Descending Mean Duration)
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with Mean Duration Over 2 Hours
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

-- 3. Bonus: Last Names Not Repeated in the Actor Table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
