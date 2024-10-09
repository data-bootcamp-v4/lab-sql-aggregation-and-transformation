USE sakila;

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
	MIN(length) AS min_duration,
	MAX(length) AS max_duration
FROM film;
#1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM 
    film;
    
#2.1 Calculate the number of days that the company has been operating. (DATEDIFF)
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.(#MONTH/#DAYOFWEEK function)
SELECT 
    rental_id,          
    rental_date,       
    inventory_id,   
    customer_id,       
    MONTH(rental_date) AS rental_month,         
    DAYOFWEEK(rental_date) AS rental_weekday   
FROM 
    rental
LIMIT 20;             

#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    CASE 
        WHEN DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7 THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM 
    rental;
    
#3 You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM 
    film;

#1.1 The total number of films that have been released.
SELECT COUNT(film_id)
FROM film;

#1.2 The number of films for each rating.
SELECT COUNT(film_id), rating
FROM film
GROUP BY rating;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT COUNT(film_id) AS film_count, rating
FROM film
GROUP BY rating
ORDER BY film_count DESC;

#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT ROUND(AVG(length),2) AS mean_duration, rating
FROM film
GROUP BY rating 
ORDER BY mean_duration DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT ROUND(AVG(length),2) AS mean_duration, rating
FROM film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;
