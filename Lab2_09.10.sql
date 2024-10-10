# Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film; 

# Express the average movie duration in hours and minutes
SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes
FROM film;

# Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

# #Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results

ADD month VARCHAR(45),
ADD  weekday VARCHAR(45);
SELECT *
FROM rental
LIMIT 20;
SHOW COLUMNS FROM rental;

# Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *
 MONTHNAME()
 DAYNAME()
    CASE
        WHEN weekday IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'workday'
        WHEN weekday IN ('Saturday', 'Sunday') THEN 'weekend'
    END AS DAY_TYPE
FROM rental;

# Retrieve the film titles and their rental duration
SELECT film_id, title, IFNULL(rental_duration, 'Not available') AS rental_duration
FROM film
ORDER BY title ASC;
	
# Challenge 2. The total number of films that have been released
SELECT COUNT(film_id) AS film_count
FROM film;

# The number of films for each rating
SELECT COUNT(film_id) AS film_count
FROM film
GROUP BY rating;

# The number of films for each rating, sorting the results in descending order of the number of films
SELECT rating, COUNT(film_id) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

# The mean film duration for each rating, and sort the results in descending order of the mean duration
SELECT rating, ROUND(AVG(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
ORDER BY avg_film_duration DESC;

# Identify which ratings have a mean duration of over two hours 
SELECT rating, ROUND(AVG(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
HAVING avg_film_duration > 120;

# Determine which last names are not repeated in the table actor
SELECT DISTINCT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
