# Imagine you work at a movie rental company as an analyst. 
#By using SQL in the challenges below, you are required to gain insights into different elements of its business operations.

USE sakila;

# Challenge 1
# You need to use SQL built-in functions to gain insights relating to the duration of movies:
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

# for length(duration) of the film
SELECT 
	MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM film;

#for rental duration, in days
SELECT
	MAX(rental_duration) AS max_duration, 
    MIN(rental_duration) AS min_duration
FROM film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.
#You need to gain insights related to rental dates:

#for length of the film 
SELECT 
    FLOOR(AVG(length) / 60) AS avg_duration_hours,
    FLOOR(AVG(length) % 60) AS avg_duration_minutes
FROM film;

#for rental duration of the film 
SELECT 
    FLOOR(AVG(rental_duration) * 24) AS avg_rental_duration_hours,
    FLOOR(AVG(rental_duration) * 1440) AS avg_rental_duration_minutes
FROM film;


# 2.1 Calculate the number of days that the company has been operating.
# Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT * FROM rental;
SELECT MAX(rental_date), MIN(rental_date) FROM rental;

SELECT DATEDIFF(
    (SELECT MAX(rental_date) FROM rental),
    (SELECT MIN(rental_date) FROM rental)
    ) AS days_operating;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
	rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%M') AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.




-- adding a new column with workday/weekend
# Hint: use a conditional expression.
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
	CASE
		WHEN DAYNAME(rental_date) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN "workday"
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN "weekend"
	END AS day_type
FROM rental;

-- columns to add + not null
# You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
SELECT title, rental_duration FROM film;
# If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- merge the two queries
SELECT 
    r.rental_id,
    r.rental_date,
    DATE_FORMAT(r.rental_date, '%M') AS rental_month,
    DAYNAME(r.rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(r.rental_date) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'workday'
        WHEN DAYNAME(r.rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
    END AS day_type,
    f.title,
    IFNULL(f.rental_duration, 'Not Available') AS rental_duration
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON r.inventory_id = f.film_id
ORDER BY f.title ASC;

#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.

#Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
#To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.



