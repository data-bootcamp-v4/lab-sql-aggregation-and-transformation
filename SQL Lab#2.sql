-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
use sakila;
select count(title) 
from film;

-- 1.2 The number of films for each rating.
select rating, count(*) as 'film count'
from film
group by rating; 

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
-- Using the film table, determine:
select rating, count(*) as film_count
from film
group by rating
order by film_count DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;




-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers 
-- who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration DESC;


-- Bonus: determine which last names are not repeated in the table actor.