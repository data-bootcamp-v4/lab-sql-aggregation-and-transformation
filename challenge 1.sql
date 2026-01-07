-- ===============================================================================================================
USE sakila;
-- ===============================================================================================================
-- CHALLENGE 1
-- ===============================================================================================================

-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
--
-- 1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
-- a) shortest movie duration as min_duration
SELECT * FROM film WHERE length = (SELECT MIN(length) FROM film);
SELECT COUNT(DISTINCT film_id) FROM film AS min_duration WHERE length = (SELECT MIN(length) FROM film);
--
-- b) longest movie duration as max_duration
SELECT * FROM film WHERE length = (SELECT MAX(length) FROM film);
SELECT COUNT(DISTINCT film_id) FROM film AS max_duration WHERE length = (SELECT MAX(length) FROM film);

--
-- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
-- *Hint: Look for floor and round functions.*
-- avg_duration in hours and minutes not decimals

-- decimal 
SELECT AVG(length) AS avg_duration FROM film;
-- in hours and minutes
-- method 1
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(AVG(length) % 60) AS minutes 
FROM film;
-- method 2
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes -- rounds minutes to nearest integer
FROM film;
-- method 3
SELECT 
    CONCAT(FLOOR(AVG(length)/60), 'h ', FLOOR(AVG(length) % 60), 'm') AS avg_duration
FROM film;
-- ===============================================================================================================
-- 2. You need to gain insights related to rental dates:
--
-- 2.1 Calculate the **number of days that the company has been operating**.
-- *Hint: 
-- To do this, use the `rental` table, 
-- and the `DATEDIFF()` function to subtract the earliest date in the `rental_date` column from the latest date.*
-- not including the first day as operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS nbr_days_operating FROM rental;
-- including the first day as operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))+1 AS nbr_days_operating FROM rental;

--
-- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. 
-- Return 20 rows of results.
--
SELECT * FROM rental LIMIT 20; -- limit to 20 rows the rental table
-- 
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    DATEDIFF(return_date, rental_date) AS rental_duration,
    MONTH(rental_date) AS rental_month, -- MONTH() for numerical month, MONTHNAME() for categorical month name 
    DAYNAME(rental_date) AS rental_weekday -- DAY() for numerical day, DAYNAME() for categorical day name
FROM rental
LIMIT 20;
--
-- 2.3 *Bonus: Retrieve rental information 
-- and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.*
-- *Hint: use a conditional expression.*
SELECT * FROM rental LIMIT 20; -- limit to 20 rows the rental table
--
-- ----------------------------
-- method long
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    DATEDIFF(return_date, rental_date) AS rental_duration,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYNAME(rental_date) = 'Saturday' THEN 'weekend'
        WHEN DAYNAME(rental_date) = 'Sunday' THEN 'weekend'
        ELSE 'workday'
	END AS day_type
FROM rental
LIMIT 20;
-- ----------------------------
-- method short
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    DATEDIFF(return_date, rental_date) AS rental_duration,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYNAME(rental_date) = 'Saturday' THEN 'weekend'
        WHEN DAYNAME(rental_date) = 'Sunday' THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;
-- ===============================================================================================================
-- 3. You need to ensure that customers can easily access information about the movie collection. 
--  achieve this, retrieve the **film titles and their rental duration**. 
-- If any rental duration value is **NULL, replace** it with the string **'Not Available'**. 
-- Sort the results of the film title in ascending order.
--
-- *Please note that even if there are currently no null values in the rental duration column,*
-- *the query should still be written to handle such cases in the future.*
-- *Hint: Look for the `IFNULL()` function.*
-- ------------------------------------------------------------------------------------------
-- all films with their title and rental duration
SELECT title, rental_duration FROM film;
-- replace nulls with string 'Not Available'
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film;
-- Sort the results of the film title in ascending order.
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film ORDER BY title ASC;
-- ===============================================================================================================
-- 4. *Bonus: 
-- The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
	-- PERSONALIZED EMAIL COMPAIGN for CUSTOMERS 
-- To achieve this, you need to retrieve the **concatenated first and last names of customers**, 
-- along with the **first 3 characters of their email** address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.*
-- ------------------------------------------------------------------------------------------
-- retrieve the 
	-- **concatenated first and last names of customers**
	-- with the **first 3 characters of their email address**
    -- results should be **ordered by**  **last name** in **ascending order**
-- ------------------------------------------------------------------------------------------
-- columns to use first_name, last_name, email
SELECT first_name, last_name, email FROM customer ORDER BY last_name ASC;
-- concat as full_name
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM customer ORDER BY last_name ASC;
-- email first 3 characters
SELECT email FROM customer;
SELECT LEFT(email, 3) AS email_first3 FROM customer; -- LEFT(column, #)
-- combine answers full_name and email_first3
SELECT
	CONCAT(first_name, ' ', last_name) AS full_name,
	LEFT(email, 3) AS email_first3
FROM customer ORDER BY last_name ASC;
-- ===============================================================================================================