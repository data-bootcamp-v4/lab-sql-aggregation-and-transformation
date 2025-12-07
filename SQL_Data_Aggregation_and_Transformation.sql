-- challenge 1.1: Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT min(length) AS min_duration, 
max(length) AS max_duration FROM sakila.film;

-- challenge 1.2.: Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length)) % 60 AS avg_minutes
FROM sakila.film; 

-- challenge 2.1.: Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
    DATEDIFF(
        MAX(rental_date),
        MIN(rental_date)
    ) AS days_operating
FROM sakila.rental;

-- challenge 2.2.:Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, 
DATE_FORMAT(CONVERT(rental_date, DATE), '%M') AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

-- challenge 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT *, DAYNAME(rental_date) AS rental_weekday,
CASE 
    WHEN DAYNAME(rental_date) IN ("Monday", "Tuesday", "Wednesday", "Thursday", "Friday") Then "workday"
    ELSE "weekend"
END AS day_type
FROM sakila.rental
LIMIT 20;

-- challenge 3: retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;


-- challenge 3 Bonus:
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name ASC, first_name ASC;


-- challenge 2.1.1.: The total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM sakila.film;

-- challenge 2.1.2.: The number of films for each rating.
SELECT rating, COUNT(*) AS num_films
FROM sakila.film
GROUP BY rating;

-- challenge 2.1.3.: The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT rating, COUNT(*) AS num_films
FROM sakila.film
GROUP BY rating
ORDER BY num_films DESC;

-- challenge 2.2.1.
SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM sakila.film
GROUP BY rating
ORDER BY avg_length DESC;

-- challenge 2.2.2.
SELECT rating,
ROUND(AVG(length), 2) AS avg_length
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;

-- challenge 2.3.:
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;