USE sakila;
-- --------------------------------------------------------
# Challenge 1
-- --------------------------------------------------------

-- --------------------------------------------------------
# 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- --------------------------------------------------------
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(length)/ 60) AS hours, MOD(FLOOR(AVG(length)), 60) AS minutes
FROM film;

-- --------------------------------------------------------
# 2. You need to gain insights related to rental dates:
-- --------------------------------------------------------
# 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(
	MAX(rental_date),
    MIN(rental_date)
)
FROM rental;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,
	DATE_FORMAT(rental_date, "%M") AS month,
    DATE_FORMAT(rental_date, "%W") AS weekday
FROM rental
LIMIT 20;

# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT rental_date,
	    DATE_FORMAT(rental_date, "%W") AS weekday,
CASE
	WHEN DAYOFWEEK(rental_date) IN (1,7) THEN "weekend" # 1 = Sunday, 7 = Saturday
    ELSE "workday"
END AS DAY_TYPE
FROM rental;

-- --------------------------------------------------------
# 4. BONUS: concat first & last names of customers, first 3 char of email address.
-- --------------------------------------------------------
SELECT * FROM customer;

SELECT CONCAT(first_name, " ", last_name) AS customer_full_name,
	SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- --------------------------------------------------------
# Challenge 2
-- --------------------------------------------------------

-- --------------------------------------------------------
# 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- --------------------------------------------------------
# 1.1 The total number of films that have been released.
SELECT COUNT(DISTINCT title) FROM film;

# 1.2 The number of films for each rating.
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC;

-- --------------------------------------------------------
# 3. BONUS: determine which last names are not repeated in the table actor.
-- --------------------------------------------------------
SELECT last_name, COUNT(*) AS name_count # Counts how many are in each group
FROM actor
GROUP BY last_name 
HAVING name_count = 1; # Only keeps names that appear once