-- CHALLENGE 1

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT 
	min(length) as min_duration, 
    max(length) as max_duration

FROM film; 

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
	FLOOR(AVG(length)/ 60) as hours,
    ROUND(AVG(length)) % 60 as minutes
FROM film; 

-- 2.1 Calculate the number of days that the company has been operating.

SELECT 
	
    datediff(max(rental_date), min(rental_date)) as number_of_days_operating

FROM rental; 

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *, 
		MONTH(rental_date) as month_rental, 
        dayname(rental_date) as weekday_rental

FROM rental
LIMIT 20; 




-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT *, 
	dayname(rental_date) as name_day, 
    CASE
		WHEN dayname(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
	END AS DAY_TYPE

	
    
FROM rental; 

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT
	title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration

FROM film
ORDER BY title ASC; 

-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT 
	concat(first_name, ' ', last_name) as full_name, 
    left(email,3) as first_3_email

FROM customer
ORDER BY last_name ASC; 


-- CHALLENGE 2

-- 1. film table

-- 1.1 The total number of films that have been released 

SELECT  count(*) as total_film

from film; 

-- 1.2 Number of films of each rating 

SELECT rating, 
		count(*) as number_film

FROM film
group by rating; 

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 


SELECT rating, 
		count(*) as number_film

FROM film
group by rating
ORDER BY number_film DESC; 

-- 2. Film table

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, 
		ROUND(AVG(length),2) as mean_duration
        
FROM film
group by rating
ORDER BY mean_duration DESC; 

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT 
	rating, 
    AVG(length) as mean_duration 
FROM film 
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC; 

-- 3. determine which last names are not repeated in the table actor

SELECT 
	last_name, 
    count(*) as count_last_name

FROM actor
GROUP BY last_name
HAVING count_last_name = 1;