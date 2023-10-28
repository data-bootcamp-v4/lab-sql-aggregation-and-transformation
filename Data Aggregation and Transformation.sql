/*1.1 Determine the **shortest and longest movie durations** and name the values as max_duration and min_duration.*/
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;

/*1.2. Express the **average movie duration in hours and minutes**. Don't use decimals. *Hint: look for floor and round functions.*/
SELECT CONCAT(FLOOR(AVG(length) / 60), ' hours ', ROUND(AVG(length) % 60), ' minutes') AS average_duration
FROM film;

/*2.1 Calculate the **number of days that the company has been operating*/
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

/*2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.*/
SELECT rental.rental_date, 
    MONTHNAME(rental.rental_date) AS Rental_Month, 
    DAYNAME(rental.rental_date) AS Rental_Weekday
FROM 
    rental
LIMIT 20;

/*2.3 Retrieve rental information and add an additional column called DAY_TYPE with values **'weekend' or 'workday'**/
SELECT rental.rental_id, rental.rental_date,
CASE WHEN DAYNAME(rental.rental_date) IN ('Saturday', 'Sunday') THEN 'weekend' ELSE 'workday' END AS DAY_TYPE
FROM rental;

/*3. retrieve the **film titles and their rental duration**. If any rental duration value is **NULL, replace** it with the string **'Not Available'**. 
/*Sort the results by the film title in ascending order.*/
SELECT title,
       IFNULL(rental_duration, 'Not Available') AS Available
FROM sakila.film
ORDER BY title ASC;

/*4 retrieve the **concatenated first and last names of our customers**, along with the **first 3 characters of their email** address
ordered by last name in ascending order */

SELECT CONCAT(first_name," ",last_name) AS customer_name, LEFT(email, 3) as email3charc 
FROM sakila.customer
ORDER BY last_name ASC;

/*Challenge 2
# 1.1 - total number of films** that have been released.*/
SELECT COUNT(film_id) as Number_film_Released
FROM sakila.film;

/*#1.2 - number of films for each rating**.*/
SELECT rating, COUNT(rating) AS Rating
FROM sakila.film
GROUP BY rating;

/*1.3 - The **number of films for each rating, and sort**  descending order of the number of films.*/
SELECT rating, COUNT(rating) AS Rating_Count
FROM sakila.film
GROUP BY rating
ORDER BY Rating_Count DESC;

/*2 Using the rental table, determine the **number of rentals processed by each employee*/
SELECT staff_id, COUNT(rental_id) AS Rentalperemployee
FROM sakila.rental
GROUP BY staff_id;

/*3.1 mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.*/

SELECT rating, CONCAT(FLOOR(AVG(length) / 60), ' h ', ROUND(AVG(length) % 60), ' m') AS MeanDuration
FROM sakila.film
GROUP BY rating
ORDER BY MeanDuration DESC;

/*3.2 Identify **which ratings have a mean duration of over two hours**, to help us select films for customers who prefer longer movies.*/
SELECT rating, CONCAT(FLOOR(AVG(length) / 60), ' h ', ROUND(AVG(length) % 60), ' mnt') AS MeanDuration
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120; /* 120 = 2 hours*/

/*4. Determine which last names are not repeated in the table actor.*/
SELECT last_name
FROM sakila.actor 
GROUP BY last_name
HAVING(COUNT(last_name) = 1)






