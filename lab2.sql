USE sakila;
#You need to use SQL built-in functions to gain insights relating to the duration of movies:

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT MIN(length) AS min_lenght, MAX(length) AS max_length
FROM film ; 
SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), ' hours ',
        ROUND(AVG(length) % 60), ' minutes'
    ) AS avg_length
FROM 
    film;

#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT DATEDIFF(max(rental_date),min(rental_date)) 
FROM rental;
SELECT 
    *,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
#3 
SELECT title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
 #bonus 
 SELECT CONCAT(first_name," ", last_name) AS full_name, LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

##challenge 2 
#2.1.1
SELECT COUNT(release_year) FROM film;
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;
SELECT rating,ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
SELECT rating,ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING ROUND(AVG(length), 2) > 120
ORDER BY mean_duration DESC;
SELECT DISTINCT last_name
FROM actor;









