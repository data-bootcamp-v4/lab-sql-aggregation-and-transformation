USE sakila; 

/*
1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	- 1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
	- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
      - *Hint: Look for floor and round functions.*
*/
SELECT MAX(sakila.film.length) AS max_duration, MIN(sakila.film.length) AS min_duration
FROM sakila.film
LIMIT 1;

SELECT ROUND(AVG(sakila.film.length)) AS AVG_duration
FROM sakila.film;


/*
2. You need to gain insights related to rental dates:
	- 2.1 Calculate the **number of days that the company has been operating**.
      - *Hint: To do this, use the `rental` table, and the `DATEDIFF()` function to subtract the earliest date in the `rental_date` column from the latest date.*
	- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
	- 2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.*
      - *Hint: use a conditional expression.*
*/
SELECT DATEDIFF(MAX(sakila.rental.rental_date), MIN(sakila.rental.rental_date)) AS "days_in_operation"
FROM sakila.rental;

SELECT *, DATE_FORMAT(CONVERT(sakila.rental.rental_date, DATE), "%M") AS "month of rental", DATE_FORMAT(CONVERT(sakila.rental.rental_date, DATE), "%W") AS "weekday of the rental"
FROM sakila.rental
LIMIT 20;

SELECT *,
    CASE 
        WHEN DATE_FORMAT(sakila.rental.rental_date, "%W") NOT IN ("Saturday", "Sunday") THEN 'workday'
        ELSE 'weekday'
    END AS day_type
FROM sakila.rental;


/*
3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the **film titles and their rental duration**. If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results of the film title in ascending order.
    - *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.*
    - *Hint: Look for the `IFNULL()` function.*
*/
SELECT sakila.film.title,
	CASE
		WHEN IFNULL(sakila.film.rental_duration, 0) = 0 THEN "Not available"
        ELSE sakila.film.rental_duration
	END AS Availability
FROM sakila.film
ORDER BY sakila.film.title;

  

-- 4. *Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the **concatenated first and last names of customers**, along with the **first 3 characters of their email** address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.*
SELECT *, CONCAT(sakila.customer.last_name, ", ", sakila.customer.first_name) AS full_name
FROM sakila.customer
ORDER BY full_name;


/*
## Challenge 2

1. Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
	- 1.1 The **total number of films** that have been released.
	- 1.2 The **number of films for each rating**.
	- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
	This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
*/

SELECT COUNT(sakila.film.film_id) AS total_film_count
FROM sakila.film;

SELECT sakila.film.rating, COUNT(sakila.film.rating) AS "no. of films"
FROM sakila.film
GROUP BY sakila.film.rating;

SELECT sakila.film.rating, COUNT(sakila.film.rating) AS "no. of films"
FROM sakila.film
GROUP BY sakila.film.rating
ORDER BY "no. of films" DESC;

/*
2. Using the `film` table, determine:
   - 2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
	- 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select films for customers who prefer longer movies.
*/
SELECT sakila.film.rating, COUNT(sakila.film.rating) AS "no. of films", ROUND(AVG(sakila.film.length), 2) AS "avg length"
FROM sakila.film
GROUP BY sakila.film.rating
ORDER BY "avg length" DESC;

SELECT sakila.film.rating, COUNT(sakila.film.rating) AS "no. of films", ROUND(AVG(sakila.film.length), 2) > 120 AS "avg length of over 2"
FROM sakila.film
GROUP BY sakila.film.rating
ORDER BY "avg length" DESC;

-- 3. *Bonus: determine which last names are not repeated in the table `actor`.*
SELECT sakila.actor.last_name, COUNT(sakila.actor.last_name) = 1 AS "really really unique lat name" 
FROM sakila.actor
GROUP BY sakila.actor.last_name;
