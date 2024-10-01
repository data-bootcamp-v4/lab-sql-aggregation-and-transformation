-- Challenge 1:

-- Exercise 1.1: Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,  -- Maximum duration
    MIN(length) AS min_duration   -- Minimum duration
FROM 
    film;

-- Exercise 1.2: Express the average movie duration in hours and minutes, no decimals
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,  -- Average duration in hours (no decimals)
    FLOOR(AVG(length) % 60) AS avg_minutes  -- Average duration in minutes (no decimals)
FROM 
    film;

-- Exercise 2.1: Calculate the number of days the company has been operating
-- Use DATEDIFF() to subtract the earliest date from the most recent date
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating  -- Days of operation
FROM 
    rental;

-- Exercise 2.2: Retrieve rental information and add two columns showing the month and weekday of the rental
SELECT 
    rental_id, 
    customer_id, 
    rental_date, 
    MONTHNAME(rental_date) AS rental_month,  -- Month of rental
    DAYNAME(rental_date) AS rental_weekday  -- Weekday of rental
FROM 
    rental
LIMIT 20;

-- Exercise 2.3 Bonus: Add an additional column called DAY_TYPE with values 'weekend' or 'workday'
-- Use a CASE expression to determine if it's a weekend or a workday
SELECT 
    rental_id, 
    customer_id, 
    rental_date, 
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- If it's Saturday or Sunday
        ELSE 'workday'  -- If it's a weekday
    END AS DAY_TYPE
FROM 
    rental
LIMIT 20;

-- Exercise 3: Retrieve film titles and their rental duration, replacing NULL values with 'Not Available'
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration  -- Replace NULL with 'Not Available'
FROM 
    film
ORDER BY 
    title ASC;

-- Exercise 4 Bonus: Retrieve the full names of customers concatenated and the first 3 characters of their email
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,  -- Concatenate first name and last name
    SUBSTRING(email, 1, 3) AS email_start  -- Extract the first 3 characters of the email
FROM 
    customer
ORDER BY 
    last_name ASC;
    
    
-- Challenge 2

-- Exercise 1.1: Determine the total number of films that have been released
SELECT 
    COUNT(*) AS total_films  -- Total number of films
FROM 
    film;

-- Exercise 1.2: Determine the number of films for each rating
SELECT 
    rating, 
    COUNT(*) AS film_count  -- Number of films for each rating
FROM 
    film
GROUP BY 
    rating;

-- Exercise 1.3: Determine the number of films for each rating, sorting by the number of films in descending order
SELECT 
    rating, 
    COUNT(*) AS film_count  -- Number of films for each rating
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    film_count DESC;  -- Sort in descending order by the number of films

-- Exercise 2.1: Determine the mean film duration for each rating, rounded to two decimal places, and sort by duration in descending order
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration  -- Mean film duration, rounded to 2 decimals
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    avg_duration DESC;  -- Sort in descending order by the mean duration

-- Exercise 2.2: Identify which ratings have a mean duration of over two hours
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration  -- Mean film duration, rounded to 2 decimals
FROM 
    film
GROUP BY 
    rating
HAVING 
    avg_duration > 120;  -- Filter ratings with a mean duration over 120 minutes (2 hours)

-- Bonus: Determine which last names are not repeated in the actor table
SELECT 
    last_name  -- Last names of actors
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;  -- Select last names that appear only once

