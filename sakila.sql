#1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	# 1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
    SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;
	# 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
    SELECT CONCAT(FLOOR(length/60),':',LPAD(MOD(length,60),2,'0')) FROM film;

#2. You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating.
	#Hint: To do this, use the `rental` table, and the `DATEDIFF()` function to subtract the earliest date in the `rental_date` column from the latest date.*
    SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating FROM rental;
#2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
	SELECT *, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday FROM rental;
#2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.*
	#Hint: use a conditional expression.*
    SELECT *, 
    CASE 
		WHEN dayofweek(rental_date) < 5 THEN 'workday'
        ELSE 'weekend'
	END AS day_type
    FROM rental;

#3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the **film titles and their rental duration**. 
#If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results of the film title in ascending order.
WITH 
r AS (SELECT inventory_id, DATEDIFF(return_date, rental_date) AS rental_duration,
CASE
	WHEN return_date IS NULL THEN 'Not Available'
	ELSE 'Available'
END AS availability
FROM rental
WHERE return_date IS NOT NULL),

i AS (SELECT inventory.film_id, r.rental_duration, r.availability
FROM inventory
JOIN (r)
ON inventory.inventory_id = r.inventory_id)
        
SELECT film.title, i.availability
FROM film
JOIN (i)
ON film.film_id = i.film_id
ORDER BY film.title ASC;
