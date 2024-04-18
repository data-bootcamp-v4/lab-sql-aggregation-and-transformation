USE sakila;


#1.1 Determine the shortest and longest movie durations 
#and name the values as max_duration and min_duration

SELECT MIN(length) AS min_duration,
       MAX(length) AS max_duration
FROM film;

#1.2 Calculate the average movie duration in hours and minutes, 
#FLOOR, ROUND
# divides by 60 to convert it to hours. 

SELECT FLOOR(AVG(length) / 60) AS average_hours,
       ROUND(AVG(length) % 60) AS average_minutes
FROM film;


#2.1 Calculate the number of days that the company has been operating.
#use the rental table, and the DATEDIFF() function to subtract 
#DATEDIFF() function calculates the difference in days between the latest min/max

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;



#2.2 Retrieve rental information and 
#add two additional columns to show the month and weekday of the rental. 
#Return 20 rows of results.
#MONTH(rental_date): function extracts the month from the rental_date column.
#DAYNAME(rental_date): This function returns the name of the weekday from the rental_date

SELECT rental_id, rental_date,
       MONTH(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;


#3 retrieve the film titles and their rental duration. 
#If any rental duration value is NULL, replace it with the string 'Not Available'.


SELECT title, 
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title;


#challenge 2
#

#1.1 Calculate the total number of films released

SELECT COUNT(*) AS total_films
FROM film;

#1.2 Count the number of films for each rating
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

# 1.3 Count the number of films for each rating and sort by count in descending order
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;










