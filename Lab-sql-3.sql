Use sakila;
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select max(length) as max_duration from film;
select min(length) as min_duration from film;
# 1.2. Express the average movie duration in hours and minutes. Don't use decimals
SELECT 
    CONCAT(
        floor(AVG(length) / 60), -- Calculate average hours
        ' hours ',
        round(AVG(length) % 60), -- Calculate average minutes
        ' minutes'
    ) AS average_duration
FROM 
    film;
# 2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(max(rental_date) , min(rental_date)) AS days_operating FROM rental;
# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results
SELECT
	DATE_FORMAT(rental_date, '%M') AS month_of_rental,
	DATE_FORMAT(rental_date, '%W') AS weekday_of_rental
FROM rental
LIMIT 20;
# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT
CASE
WHEN DATE_FORMAT(rental_date, '%W') = "Saturday" OR DATE_FORMAT(rental_date, '%W') = "Sunday" THEN "weekend"
ELSE "workday"
END
AS DAY_TYPE
FROM rental;
# 3. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
select title, ifnull(rental_duration,"Not available") as availability
from film
order by title;

select count(distinct film_id) as amount_movies
from film;

# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
# 1.1 The total number of films that have been released.
# 1.2 The number of films for each rating.
# 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select count(film_id) as count_of_movies
from film;
SELECT COUNT(*) AS total_films
FROM film;
#The number of films for each rating.
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;
#The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

# Using the film table, determine:
# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, round(avg(length),2) as avg_duration
from film
group by rating
order by avg_duration desc;

select rating, round(avg(length),2) as avg_duration
from film
group by rating
order by avg_duration > 120;


