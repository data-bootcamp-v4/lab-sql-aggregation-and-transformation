/*
# Lab | SQL Data Aggregation and Transformation

  This lab allows you to practice and apply the concepts and techniques taught in class. 

  Upon completion of this lab, you will be able to:
  
- Use SQL built-in functions such as COUNT, MAX, MIN, AVG to aggregate and summarize data, and use GROUP BY to group data by specific columns. Use the HAVING clause to filter data based on aggregate functions. 
- Use SQL to clean, transform, and prepare data for analysis by handling duplicates, null values, renaming columns, and converting data types. Use functions like ROUND, DATE_DIFF, CONCAT, and SUBSTRING to manipulate data and generate insights.
- Use conditional expressions for creating new columns. 


Before this starting this lab, you should have learnt about:

- SELECT, FROM, ORDER BY, LIMIT, WHERE, GROUP BY, and HAVING clauses.
- DISTINCT keyword to return only unique values, AS keyword for using aliases.
- Built-in SQL functions such as COUNT, MAX, MIN, AVG, ROUND, DATEDIFF, or DATE_FORMAT.
- CASE statement for conditional logic.


## Introduction

Welcome to the SQL Data Aggregation and Transformation lab!

In this lab, you will practice how to use SQL queries to extract insights from the  [Sakila](https://dev.mysql.com/doc/sakila/en/) database which contains information about movie rentals. 

You will build on your SQL skills by practicing how to use the `GROUP BY` and `HAVING` clauses to group data and filter results based on aggregate values. You will also practice how to handle null values, rename columns, and use built-in functions like `MAX`, `MIN`, `ROUND`, `DATE_DIFF`, `CONCAT`, and `SUBSTRING` to manipulate and transform data for generating insights.

Throughout the lab, you will work with two SQL query files: `sakila-schema.sql`, which creates the database schema, and `sakila-data.sql`, which inserts the data into the database. You can download the necessary files locally by following the steps listed in [Sakila sample database - installation](https://dev.mysql.com/doc/sakila/en/sakila-installation.html). 

You can also refer to the Entity Relationship Diagram (ERD) of the database to guide your analysis:

<br>


## Challenge 2

1. Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
	- 1.1 The **total number of films** that have been released.
	- 1.2 The **number of films for each rating**.
	- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
	This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
2. Using the `film` table, determine:
   - 2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
	- 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select films for customers who prefer longer movies.
3. *Bonus: determine which last names are not repeated in the table `actor`.*

*/
-- Challenge 1
USE sakila;

-- Find min and max movie durations
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM sakila.film;

-- Calculate average movie duration and divide into hours and minutes
SELECT 
    AVG(length) DIV 60 AS avg_duration_hours,  
    AVG(length) % 60 AS avg_duration_minutes 
FROM sakila.film;

-- calculate no of days company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM sakila.rental;

-- rental info with month and weekday
SELECT 
    rental_id, 
    rental_date, 
    customer_id, 
    inventory_id, 
    staff_id, 
    DATEDIFF(return_date, rental_date) AS rental_duration,
    MONTH(rental_date) AS rental_month,
    DAYOFWEEK(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

-- Rental info with day type
SELECT 
    rental_id, 
    rental_date, 
    customer_id, 
    inventory_id, 
    staff_id, 
    DATEDIFF(return_date, rental_date) AS rental_duration,
    MONTH(rental_date) AS rental_month,
    DAYOFWEEK(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM sakila.rental
LIMIT 20;

-- FIlm titles and rental duration
SELECT 
    f.title, 
    IFNULL(DATEDIFF(r.return_date, r.rental_date), 'Not Available') AS rental_duration
FROM sakila.film f
LEFT JOIN sakila.inventory i ON f.film_id = i.film_id
LEFT JOIN sakila.rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title ASC;

-- Challenge II 
SELECT COUNT(*) AS total_films
FROM sakila.film;

-- Determine the number of films per rating
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating;

-- Determine the number of films for each rating, sorted in descending order
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Determine mean film duration
SELECT rating, 
       ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;

 -- Identify Ratings with a Mean Duration Over Two Hours
SELECT rating, 
       ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;

-- BONUS : Determine which last names are not repeated
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;


