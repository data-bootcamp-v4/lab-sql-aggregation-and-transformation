-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT min(length) as min_duration,max(length) as max_duration from film; 

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.
Select round(AVG(length),0) from film;

-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(max(rental_date), min(rental_date)) AS days_operating FROM RENTAL;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_id, customer_id, rental_date, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT title, 
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 1.1 The total number of films that have been released.
SELECT COUNT(title) FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id) FROM film group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) FROM film group by rating order by rating DESC;

-- Using the film table, determine:Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, round(AVG(length),2)as AVG_LENGTH FROM film group by rating order by rating DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING ROUND(AVG(length), 2) > 120
ORDER BY rating;

