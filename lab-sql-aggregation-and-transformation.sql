# 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
# Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

# Express the average movie duration in hours and minutes (no decimals)

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;


# 2.You need to gain insights related to rental dates:
# Number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

# Retrieve rental info + month and weekday (first 20 rows)
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

# Bonus: Add column DAY_TYPE ('weekend' or 'workday')

SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

# 3.User-Friendly Movie Info with NULL Handling
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

# 4. Bonus: Customer Personalization Data for Marketing

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

# Challenge 2

#1. Total number of films released

SELECT COUNT(*) AS total_films
FROM film;

#2.Number of films for each rating

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

# 3.Number of films for each rating (sorted descending by count)

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

# 2. Film Duration Analysis by Rating
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

# Ratings with mean duration over 2 hours (120 minutes)

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration DESC;

# Bonus: Unique Last Names in the actor Table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;







 









