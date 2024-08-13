# Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT max(length) as 'max_duration', min(length) as 'min_duration'
FROM film;

# Express the average movie duration in hours and minutes. Don't use decimals
SELECT FLOOR(AVG(length)/60) as 'hours', ROUND(AVG(length) % 60) as 'minutes'
FROM film;

# Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) as 'company_operative'
FROM rental;

#Retrieve rental information and add two additional columns to show the month and weekday of the rental.
# Return 20 rows of results.
SELECT DATE_FORMAT(rental_date, '%M') AS 'month', DATE_FORMAT(rental_date, '%W') AS 'weekday'
FROM rental
LIMIT 20;

# Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
# Hint: use a conditional expression
SELECT rental_date,
CASE
	WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
    ELSE 'workday'
END AS day_type
FROM rental;

# Retrieve the film titles and their rental duration.
# If any rental duration value is NULL, replace it with the string 'Not Available'.
# Sort the results of the film title in ascending order.
SELECT IFNULL(rental_duration, 'Not Available') as rental_duration
FROM film
ORDER BY rental_duration ASC;

#Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address.
#The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT CONCAT(first_name, ' ', last_name) as customer_name, SUBSTRING(email, 1, 3) AS email_3_chars
FROM customer
ORDER BY last_name ASC;

# Determine the total number of films that have been released
SELECT COUNT(film_id) as total_films
FROM film;

# Determine the number of films for each rating
SELECT rating, count(film_id) as total_films_rating
FROM film
GROUP BY rating;

# Determine the number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, count(film_id) as total_films_rating
FROM film
GROUP BY rating
ORDER BY total_films_rating DESC;

# Determine the mean film duration for each rating. Sort the results in desc order of the mean duration.
# Round off the average lengths to two decimal places.
SELECT rating, ROUND(AVG(length), 2) as mean_film_duration
FROM film
GROUP BY rating
ORDER BY mean_film_duration DESC;

# Identify which ratings have a mean duration of over two hours
SELECT rating, ROUND(AVG(length), 2) as mean_film_duration
FROM film
GROUP BY rating
HAVING ROUND(AVG(length), 2) > 120;

# Determine which last names are not repeated in the table actor
SELECT DISTINCT last_name
FROM actor

