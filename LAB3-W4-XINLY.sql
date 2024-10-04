#You need to use SQL built-in functions to gain insights relating to the duration of movies:

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT * FROM sakila.film;
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM sakila.film;
#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.
SELECT FLOOR(ROUND(AVG(length))/60) AS hours,ROUND(AVG(length)) %60 as minutes  FROM sakila.film;

#2.You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating FROM sakila.rental;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
#Return 20 rows of results.
SELECT *,DATE_FORMAT(CONVERT(rental_date, DATE),'%b') AS Month,DATE_FORMAT(CONVERT(rental_date, DATE),'%D') AS Weekday 
FROM sakila.rental
LIMIT 20;
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with 
#values 'weekend' or 'workday', depending on the day of the week.
#Hint: use a conditional expression.
SELECT 
	rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    last_update,
	CASE
		WHEN DAYOFWEEK(rental_date) in (1,7) THEN 'weekend' ELSE 'workday'
	END AS DAY_TYPE
FROM sakila.rental;

#3. You need to ensure that customers can easily access information about the movie collection. 
#to achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, rental_duration,IFNULL(rental_duration, 'Not Available') AS rental_duration_updated
FROM sakila.film
ORDER BY title ASC;

#4.Bonus: The marketing team for the movie rental company now needs to create a personalized 
#email campaign for customers. To achieve this, you need to retrieve the concatenated first 
#and last names of customers, along with the first 3 characters of their email address, 
#so that you can address them by their first name and use their email address to send 
#personalized recommendations. The results should be ordered by last name in ascending 
#order to make it easier to use the data.
SELECT CONCAT(first_name,' ',last_name) AS full_name,SUBSTRING(email, 1, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name asc;

#Challenge 2
#1.Next, you need to analyze the films in the collection to gain some more insights. 
#Using the film table, determine:
#1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_released_films 
FROM sakila.film
WHERE release_year IS NOT NULL;
#1.2 The number of films for each rating.
SELECT rating, COUNT(rating) AS number_of_films FROM sakila.film
GROUP BY rating;
#1.3 The number of films for each rating, sorting the results in descending order 
#of the number of films. This will help you to better understand the popularity of 
#different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(rating) AS number_of_films FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;

#2.Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each 
#category.
SELECT * FROM film;
SELECT rating, ROUND(AVG(length),2) AS mean_films 
FROM sakila.film
GROUP BY rating
ORDER BY mean_films DESC;
#2.2 Identify which ratings have a mean duration of over two hours in order to help select films 
#for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2) AS mean_films 
FROM sakila.film
GROUP BY rating
HAVING mean_films>120;

#3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;


