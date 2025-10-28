## CHALLENGE 1
## You need to use SQL built-in functions to gain insights relating to the duration of movies: 

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT max(length) AS longest_duration, min(length) AS shortest_duration FROM film;
#1.2 Express the average movie duration in hours and minutes. Don't use decimals
SELECT floor(AVG(length)/60) AS Average_hour_duration, round(AVG(length))%60 AS average_minutes FROM film;

# You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating
SELECT datediff(max(rental_date),min(rental_date)) FROM rental;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, DATE_FORMAT(rental_date,"%m") AS month, DATE_FORMAT(rental_date,"%d") AS day FROM rental;
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *,
CASE 
		WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'Weekend'
		ELSE 'Weekday'
END AS DayType
FROM rental;
#2.4 You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order
SELECT *, IFNULL(rental_duration, "Not available") FROM film
ORDER BY rental_duration ASC;

#4 Bonus: Marketing team
SELECT concat(first_name," ",last_name) AS full_name, LEFT(email,3) AS trunc_email FROM customer
ORDER BY last_name ASC;

## CHALLENGE 2
## Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:

#1.1 The total number of films that have been released
SELECT count(*) FROM film;
#1.2 The number of films for each rating
SELECT rating, count(*) AS number_of_films FROM film
GROUP BY rating;
#1.3 The number of films for each rating 
SELECT rating, count(*) AS number_of_films FROM film
GROUP BY rating
order by number_of_films DESC;

## Using the film table, determine:
#2.1 The mean film duration for each rating
SELECT rating, count(*) AS number_of_films, round(AVG(length),2) AS mean_film_duration FROM film
GROUP BY rating
order by number_of_films DESC;
#2.2 The mean duration of over 2hours
SELECT rating, count(*) AS number_of_films, floor(AVG(length)/60) AS mean_film_duration_hr FROM film
GROUP BY rating
having mean_film_duration_hr>=2
order by number_of_films DESC;

## Bonus
## Unrepeated last_names
SELECT last_name FROM actor
group by last_name
having count(last_name)=1;
