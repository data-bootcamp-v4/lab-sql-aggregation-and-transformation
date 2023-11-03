/* You need to use SQL built-in functions to gain insights relating to the duration of movies:

1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions. */


#1.1
SELECT title as max_duration
FROM film
ORDER BY length  DESC limit 1;

SELECT title as min_duration
FROM film
ORDER BY length  ASC limit 1;

#1.2 
SELECT 
  CONCAT(FLOOR(AVG(hours)), ":", FLOOR(AVG(minutes))) as average_runtime

FROM
  (SELECT 
    FLOOR(length / 60) AS hours,
    MOD(length, 60) AS minutes
  FROM 
    sakila.film) AS subquery;
    
/* You need to gain insights related to rental dates:

2.1 Calculate the number of days that the company has been operating.
		Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
		Hint: use a conditional expression. */

SELECT DATEDIFF(NOW(), MIN(rental_date)) AS days_operating
FROM sakila.rental;

SELECT *, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

SELECT *, 
       CASE 
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN "Weekend"
           ELSE "Workday"
       END AS DAY_TYPE
FROM sakila.rental;


/* 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the **film titles and their rental duration**. 
If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results of the film title in ascending order.*/

SELECT title, 
       IFNULL(rental_duration, "Not Available") AS rental_duration
FROM sakila.film;


/* *Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
To achieve this, you need to retrieve the **concatenated first and last names of customers**, along with the **first 3 characters of their email** address, 
so that you can address them by their first name and use their email address to send personalized recommendations. 
The results should be ordered by last name in ascending order to make it easier to use the data.* */

SELECT CONCAT(first_name, ' ', last_name) AS full_name, LEFT(email, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name ASC;

/* 1. Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
	- 1.1 The **total number of films** that have been released.
	- 1.2 The **number of films for each rating**.
	- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films. */

select count(title)
from sakila.film;

select rating, count(*)
from sakila.film
group by rating;

select rating, count(*) as count
from sakila.film
group by rating
order by count desc;


/* 2. Using the `film` table, determine:
   - 2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
   This will help identify popular movie lengths for each category.
	- 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select films for customers who prefer longer */

select rating, round(avg(length), 2) as average_length
from sakila.film
group by rating
order by average_length desc;

SELECT rating
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;






