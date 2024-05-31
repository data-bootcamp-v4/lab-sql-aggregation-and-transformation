-- CHALLENGE 1
-- 1 You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;
SELECT * from film;
SELECT MAX(length) AS max_duration,MIN(length) AS min_duration FROM film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
select * FROM film;
SELECT CONCAT(FLOOR(AVG(length) / 60), ' hours ', 
ROUND(AVG(length) % 60), ' minutes') AS avg_duration
FROM film;
-- 2.You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
select * FROM rental;
SELECT rental_date, return_date, 
       CONVERT(rental.rental_date, DATE) as rent_date, 
       CONVERT(rental.return_date, DATE) as retur_date,
       min(rent_date) as first
FROM rental;

SELECT DATEDIFF((SELECT MAX(CONVERT(rental_date, DATE)) FROM rental), 
        (SELECT MIN(CONVERT(return_date, DATE)) FROM rental)) AS days_operating;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select * from rental;
SELECT DATE_FORMAT(rental_date, '%m') as month_rental,
			weekday(rental_date) as weekday_rental
			from rental
	limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
	SELECT * ,
		WEEKDAY (rental_date) AS weekday_rental,
		CASE WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'weekend' 
		ELSE 'workday'
		END AS day_type
	FROM rental;


-- -- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
SELECT title, rental_duration,
CASE WHEN rental_duration IS NULL THEN 'Not Available'
	ELSE rental_duration
    end as rental_info
FROM film
ORDER BY title ASC;

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future
-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
select * from customer;
select first_name, last_name,
concat (first_name," ", last_name," ", SUBSTRING(email, 1, 3) ) as full_contact
from customer
order by last_name asc;
-- CHALLENGE 2
-- 1.Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select * from film;
SELECT COUNT(film_id) AS total_films
FROM film
WHERE release_year IS NOT NULL;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) AS films_by_rating
from film
group by rating
order by films_by_rating DESC;
-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, round(AVG(length), 2) AS rating_length
from film
group by rating
order by rating_length DESC;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, round(AVG(length), 2) AS rating_length
from film
group by rating
having  rating_length > 120;
-- Bonus: determine which last names are not repeated in the table actor.
select * from actor;
select distinct last_name from actor;

