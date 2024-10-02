USE sakila;
SHOW TABLES;
#QUESTION 1:
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;
SELECT CONCAT(FLOOR(AVG(length) / 60), ' hours ', ROUND(AVG(length) % 60), ' minutes ') AS avg_duration FROM film;

#QUESTION 2
-- 2.1 Calculate the number of days that the company has been operating.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM 
    rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT 
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7 THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM 
    rental
LIMIT 20;

-- 3.1 Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY title;

-- 3.2 Bonus: Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address. The results should be ordered by last name in ascending order.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING_INDEX(email, '@', 1) AS email_prefix
FROM 
    customer
ORDER BY last_name;