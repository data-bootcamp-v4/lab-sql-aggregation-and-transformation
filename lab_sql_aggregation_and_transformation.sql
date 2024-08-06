#CHALLENGE 1.
#You need to use SQL built-in functions to gain insights relating to the duration of movies:
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
	SELECT MAX(length) AS max_duration , MIN(length) AS min_duration
    FROM film;
#1.2. Express the average movie duration in hours and minutes. Don't use decimals
	SELECT length,concat( floor(length/60)  , ' hr',  (length - 60*floor(length/60))  ,' mins') AS avg_movie_length
    FROM film;
	
#2.1 Calculate the number of days that the company has been operating

	SELECT datediff(max(rental_date),min(rental_date))
    FROM rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

	SELECT * , DATE_FORMAT(rental_date, '%M') AS rental_month, DATE_FORMAT(rental_date, "%W") AS rental_weekday
    FROM rental;
    
#3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
	#If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
	
    SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration
    FROM film
    ORDER BY title;
    
#CHALLENGE 2

#Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.

SELECT COUNT( film_id) AS total_films_released
FROM film;
    
#1.2 The number of films for each rating.

SELECT rating, count(title)
FROM film
GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity 
#of different film ratings and adjust purchasing decisions accordingly.

SELECT rating, count(title) as number_of_movies
FROM film
GROUP BY rating
ORDER BY number_of_movies DESC;

#2. Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating , ROUND(AVG(length),2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies

SELECT rating , ROUND(AVG(length),2) AS avg_length
FROM film
GROUP BY rating
HAVING avg_length > 120
ORDER BY avg_length DESC;
