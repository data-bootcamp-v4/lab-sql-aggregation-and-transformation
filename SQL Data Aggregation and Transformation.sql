USE sakila;
SELECT * FROM film;
-- 1.1 Determine the **shortest and longest movie durations** and name the values 
-- as `max_duration` and `min_duration`-- 
SELECT
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM
    film;

-- Express the **average movie duration in hours and minutes**. Don't use decimals.--

SELECT
    FLOOR(AVG(length) / 60) AS hours,
    MOD(AVG(length), 60) AS minutes
FROM
    film;
-- Calculate the **number of days that the company has been operating**.
-- *Hint: To do this, use the `rental` table, and the `DATEDIFF()` 
-- function to subtract the earliest date in the `rental_date` column from the latest date.--
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM
    rental;
    
-- Retrieve rental information and add two additional columns --
-- to show the **month and weekday of the rental**. Return 20 rows of results.--
SELECT * FROM rental
SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM
    rental
LIMIT 20;

-- - 2.3 *Bonus: Retrieve rental information and add an additional 
-- column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.--
 -- *Hint: use a conditional expression.* --

SELECT
    *,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM
    rental
LIMIT 20;

-- You need to ensure that customers can easily access information --
-- about the movie collection. To achieve this, retrieve the --
-- film titles and their rental duration**. If any rental duration value --
-- is **NULL, replace** it with the string **'Not Available'**. --
-- Sort the results of the film title in ascending order.--
SELECT * FROM film;
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;
    
-- 1.1 The **total number of films** that have been released. --
SELECT * FROM film;
SELECT COUNT(title) AS total_titles
FROM film;
    

-- The **number of films for each rating**. --

SELECT
    rating,
    COUNT(*) AS film_count
FROM
    film
GROUP BY
    rating
ORDER BY 
    film_count ASC;
    
-- 2.1 The **mean film duration for each rating**, and sort --
-- the results in descending order of the mean duration. Round off --
--   the average lengths to two decimal places. This will help identify --
--   popular movie lengths for each category --

SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
    film
GROUP BY
    rating
ORDER BY
    mean_duration DESC;
    
-- - 2.2 Identify **which ratings have a mean duration of over two hours** --
 -- in order to help select films for customers who prefer longer movies. -- 
 
 SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
    film
GROUP BY
    rating
HAVING
    mean_duration > 120;
    
 --  *Bonus: determine which last names are not repeated in the table `actor`.*--  
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;