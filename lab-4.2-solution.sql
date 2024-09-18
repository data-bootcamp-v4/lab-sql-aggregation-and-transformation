-- Challenge 1

-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	-- 1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
SELECT MIN(sf.length) as min_duration, MAX(sf.length) as max_duration
FROM sakila.film as sf;

	-- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
    -- *Hint: Look for floor and round functions.*
SELECT CONCAT (FLOOR(AVG(sf.length)/60), " hours + ", ROUND(MOD(AVG(sf.length), 60)), " min") as avg_duration
FROM sakila.film as sf;

-- 2. You need to gain insights related to rental dates:
	-- 2.1 Calculate the number of days that the company has been operating
    -- *Hint: To do this, use the `rental` table, and the `DATEDIFF()` function 
    -- Subtract the earliest date in the `rental_date` column from the latest date.*

SELECT DATEDIFF(MAX(sr.rental_date), MIN(sr.rental_date)) as nr_days
FROM sakila.rental as sr;
-- > 266 days

	-- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
SELECT *,  month(sr.rental_date) as rental_month, dayname(sr.rental_date) as rental_weekday
FROM rental as sr;

	-- 2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.*
    -- *Hint: use a conditional expression.*
SELECT * , IF(dayname(sr.rental_date) in ('Saturday', 'Sunday'), "weekend", "workday") as day_type
FROM rental as sr;

SELECT *, 
	weekday(sr.rental_date) as weekday, 
	dayname(sr.rental_date) as dayname, 
    (CASE WHEN weekday > 4 THEN 'weekend' ELSE 'workday' END) AS day_type
FROM rental as sr;

-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- 	To achieve this, retrieve the **film titles and their rental duration**. 
-- 	If any rental duration value is **NULL, replace** it with the string **'Not Available'**. 
-- Sort the results of the film title in ascending order.
    -- *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.*
    -- *Hint: Look for the `IFNULL()` function.*
SELECT f.title, IFNULL(f.rental_duration, "Not Available") as rental_duration
FROM sakila.film as f
ORDER BY f.title;


-- 4. *Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the **concatenated first and last names of customers**, along with the **first 3 characters of their email** address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.*

-- Challenge 2

-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
	-- 1.1 The **total number of films** that have been released.
SELECT COUNT(sf.film_id) as total_films
FROM sakila.film as sf;

	-- 1.2 The **number of films for each rating**.
SELECT sf.rating, COUNT(sf.film_id) as total_films
FROM sakila.film as sf
GROUP BY sf.rating;

	-- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
SELECT sf.rating, COUNT(sf.film_id) as total_films
FROM sakila.film as sf
GROUP BY sf.rating
ORDER BY total_films desc;

	-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
-- 2. Using the `film` table, determine:
    -- 2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. 
    -- Round off the average lengths to two decimal places. 
    -- This will help identify popular movie lengths for each category.
SELECT sf.rating, ROUND(AVG(sf.length), 2) as mean_duration
FROM sakila.film as sf
GROUP BY sf.rating
HAVING mean_duration > 120
ORDER BY mean_duration desc;

    -- 2.2 Identify **which ratings have a mean duration of over two hours** 
    -- This will help select films for customers who prefer longer movies.
SELECT sf.rating, ROUND(AVG(sf.length), 2) as mean_duration
FROM sakila.film as sf
GROUP BY sf.rating
ORDER BY mean_duration desc;

-- 3. *Bonus: determine which last names are not repeated in the table `actor`.*
SELECT a.last_name, COUNT(distinct(a.actor_id)) as repetitions
FROM sakila.actor as a
GROUP BY a.last_name
HAVING repetitions = 1