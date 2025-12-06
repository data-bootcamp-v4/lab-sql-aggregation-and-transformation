USE sakila;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM sakila.film;
-- 1.2 Express the average movie duration in hours and minutes.
SELECT CONCAT(FLOOR(AVG(length) / 60), "h", FLOOR(AVG(length) % 60), "m") FROM sakila.film;
-- 2 You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(max(rental_date), min(rental_date)) as DateDiff FROM sakila.rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_id, rental_date, DATE_FORMAT (rental_date, "%M" ) AS month_rental, DATE_FORMAT (rental_date, "%W") AS weekday_rental FROM sakila.rental
limit 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT rental_date, DATE_FORMAT (CONVERT(SUBSTRING_INDEX(rental_date, ' ', 3), DATE), "%W") as DAY_TYPE from sakila.rental
WHERE DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 3), DATE), "%W") in ('Saturday', 'Sunday');
-- 3.You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;
-- 4.Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT CONCAT(first_name,' ', last_name,' ', email), LEFT(email, 3) FROM sakila.customer
ORDER BY last_name ASC;
-- Challenge 2
-- 1.1 The total number of films that have been released.
SELECT count(film_id) from sakila.film;
-- 1.2 The number of films for each rating.
SELECT DISTINCT rating as film_rating, 
count(film_id) as number_of_films from sakila.film
group by rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating as film_rating, 
count(film_id) as number_of_films from sakila.film
group by rating
order by number_of_films DESC;
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating as film_rating, 
round(avg(length),2) as average_duration from sakila.film
group by rating
order by average_duration DESC;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating as film_rating, 
round(avg(length),2) as average_film_duration,
concat(floor(avg(length)/ 60), "h", floor(avg(length) % 60), "m") as average_duration from sakila.film
group by rating
having avg(length) > 120
order by average_film_duration DESC;
-- 3 Bonus: determine which last names are not repeated in the table actor.
Select last_name from sakila.actor
group by last_name
having count(*) = 1
order by last_name;

