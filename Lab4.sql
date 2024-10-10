# Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT MIN(length) AS min_duration, MAX(length) AS min_duration
FROM film; 

# Express the average movie duration in hours and minutes. Don't use decimals
SELECT AVG(length)
FROM film;

# Calculate the number of days that the company has been operating
SELECT MIN(rental_date) , MAX(rental_date) 
FROM rental;

SELECT DATEDIFF("2006-02-14",  "2005-05-24") AS Difference;

# #Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results
ALTER TABLE rental
ADD month VARCHAR(45),
ADD  weekday VARCHAR(45);
SELECT rental_id, rental_date, return_date
FROM rental
LIMIT 20;
SHOW COLUMNS FROM rental;

# Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT rental_id, rental_date, return_date,
    CASE
        WHEN weekday IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'workday'
        WHEN weekday IN ('Saturday', 'Sunday') THEN 'weekend'
    END AS DAY_TYPE
FROM rental;
