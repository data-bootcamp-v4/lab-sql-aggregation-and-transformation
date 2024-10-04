USE sakila;

#Challenge 1

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT MAX(f.length) AS max_duration, MIN(f.length) AS min_duration
FROM film AS f;

#1.2 Express the average movie duration in hours and minutes. Don't use decimals
SELECT 
    FLOOR(AVG(f.length) / 60) AS avg_hours,
    ROUND(AVG(f.length) % 60) AS avg_minutes
FROM film AS f;

#2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(
    (SELECT MAX(rental_date) FROM rental), 
    (SELECT MIN(rental_date) FROM rental)
) AS days_operating;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_id, 
    rental_date, 
    customer_id, 
    inventory_id, 
    return_date, 
    staff_id,
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

#2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT 
    rental_id, 
    rental_date, 
    customer_id, 
    inventory_id, 
    return_date, 
    staff_id,
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

#3 You need to ensure that customers can easily access information about the movie collection.
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;



#Challenge 2

#1.1 The total number of films that have been released
SELECT COUNT(film_id) AS number_of_films
FROM film;


#1.2 The number of films for each rating.
SELECT rating, COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
SELECT rating, AVG(length) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, AVG(length) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

