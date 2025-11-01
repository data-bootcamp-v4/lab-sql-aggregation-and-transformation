use sakila;
#1.1
SELECT MAX(length) AS max_duration  FROM film;
SELECT MIN(length) AS min_duration FROM film;

#1.2

SELECT FLOOR(AVG(length) / 60) AS Average_Hours, AVG(length) % 60 AS Average_Minutes From film;

# 2.1

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS Operating_Days FROM rental;

#2.2

SELECT rental_id, rental_date, inventory_id, customer_id, return_date, MONTHNAME(rental_date) AS Rental_Month, DAYNAME(rental_date) AS Rental_Weekday FROM rental LIMIT 20;

#2.3

SELECT
    *, 
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' 
         ELSE 'workday'
    END AS DAY_TYPE
FROM
    rental
LIMIT 20;	

#3
SELECT title AS Film_Title,
    IFNULL(rental_duration, 'Not Available') AS Rental_Duration
FROM film
ORDER BY Film_Title ASC;

#  Challenge 2

SELECT * FROM FILM;

#1.1
SELECT COUNT(film_id) AS Total_Number_of_Films FROM film;

#1.2
SELECT rating, COUNT( film_id) AS number_of_film
FROM film
GROUP BY rating;

#1.3	
SELECT rating, COUNT( film_id) AS number_of_film
FROM film
GROUP BY rating
ORDER BY rating DESC;

SELECT * FROM FILM;
#2.1
SELECT rating, round(avg( length),2) AS avg_by_rating
FROM film
GROUP BY rating
ORDER BY avg_by_rating DESC;

#2.2
SELECT rating, round(avg( length),2) AS avg_by_rating
FROM film
GROUP BY rating
HAVING avg( length)>120
ORDER BY avg_by_rating DESC;

SELECT last_name FROM actor;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;


