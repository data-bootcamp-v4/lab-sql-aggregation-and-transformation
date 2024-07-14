USE sakila;

# Challange 1
# 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select title, max(length) as max_duration
from film
group by title
order by max_duration desc
limit 1;

select title, min(length) as min_duration
from film
group by title
order by min_duration asc
limit 1;

# or
select max(length) as max_duration, min(length) as min_duration
from film;

	# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
		 # Hint: Look for floor and round functions.

select floor(avg(length) / 60) as hours,
	   round(avg(length) % 60) as min
from film;

# 2. You need to gain insights related to rental dates:
	# 2.1 Calculate the number of days that the company has been operating.
		# Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
	
select datediff(max(rental_date), min(rental_date)) as days_operating
from rental; 

    # 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select * , monthname(rental_date) as month, dayname(rental_date) as day
from rental
limit 20;

# or
SELECT *, DATE_FORMAT(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY
FROM rental
LIMIT 20;

	# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
	# Hint: use a conditional expression.

select *, 
case
	when dayname(rental_date) in ("Saturday", "Sunday") then "weekend"
    else "weekday"
end as day_type
from rental; 

# 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
# If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

# Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
# Hint: Look for the IFNULL() function.

SELECT title, IFNULL(rental_duration, 'Not available') as rental_duration
FROM film 
ORDER BY title ASC;

# Challenge 2
# 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
	# 1.1 The total number of films that have been released.
    
SELECT count(release_year)
FROM film;
    
	# 1.2 The number of films for each rating.
    
SELECT rating, count(rating)
FROM film
GROUP BY rating;

	# 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand 
    # the popularity of different film ratings and adjust purchasing decisions accordingly.
    
SELECT rating, count(rating)
FROM film
GROUP BY rating
ORDER BY rating DESC;

# 2. Using the film table, determine:
	# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
    # This will help identify popular movie lengths for each category.

SELECT rating, round(avg(length),2) AS avg
FROM film
GROUP BY rating
ORDER BY avg DESC;

	# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, round(avg(length),2) AS avg
FROM film
GROUP BY rating
HAVING avg >=120
ORDER BY avg DESC;