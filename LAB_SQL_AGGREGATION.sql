#CHALLENGE 1

#QUESTION 1
SELECT MAX(length) FROM sakila.film AS max_duration;

SELECT MIN(length) FROM sakila.film AS min_duration;

SELECT ROUND(AVG(length)) FROM sakila.film; 



#QUESTION 2
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS DateDiff
FROM sakila.rental;


SELECT  
		*, 
        DATE_FORMAT(CONVERT(rental_date, DATE), '%M') AS month_of_rental, 
        DAYNAME(rental_date) AS day_of_rental
FROM sakila.rental
LIMIT 20;

SELECT  
		*, 
        DATE_FORMAT(CONVERT(rental_date, DATE), '%M') AS month_of_rental, 
        DAYNAME(rental_date) AS day_of_rental,
CASE
	WHEN DAYNAME(rental_date) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'WORKDAY'
    ELSE 'weekend'
END AS 'Day_type'
FROM sakila.rental;

#QUESTION 3
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM sakila.film;

#QUESTION 4: BONUS
SELECT *, CONCAT(first_name,' ', last_name,' ', LEFT(email,3)) AS 'customer_name' FROM sakila.customer
ORDER BY last_name ASC;


#CHALLENGE 2 

#QUESTION 1
SELECT COUNT(film_id) FROM sakila.film;

SELECT rating, COUNT(film_id) AS 'number_films'
FROM sakila.film
GROUP BY rating;

SELECT rating, COUNT(film_id) AS 'number_films'
FROM sakila.film
GROUP BY rating
ORDER BY number_films DESC;

#QUESTION 2

SELECT rating, ROUND(AVG(length),2) AS 'avg_duration'
FROM sakila.film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT rating, AVG(length) AS 'avg_duration'
FROM sakila.film
GROUP BY rating   
HAVING AVG(length) > 120
ORDER BY avg_duration DESC;


SELECT last_name, COUNT(*)
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) > 1;