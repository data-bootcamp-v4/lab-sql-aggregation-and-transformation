/* 1.1 Determine the **shortest and longest movie durations** and name the values as max_duration and min_duration. */

SELECT MIN(length) AS Min_duration, MAX(length) AS Max_duration
FROM sakila.film;

/*Express the **average movie duration in hours and minutes**. Don't use decimals. *Hint: look for floor and round functions. */

SELECT FLOOR(115.2720);

SELECT CONCAT(FLOOR(AVG(115.2720) / 60), ROUND(AVG(115.2720) % 60) AS minutes_duration AS average_movie_duration
FROM sakila.film;




/*2.1 Calculate the **number of days that the company has been operating**. *Hint: To do this, use the rental table, and the
 DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.*/
 
 SELECT DATEDIFF(MIN(rental_date), MAX(rental_date)) AS total_day_of_operating_company
 FROM rental;
 
 /* 2.2 Retrieve rental information and add two additional columns to show the **month and weekday 
 of the rental**. Return 20 rows of results. */
 
SELECT rental_id, rental_date, DATE_FORMAT(rental_date, '%M') AS rental_month, DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

 
/* 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values **'weekend' or 'workday'**, 
depending on the day of the week. *Hint: use a conditional expression. */

SELECT rental_id, rental_date,
  CASE WHEN dayofweek(rental_date) IN (1, 7) THEN 'weekend'
       ELSE 'workday'
  END AS Type_of_the_day
FROM rental;


/* 3. We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the **film titles and their rental duration**. 
If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results by the film title in ascending order. 
*Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.* */

SELECT title AS title_of_films, COALESCE(rental_duration, 'Not available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

/* As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. 
To achieve this, we want to retrieve the **concatenated first and last names of our customers**, along with the **first 3 
characters of their email** address, so that we can address them by their first name and use their email address to send personalized recommendations.
 The results should be ordered by last name in ascending order to make it easier for us to use the data. */
 
 SELECT CONCAT( first_name, ' ' , last_name) AS full_name, LEFT(email, 3) AS Email_begin_characters
 FROM sakila.customer
 ORDER BY last_name ASC;
 
 /*  ## Challenge 2 */

/* We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
   The **total number of films** that have been released. */
   
   SELECT COUNT(*)
   FROM sakila.film;
   
/* The **number of films for each rating**. */

SELECT count(*) AS count_of_films
FROM film;


/* The **number of films for each rating, and sort** the results in descending order of the number of films. */

SELECT count(*) AS count_of_films
FROM film
GROUP BY rating
ORDER BY count_of_films DESC;
    
	
/* We need to track the performance of our employees. Using the rental table, determine the **number of rentals processed by each employee**. 
  
SELECT staff_id, COUNT(*)
FROM sakila.rental
GROUP BY staff_id;
   

/* Using the film table, determine:    
   The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average
   lengths to two decimal places. This will help us identify popular movie lengths for each category. */
   
   SELECT rating, ROUND(AVG(length), 2) AS  duration_avg
   FROM sakila.film
   GROUP BY rating
   ORDER BY duration_avg DESC;
   

/* Identify **which ratings have a mean duration of over two hours**, to help us select films for customers who prefer longer movies. */

SELECT rating, ROUND(AVG(length), 2) AS  duration_avg
FROM sakila.film
GROUP BY rating 
HAVING AVG(length) > 120;


/* Determine which last names are not repeated in the table actor. */

SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;
 
 


 



 
 
 
 
 
 
 


