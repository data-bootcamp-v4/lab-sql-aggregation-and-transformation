SELECT
   MAX(length) AS max_duration,
   MIN(length) AS min_duration
FROM film;
#Shortest and Longest Movie Durations
SELECT 
   FLOOR(AVG(length) / 60) AS avg_hours,
   ROUND(AVG(length) % 60) AS avg_minutes
FROM film;
#Average Movie Duration in Hours and Minutes
SELECT 
   DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM 
   rental;
# Number of Days the Company Has Been Operating
SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM
    rental
LIMIT
    20;
# Rental Information and Add Month and Weekday
SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM
    film
ORDER BY 
	title ASC;
#Film titles and their rental duration
SELECT COUNT(*) AS total_films
FROM film;
#Total Number of Films Released
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;
#Number of Films for Each Rating
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;
# Number of Films for Each Rating Sorted in Descending Order
SELECT 
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM
    film
GROUP BY
	rating
ORDER BY
	average_duration DESC;
# Mean Film Duration for Each Rating
SELECT
	rating
FROM
    film
GROUP BY
    rating
HAVING
    AVG(length) > 120;
# Identify Ratings for Films with Mean Duration Over Two Hours