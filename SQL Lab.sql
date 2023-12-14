/*CHALLENGE 1: 
You need to use SQL built-in functions to gain insights relating to the duration of movies:

1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions.*/

SELECT MAX(length) AS max_duration 
FROM sakila.film;

SELECT MIN(length) AS min_duration
FROM sakila.film;

SELECT FLOOR(AVG(length))  /* in minutes*/
FROM sakila.film;

SELECT ROUND(AVG(length)/60) /*hours*/
FROM sakila.film;

/*You need to gain insights related to rental dates:

2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.*/

SELECT DATEDIFF(max_date, min_date) AS data_difference
FROM ( 
       SELECT min(rental_date) AS min_date, max(rental_date) AS max_date
	   FROM sakila.rental) AS data_range ;
       
SELECT *, MONTHNAME(rental_date) AS month_rental, WEEKDAY(rental_date) as weekday_rental 
FROM sakila.rental
LIMIT 20;

/* 3. You need to ensure that customers can easily access information about the movie collection. 
To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. 
Sort the results of the film title in ascending order.
Hint: Look for the IFNULL() function.*/

SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration
FROM sakila.film
ORDER BY title ASC;
	
/*CHALLENGE 2:
Next, you need to analyze the films in the collection to gain some more insights. 
Using the film table, determine:
1.1 The total number of films that have been released.
1.2 The number of films for each rating.
1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly. */   

SELECT COUNT(release_year)
FROM sakila.film;

SELECT count(film_id), rating
FROM sakila.film
GROUP BY rating;

SELECT count(film_id), rating
FROM sakila.film
GROUP BY rating
ORDER BY rating DESC;

/*Using the film table, determine:
2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
     Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.*/

SELECT ROUND(AVG(length),2) AS mean_duration, rating
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT ROUND(AVG(length),2)>120 AS mean_duration, rating
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC

