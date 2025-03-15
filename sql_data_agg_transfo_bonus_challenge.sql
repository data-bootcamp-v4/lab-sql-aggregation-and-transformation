USE sakila;
-- 3. Determining which last names are not repeated in the table actor
SELECT 
    last_name, COUNT(*) AS non_repeated_name
FROM
    actor
GROUP BY last_name
HAVING COUNT(*) = 1;