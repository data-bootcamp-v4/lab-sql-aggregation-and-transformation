-- Challenge 1.3

SELECT * FROM film;

SELECT 
	title,
    IFNULL(rental_duration, "Not available") AS rental_duration
FROM film;