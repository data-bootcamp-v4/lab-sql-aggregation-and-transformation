USE sakila;

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(length) AS min_duration FROM film;
SELECT MAX(length) AS max_duration FROM film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals. 
SELECT floor(AVG(length)) AS min_duration FROM film;

#2.1 Calculate the number of days that the company has been operating
        
SELECT CONVERT(MIN(rental_date),DATE) AS min_date FROM rental;
SELECT CONVERT(MAX(rental_date),DATE) AS max_date FROM rental;

SELECT 
		CONVERT(MIN(rental_date),DATE) AS start_date,
		CONVERT(MAX(rental_date),DATE) AS end_date,
        DATEDIFF(CONVERT(MAX(rental_date),DATE), CONVERT (MIN(rental_date),DATE)) as duration
		FROM rental;
        
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT DATE_FORMAT(CONVERT(rental_date, DATE), '%M') AS rental_month,
	 DATE_FORMAT(CONVERT(rental_date, DATE), '%W') AS rental_week_day
     FROM rental
     LIMIT 20;
     
#retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'
#Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
		FROM film
        ORDER BY title ASC;
        
#Challenge 2
#Using the film table, determine: 
#1.1 The total number of films that have been released.

SELECT count(*) AS num_films
	FROM film;
    
#1.2 The number of films for each rating.
SELECT rating, count(*) AS num_films
	FROM film
    GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films
	SELECT rating, count(*) AS num_films
	FROM film
    GROUP BY rating
    ORDER BY num_films DESC;
    
#Using the film table, determine: 
#The mean film duration for each rating, and sort the results in descending order of the mean duration
SELECT rating, avg(length) AS avg_duration
	FROM film
    GROUP BY rating
    ORDER BY avg_duration DESC;
#Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, avg(length) AS avg_duration
	FROM film
    GROUP BY rating
    HAVING avg(length) > 120
    ORDER BY avg_duration DESC;
  


		
        
        
        


