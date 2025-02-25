-- 1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films FROM film GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating 
ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours.
SELECT rating 
FROM film 
GROUP BY rating 
HAVING AVG(length) > 120;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name 
FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;