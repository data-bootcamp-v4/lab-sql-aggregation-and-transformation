USE SAKILA;

-- Challenge 1

-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- -- 1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
	MAX(length) 
	from film 
	as max_duration;
SELECT 
	MIN(length) 
    from film 
    as min_duration;
    
-- -- 2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
	FLOOR(AVG(length)/60) 
    AS hours, 
    ROUND(AVG(length)%60) 
    AS minutes 
    from film;
    
-- You need to gain insights related to rental dates:
-- -- 1 Calculate the number of days that the company has been operating.
SELECT 
	DATEDIFF
    (MAX(rental_date),
	MIN(rental_date)) 
	FROM rental;
    
-- -- .2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, 
       MONTHNAME(rental_date) 
       AS rental_month, 
       DAYNAME(rental_date) 
       AS rental_weekday
FROM rental
LIMIT 20;

-- -- .3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *,
       CASE 
           WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental;

-- retrieve the film titles and their rental duration
SELECT title,
	IFNULL(rental_duration, 'Not available') 
	AS rental_duration_nonull
	FROM film 
	ORDER BY title ASC; 
    
-- 4 Bonus
SELECT 
	concat (first_name,' ',last_name) 
    as full_name, 
    left (email,3) 
    as email_id 
FROM customer 
ORDER BY last_name;

-- Challenge 2
-- 1.1 The total number of films that have been released.
SELECT 
	count(*) 
AS total_nr_of_films
FROM film;

-- 1.2 The number of films for each rating.
 SELECT 
	rating,
    count(film_id) as number_films_by_rating 
FROM film 
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films
SELECT 
	rating,
    count(film_id) as number_films_by_rating 
FROM film 
GROUP BY rating
ORDER BY rating DESC;

-- 2.1 The mean film duration for each rating. sort the results in descending order of the mean duration
SELECT rating, 
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours
SELECT rating, 
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT last_name, 
       COUNT(*) AS actor_count
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;