-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 Number of films per rating
SELECT 
    rating, 
    COUNT(*) AS film_count
FROM film
GROUP BY rating;


-- 1.3 Number of films per rating, sorted in descending order
SELECT 
    rating, 
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2.1 Mean film duration for each rating (rounded to two decimal places)
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Ratings with a mean duration over two hours
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;

-- 3. (Bonus) Find last names that are not repeated in the actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
