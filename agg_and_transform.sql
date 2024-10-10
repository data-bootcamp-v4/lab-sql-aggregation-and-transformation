# CHALLENGE 1
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
	CONCAT(
		FLOOR(AVG(length)/60), 'h' ,
        ROUND(AVG(length)%60), 'min' 
			) AS Duration
FROM film;

# 2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date) , MIN(rental_date)) AS "Operating days"
FROM rental;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT * , MONTH(rental_date) AS 'Rentmonth', DAYNAME(rental_date) AS 'Weekday'
FROM rental;

# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT * , MONTH(rental_date) AS 'Rentmonth', DAYNAME(rental_date) AS 'Day',
	CASE 
		WHEN DAYNAME(rental_date) LIKE 'Saturday' OR DAYNAME(rental_date) LIKE 'Sunday' THEN 'weekend'
		ELSE 'workday'
    END AS 'Day_type'
FROM rental;

# 3 Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, 'Not Available') AS 'rental_duration'
FROM film
ORDER BY title ASC; 

#################################################################  CHALLENGE 2  ############################################################

# 1.1 The total number of films that have been released.
SELECT COUNT(film_id) 
FROM film;


# 1.2 The number of films for each rating.
SELECT COUNT(film_id) AS 'num_per_rating', rating
FROM film
GROUP BY rating;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films
SELECT COUNT(film_id) AS 'num_per_rating', rating
FROM film
GROUP BY rating
ORDER BY num_per_rating DESC;

# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
SELECT ROUND(AVG(length),2) AS 'average_len', rating
FROM film
GROUP BY rating
ORDER BY average_len DESC;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

# 3 Bonus: determine which last names are not repeated in the table actor
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;
