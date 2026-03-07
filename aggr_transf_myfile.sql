USE sakila;


-- CHALLENGE 1 --

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT 
    MIN(length) AS 'min_duration',
    MAX(length) AS 'max_duration'
FROM film;


-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.*/

SELECT 
CONCAT(FLOOR(avg(length)/ 60), ':', ROUND(CAST(avg(length) AS FLOAT) % 60,0)) AS clock_time 
FROM film;


-- 2.1 Calculate the number of days that the company has been operating. 

SELECT DATEDIFF(max(rental_date), min(rental_date)) AS DateDiff FROM rental;

/* 2.2 Retrieve rental information and add two additional 
columns to show the month and weekday of the rental. Return 20 rows of results. */

-- Extracting the year from the date
SELECT *, DATE_FORMAT(rental_date, '%m') as month, dayname(rental_date) as weekday
FROM rental
LIMIT 20;


/* 3. You need to ensure that customers can easily access information about the movie collection. 
To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. 
Sort the results of the film title in ascending order.*/

SELECT title, IFNULL(rental_duration,'Not Available') as rental_period FROM film ORDER BY title ASC;


-- CHALLENGE 2 --

-- 1.1 The total number of films that have been released.

SELECT count(*) from film;

-- 1.2 The number of films for each rating.

SELECT count(*), rating from film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT count(*) as nb, rating from film
group by rating
order by nb desc;


/* 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
Round off the average lengths to two decimal places. 
This will help identify popular movie lengths for each category. */

SELECT rating , round(avg(length),2) AS mean_duration from film
group by rating
order by mean_duration desc;



/* 2.2 Identify which ratings have a mean duration of 
over two hours in order to help select films for customers who prefer longer movies. */


SELECT rating , round(avg(length),2) AS mean_duration from film
group by rating
having (mean_duration/60) > 2
order by mean_duration desc;