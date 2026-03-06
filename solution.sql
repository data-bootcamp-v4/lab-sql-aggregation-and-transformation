SELECT MAX(length), MIN(length)
FROM film;

SELECT AVG(length)
FROM film;

-- 2.1 there is no DATEDIFF in sqlite

SELECT *, strftime('%m', rental_date) AS the_month, strftime('%w', rental_date) AS the_weekday
FROM rental
LIMIT 20;

SELECT *, strftime('%m', rental_date) AS the_month, strftime('%w', rental_date) AS the_weekday, CASE strftime('%w', rental_date)
WHEN  "0" then "Working"
WHEN  "1" then "Working"
WHEN  "2" then "Working"
WHEN  "3" then "Working"
WHEN  "4" then "Working"
WHEN  "5" then "Weekend"
WHEN  "6" then "Weekend"
else "UNKNOWN" end as day_type
FROM rental
LIMIT 20;

SELECT rental_duration = "Not Available"
FROM film
WHERE rental_duration IS NULL;

SELECT first_name, last_name, SUBSTR(email, 0, 4)
FROM customer
ORDER BY last_name ASC;

--- Challenge 2
SELECT COUNT(*)
FROM film;

SELECT rating, COUNT(*)
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

SELECT rating, COUNT(*) AS number_of_films, ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

SELECT rating, COUNT(*) AS number_of_films, ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING average_duration > 120
ORDER BY average_duration DESC;

SELECT first_name, last_name, COUNT(*) AS number_of_entried
FROM actor
GROUP BY last_name 
HAVING number_of_entried = 1;
