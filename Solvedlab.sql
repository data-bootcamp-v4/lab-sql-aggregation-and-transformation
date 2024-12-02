USE sakila;

WITH min_max AS (
SELECT
MIN(length) AS min_length,
MAX(length) AS max_length
FROM
film)

SELECT 
    title,
    length
FROM
    film
WHERE
    length = (SELECT min_length FROM min_max)
    OR
    length = (SELECT max_length FROM min_max);


SELECT 
title,
ROUND(length/60) AS "hour",
ROUND(length % 60) AS "minutes"
FROM
film;




SELECT 
MIN(rental_date),
MAX(rental_date),
DATEDIFF(MAX(rental_date),MIN(rental_date))
FROM 
rental;

ALTER TABLE rental
    ADD COLUMN `month` INT,
    ADD COLUMN `weekday` INT;
    
UPDATE rental
SET 
    `month` = MONTH(rental_date),
    `weekday` = DAYOFWEEK(rental_date) - 1;
    
    
-- You need to ensure that customers can easily access information about the movie collection.
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'.
-- Sort the results of the film title in ascending order.


DELIMITER $$
CREATE PROCEDURE search_film(film_name VARCHAR(255))
	BEGIN
		DECLARE film_count INT;
        SELECT COUNT(*) INTO film_count
        FROM film
        WHERE title = film_name;
        
        IF film_count>0 THEN
			SELECT 'Film is available' AS result;
		ELSE
			SELECT 'Film is not available' AS result;
		END IF;
    END $$
DELIMITER ;
    
CALL search_film('WYOMING STORM');


SELECT COUNT(title) FROM film;
SELECT rating,COUNT(title) AS total_film FROM film GROUP BY rating;
SELECT rating,COUNT(title) AS total_film FROM film GROUP BY rating ORDER BY rating DESC;


 customers who prefer longer movies.

SELECT rating, AVG(length) as length_avg FROM film GROUP BY rating;

SELECT rating, AVG(length) as length_avg  FROM film GROUP BY rating HAVING AVG(length)>2;

WITH actors_surname AS(
SELECT 
last_name,
ROW_NUMBER() OVER(PARTITION BY last_name ORDER BY last_name) AS counts
FROM actor)
SELECT * 
FROM actors_surname
WHERE counts>1;






