USE sakila;

-- 1. Determining the shoretest and the longest movie duration
SELECT MIN(length) AS min_duration, MAX(length) AS  max_duration
FROM film;

-- Express the avg. movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(MOD(AVG(length), 60)) AS minutes
FROM
    film;

-- 2.1 Calculating the no. of days that the company has been operationg
SELECT * FROM rental;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) as days_operating;

-- 2.2 Retrieving rental info and adding 2 additional colums to show the month and weekday of the rental. limit - 20
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    last_update,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS weekday
FROM
    rental
LIMIT 20;

-- 2.3 similar like 2.2 but adding additional colum called DAY_TYPE with values 'weekend' or 'workday' depending on the day of the week
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    last_update,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS weekday,
    CASE
		WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Workday' 
	END AS rental_day_type
FROM
    rental
LIMIT 20;

-- 3. Retrieve film tiles and rental duration and add 'Not Available' to the missing value of rental duration to avoid error and arrange in asc. order

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4.  Creating a email campaign for the customers
SELECT * FROM customer;
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, -- Concating the first and last name
    LEFT(email, 3) AS email_prefix -- grabbing the first 3 characters of their email address
FROM
    customer
ORDER BY last_name ASC;  -- arranging the list by last name in ascending order 

/* Challenge 2
1.1 Total number of films that have been released */
SELECT COUNT(release_year) AS released_film FROM film;

-- 1.2 No. of films for each rating.
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY rating;

-- 1.3 Sorting the above result in desc. order
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY rating DESC;

/* 2.1 Mean film durationg of each rating and sorting results in descending order of the mean duration.
 Round off the avg. lengths to 2 decimal places. */
 SELECT rating, ROUND(AVG(rental_duration), 2) AS mean_duration
 FROM film
 GROUP BY rating
 ORDER BY mean_duration DESC;

-- 2.2 Identifying the mean duration of over 2 hours for each rating type to assist customer who preferes longer movies
SELECT rating, AVG(length) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

-- 3. Determine which last names are not repeated in the table actor
SELECT last_name, COUNT(*) as non_repeated_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;