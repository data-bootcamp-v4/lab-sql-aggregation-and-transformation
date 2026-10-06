use sakila;
#1.You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration from film;
-- min = 46 , max= 185
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select floor(round(avg(length))/60) as hour ,round(avg(length))%60  as minutes from film;
-- Hint: Look for floor and round functions.
#You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select * from rental;
select datediff(max(rental_date),min(rental_date)) from rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *, date_format(rental.rental_date , "%M") as month ,date_format(rental.rental_date , "%W") as weekday from rental limit 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
select * , 
case
when date_format(rental.rental_date , "%W")= 'Saturday'then 'weekend'
when date_format(rental.rental_date , "%W")= 'Sunday'then 'weekend'
else 'workday'
end as 'Day_TYPE'
from rental;
#3.You need to ensure that customers can easily access information about the movie collection.
--  To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
select title , ifnull(rental_duration,'Not available') from film order by title asc;
#4.#bonus 
SELECT  email ,CONCAT(first_name, ' ',last_name ) AS full_name,substring(email,1,3) as email_prefix  FROM customer order by last_name asc ;
#Challenge 2 :
-- 1.1 The total number of films that have been released.
select count(film_id) from film;
-- 1.2 The number of films for each rating.
select rating ,count(film_id) from film group by rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
select  rating ,count(film_id) as number_of_films from film group by rating order by number_of_films desc;
--  This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.\
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
--  This will help identify popular movie lengths for each category.
select  rating ,round(avg(length),2) as AVG_duration from film group by rating order by AVG_duration desc;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select  rating ,round(avg(length),2) as AVG_duration from film group by rating having AVG_duration > 120 order by AVG_duration desc ;
# 3.Bonus 
select last_name , count(last_name) from actor group by last_name having count(last_name) = 1 ;

