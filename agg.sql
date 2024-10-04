## Challenge 1

# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;
SELECT min(length) as min_duration, max(length) as max_duration FROM film;
# 1.2. Express the average movie duration in hours and minutes. Don't use decimals. 
SELECT avg(length)/60 FROM FILM;
SELECT CONCAT( FLOOR(avg(length)/60), ':' , round(avg(length)%60,0))
FROM film;

# 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(max(last_update), min(rental_date)) FROM rental;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
Alter table rental
add column month int,
add column weekday tinytext;
SET SQL_SAFE_UPDATES = 0;
UPDATE rental
SET month = DATE_FORMAT(rental_date, '%m'),
    weekday = DATE_FORMAT(rental_date, '%W');
Select * from rental limit 20;
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
#Hint: use a conditional expression. 
ALTER table rental add column day_type tinytext;
UPDATE rental SET day_type = CASE WHEN weekday = "Saturday" OR weekday="Sunday" THEN "weekend" ELSE "workday" END;

#3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL,
# replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.

SELECT title, rental_duration as duration 
FROM film;

Update film
set rental_duration = case
WHEN rental_duration IS NULL THEN "Not Avaliable" ELSE rental_duration END;

Select title, IFNULL(rental_duration,"Not Avaliable") as rental_duration
FROM film
Order by title ASC;

#Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
# To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can 
# address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT CONCAT(first_name," ",last_name) as name, Substring(email,1,3) as email
From customer
ORDER BY last_name ASC;

#Challenge 2
# Using the film table, determine:
# 1.1 The total number of films that have been released.
Select count(*) as nr_films from film;

#1.2 The number of films for each rating.
SELECT count(*) as nr_films, rating
FROM film
Group BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings 
# and adjust purchasing decisions accordingly.
Select count(*), rating
from film
group by rating
order by rating desc;

#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
Select round(avg(length),2) as mean_duration, rating
from film
group by rating
order by mean_duration desc;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, round(avg(length),2) as mean_duration
from film
group by rating
HAVING mean_duration >= 120
order by mean_duration desc
;

#Bonus: determine which last names are not repeated in the table actor.
select *,  last_name
from actor
Where last_name In(
select last_name
from actor
group by last_name
having count(*) = 1);
