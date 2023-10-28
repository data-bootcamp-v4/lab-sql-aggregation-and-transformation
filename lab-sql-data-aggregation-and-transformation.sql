/* Challenge 1 */
/* 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration. */
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM sakila.film;

/* 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions. */
SELECT CONCAT(FLOOR(AVG(length) / 60), ' hour ', ROUND(AVG(length) % 60), ' minutes') AS avg_movie_duration
FROM sakila.film;

/* 2.1 Calculate the number of days that the company has been operating. 
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date. */
SELECT DATEDIFF(day, '2006-02-14', '2005-05-24')  #error ?
# MAX(rental_date), MIN(rental_date)
FROM sakila.rental;

/* 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results. */
SELECT rental_date, MONTHNAME(rental_date) AS month, DAYNAME(rental_date) AS weekday
FROM sakila.rental
LIMIT 20;

/* 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression. */
SELECT rental_id, rental_date,
       CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
            ELSE 'workday'
       END AS DAY_TYPE
FROM sakila.rental;

/* 3. */ 
SELECT title, COALESCE(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

/* 4. We want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, 
so that we can address them by their first name and use their email address to send personalized recommendations. 
The results should be ordered by last name in ascending order to make it easier for us to use the data. */
SELECT CONCAT(first_name + ' ' + last_name) AS full_name, SUBSTRING(email, 1, 3) AS email_address
FROM sakila.customer
ORDER BY last_name ASC;

/* Challenge 2 */
/* 1.1 The total number of films that have been released. */
SELECT COUNT(film_id)
FROM sakila.film;

/* 1.2 The number of films for each rating. */
SELECT rating, COUNT(*) AS num_films
FROM sakila.film
GROUP BY rating;

/* 1.3 The number of films for each rating, and sort the results in descending order of the number of films */
SELECT rating, COUNT(*) AS num_films
FROM sakila.film
GROUP BY rating
ORDER BY num_films DESC;

/* 2. Determine the number of rentals processed by each employee */
SELECT staff_id, COUNT(rental_id) AS num_employee
FROM sakila.rental
GROUP BY staff_id;

/* 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. */
SELECT rating, round(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;

/* 3.2 Identify which ratings have a mean duration of over two hours */
SELECT rating, round(AVG(length), 2) AS mean_duration 
FROM sakila.film
GROUP BY rating
HAVING mean_duration > 120;

/* 4. Determine which last names are not repeated in the table actor. */
SELECT DISTINCT last_name
FROM sakila.actor;