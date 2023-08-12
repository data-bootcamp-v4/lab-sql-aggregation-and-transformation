/*Challenge 1
As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:

1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
We need to use SQL to help us gain insights into our business operations related to rental dates:

2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.

As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. To achieve this, we want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, so that we can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier for us to use the data.

Challenge 2
We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
1.1 The total number of films that have been released.
1.2 The number of films for each rating.
1.3 The number of films for each rating, and sort the results in descending order of the number of films. This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.
We need to track the performance of our employees. Using the rental table, determine the number of rentals processed by each employee. This will help us identify our top-performing employees and areas where additional training may be necessary.
Using the film table, determine:
3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.
3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.
Determine which last names are not repeated in the table actor.*/


/* 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration. */

Select max(length) as max_duration from sakila.film ;
SELECT min(length) as min_duration from sakila.film ;

/* 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.*/

SELECT CONCAT(
  FLOOR(AVG(length) / 60), -- Hours
  'h ',
  ROUND(AVG(length) % 60), -- Minutes
  'min'
) AS average_duration
FROM sakila.film;

/*2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.*/

SELECT min(rental_date) from sakila.rental;
/* 2005-05-24 22:53:30*/
SELECT max(rental_date) from sakila.rental;
/* 2006-02-14 15:16:03*/
SELECT DATEDIFF(min(rental_date), max(rental_date)) as number_of_days_operating
FROM sakila.rental;

/*2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.*/

select *, date_format(rental_date, "%M") as month, date_format(rental_date, '%a') as weekday
from sakila.rental
LIMIT 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

select *, date_format(rental_date, "%M") as month, date_format(rental_date, '%a') as weekday
IF(weekday = 'sat', 'weekend', 'weekday') as day_type 
FROM sakila.rental;

-- retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available 

SET SQL_SAFE_UPDATES = 0;

UPDATE sakila.film
SET rental_duration = 
    CASE 
        WHEN rental_duration = '0' THEN 'not available'
        ELSE rental_duration
    END;

SELECT rental_duration = '0'
FROM sakila.film;


-- Challenge 2
-- We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT COUNT(sakila.film.title) FROM sakila.film;

-- 1.2 The number of films for each rating.

SELECT COUNT(sakila.film.rating), sakila.film.rating FROM sakila.film
GROUP BY sakila.film.rating;

-- The number of films for each rating, and sort the results in descending order of the number of films

SELECT COUNT(sakila.film.rating), sakila.film.rating FROM sakila.film
GROUP BY sakila.film.rating
ORDER BY COUNT(sakila.film.rating) DESC;

-- Using the rental table, determine the number of rentals processed by each employee.

SELECT sakila.rental.staff_id, count(sakila.rental.staff_id) FROM sakila.rental
GROUP BY sakila.rental.staff_id;




-- 3.1 Using the film table, determine - The mean film duration for each rating, and sort the results in descending order of the mean duration

SELECT COUNT(sakila.film.rating), sakila.film.rating FROM sakila.film
GROUP BY sakila.film.rating;


ALTER TABLE sakila.film
ADD column_name data_type [column_constraints];

