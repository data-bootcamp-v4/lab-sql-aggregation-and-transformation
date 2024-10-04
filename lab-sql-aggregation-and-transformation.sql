USE sakila;
#You need to use SQL built-in functions to gain insights relating to the duration of movies:

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM sakila.film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    MOD(AVG(length), 60) AS avg_minutes
FROM sakila.film;

#You need to gain insights related to rental dates:

#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM sakila.rental;


#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_id, 
    rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
#Hint: use a conditional expression.

#You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;


