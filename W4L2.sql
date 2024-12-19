#Challenge 1
#You need to use SQL built-in functions to gain insights relating to the duration of movies:
use sakila;
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
#1.1.1 max_duration
select title, length as max_duration
from film
order by length DESC
limit 10;
#1.1.2 min_duration
select title, length as min_duration
from film
order by length ASC
limit 5;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select floor(avg(length)) as avg_lenght_minutes
from film;
select floor(avg(length)/60) as avg_lenght_hours
from film;

#2.1 Calculate the number of days that the company has been operating.

SELECT DATEDIFF(
    (SELECT MAX(rental_date) FROM rental),
    (SELECT MIN(rental_date) FROM rental)
) AS days_operating
from rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
#Return 20 rows of results.
#SELECT MONTH(GETDATE()), Day(GetDate())

select *,
	month (rental_date) AS month_rental_date,
	dayname (rental_date) AS rental_day
from rental
limit 20;

#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- 1 = Sunday, 7 = Saturday
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

#3.You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.

select title, IFNULL(rental_duration, 'Not Available') as rental_duration
from film;

#4.Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for 
#customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the 
#first 3 characters of their email address, so that you can address them by their first name and use their email 
#address to send personalized recommendations. The results should be ordered by last name in ascending order to make 
#it easier to use the data.

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

#Challenge 2
#Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.
select count(distinct(title)) as total_number_of_films
from film;
#1.2 The number of films for each rating.
select count(distinct(title)) as nº_movies, rating
from film
group by rating;
#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will 
#help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select count(distinct(title)) as nº_movies, rating
from film
group by rating
order by nº_movies DESC;

#3Bonus: determine which last names are not repeated in the table actor.

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;