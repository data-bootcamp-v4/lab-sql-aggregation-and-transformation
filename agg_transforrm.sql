USE sakila;


#Challenge 1
#1.1 Determinete the shortest and longest movie durations
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

#1.2 Express the average movie duration in hours and minutes
SELECT ROUND(AVG(length)) 
FROM film;


#2.1 Calculate the number of days that the company has been operating
SELECT SUM(DATEDIFF(return_date, rental_date))
FROM rental;

#2.2 Retrieve rental information and add two additional 
# columns to show the month and weekday of the rental.
SELECT *, MONTHNAME(rental_date) AS month_name, 
DAYNAME(rental_date) AS day_name
FROM rental;

#2.3 Bonus: Retrieve rental information and add an additional column called
# DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *, MONTHNAME(rental_date) AS month_name, 
DAYNAME(rental_date) AS day_name,
CASE
	WHEN DAYNAME(rental_date) IN('Sunday','Saturday') THEN 'weekend'
    ELSE 'workday'
END AS day_type
FROM rental;

#3 You need to ensure that customers can easily access information about the movie collection
# To achieve this, retrieve the film titles and their rental duration
SELECT IFNULL(title,'Not Avaliable'), IFNULL(length,'Not Avaliable')
FROM film
ORDER BY title;

#Challenge 2
#1.1 Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine
SELECT COUNT(*) FROM film;

#1.2 The number of films for each rating
SELECT DISTINCT rating, COUNT(*) 
FROM film
GROUP BY rating;

#1.3 The number of films for each rating
SELECT DISTINCT rating, COUNT(*) 
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

#2.1 The mean film duration for each rating, and sort the results in descending order
SELECT DISTINCT rating, ROUND(AVG(length),2)
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films
SELECT rating, ROUND(AVG(length),2) AS aveg
FROM film
GROUP BY rating
HAVING ROUND(AVG(length),2) > 120
ORDER BY aveg DESC;

#3 bonus
SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(last_name) < 2;

