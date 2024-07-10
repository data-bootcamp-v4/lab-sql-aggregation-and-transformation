Use sakila ;
SHOW tables;

SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

SELECT 
    FLOOR(AVG(duration) / 60) AS avg_hours, 
    FLOOR(MOD(AVG(duration), 60)) AS avg_minutes
FROM 
    movies;
    show tables 
    
#You need to gain insights related to rental dates:

select datediff(max(rental_date) as rental_month 

#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
#You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

select title, ifnull (rental_duration, "not available") as rental duration 
from film 
order by title asc;

select date_format(rental_date, "%M"), date_format (rental_date, "%W")
from rental;

select*, 
Case
when dayname (rental_date) in ("saturday", "Sunday") then "weekend"
else "weekday"

#3

select rating, round(avg(lenght),2) as long_duraction

