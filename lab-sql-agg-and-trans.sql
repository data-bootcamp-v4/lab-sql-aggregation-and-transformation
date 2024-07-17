USE sakila;
SHOW FULL TABLES;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) FROM film; 
SELECT MIN(length) FROM film; 
-- 1.2 Express the average movie duration in hours and minutes. Don't use decimals
SELECT FLOOR(AVG(length) / 60) AS hours FROM film;
SELECT ROUND(AVG(length) / 60) AS minutes FROM film;

-- 2.1 Calculate the number of days that the company has been operating
select * from rental;
SELECT DATEDIFF(CURDATE(), MIN(rental_date)) FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_date, 
	MONTHNAME(rental_date) as rental_date, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
SELECT rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental LIMIT 20;

-- 3 You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
SELECT title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film ORDER BY title ASC;

-- Challenge 2
-- 1.1 The total number of films that have been released
SELECT COUNT(*) AS total_films_released FROM film;

-- 1.2 The number of films for each rating.
SELECT rating,
    COUNT(*) AS number_of_films
FROM film GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating,
    COUNT(*) AS number_of_films
FROM film GROUP BY rating ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating, sorted in descending order
SELECT rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with a mean duration of over two hours
SELECT rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;




