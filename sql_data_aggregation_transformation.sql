# You need to use SQL built-in functions to gain insights relating to the duration of movies:
# Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select title
from film
order by length asc #desc
limit 1;

# Express the average movie duration in hours and minutes. Don't use decimals
select avg(length)
from film;

# You need to gain insights related to rental dates:
# 2.1 Calculate the number of days that the company has been operating
# -> rental date min - last_update
SELECT DATEDIFF(MAX(last_update), MIN(rental_date)) AS operating_days
FROM rental;

# Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
# Return 20 rows of results.
SELECT rental_id,
       rental_date,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_weekday
FROM rental
limit 20;

# Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT rental_id,
       rental_date,
       CASE
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental;

# retrieve the film titles and their rental duration. 
# If any rental duration value is NULL, replace it with the string 'Not Available'. 
# Sort the results of the film title in ascending order.

select title,
from film;

