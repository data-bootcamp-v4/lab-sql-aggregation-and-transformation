use sakila;

# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration:
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM film;

# 1.2 Express the average movie duration in hours and minutes:
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

# 2.1 Calculate the number of days that the company has been operating:
SELECT 
    DATEDIFF(
        (SELECT MAX(rental_date) FROM rental), 
        (SELECT MIN(rental_date) FROM rental)
    ) AS days_operating;
    
# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental:
SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%M') AS rental_month, 
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

# 2.3 Bonus: Add an additional column called DAY_TYPE with values 'weekend' or 'workday':
SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%M') AS rental_month, 
    DATE_FORMAT(rental_date, '%W') AS rental_weekday,
    CASE 
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

# Retrieve the film titles and their rental duration, handle NULL with 'Not Available':
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

# Bonus: Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2

# 1.1 The Total Number of Films That Have Been Released:
SELECT COUNT(*) AS total_films
FROM film;

# 1.2 The Number of Films for Each Rating:
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

# 1.3 The Number of Films for Each Rating, Sorting the Results in Descending Order of the Number of Films:
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

# 2.1 The Mean Film Duration for Each Rating, Rounded to Two Decimal Places, and Sorted in Descending Order:
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

# 2.2 Identify Ratings with a Mean Duration of Over Two Hours (120 minutes):
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

# Bonus: Determine Which Last Names Are Not Repeated in the Table Actor:
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;