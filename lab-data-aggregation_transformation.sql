-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM film;

-- Express the average movie duration in hours and minutes. Don't use decimals.
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,               
    ROUND(AVG(length) % 60) AS avg_minutes              
FROM film;

-- 2. You need to gain insights related to rental dates:
-- Calculate the number of days that the company has been operating.
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT
    rental_id,               
    rental_date,          
    MONTH(rental_date) AS rental_month,  
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT
    rental_id,                
    rental_date,              
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' 
        ELSE 'workday'                                         
    END AS DAY_TYPE          
FROM rental
LIMIT 20;     

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT
    title,                                         
    IFNULL(rental_duration, 'Not Available') AS rental_duration  
FROM film
ORDER BY title ASC; 

-- 4. The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,        
    LEFT(email, 3) AS email_prefix                          
FROM customer
ORDER BY last_name ASC;  

-- 5. Determine the total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM film;

-- 6. The number of films for each rating.
SELECT rating, COUNT(*) AS number_films
FROM film
GROUP BY rating
ORDER BY rating;

-- 7. The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(*) AS number_films
FROM film
GROUP BY rating
ORDER BY number_films DESC;

-- 8. The mean film duration for each rating, and sort the results in descending order of the mean duration.
SELECT rating, 
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 9. Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, 
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120 
ORDER BY mean_duration DESC;

-- 10. Determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;