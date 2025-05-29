USE sakila;

## CHALLENGE 1
#1
	#1.1
		SELECT MAX(DISTINCT length) as max_duration, MIN(DISTINCT length) as min_duration FROM film;
    #1.2
		SELECT ROUND(AVG(length)) as average_film_length FROM film;
        
#2
	#2.1
		SELECT DATEDIFF(CURDATE(), MIN(first_date)) AS "Company's operation dates"
		FROM (
			SELECT rental_date AS first_date FROM rental
			UNION ALL
			SELECT payment_date AS first_date FROM payment
		) AS combined;
	#2.2
		SELECT *, MONTHNAME(rental_date) as 'Month', DAYNAME(rental_date) as 'Weekday'  FROM rental;
    #2.3
		SELECT *, 
        CASE 
			WHEN DAYOFWEEK(rental_date) IN (1, 7) 
			THEN 'Weekend' 
			ELSE 'Workday'
        END AS DAY_TYPE
        FROM rental;
#3
	SELECT *, IFNULL(rental_duration, 'Not Available') FROM film ORDER BY title;

#4
	SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
    FROM customer
    ORDER BY last_name;

## CHALLENGE 2
#1
	#1.1
		SELECT COUNT(film_id) FROM film;
    #1.2
		SELECT rating, COUNT(*) as film_count
        FROM film
        GROUP BY rating;
    #1.3
		SELECT rating, COUNT(*) as film_count
        FROM film
        GROUP BY rating
        ORDER BY film_count DESC;

#2
	#2.1
		SELECT rating, ROUND(AVG(length), 2) as mean_duration
        FROM film
        GROUP BY rating
        ORDER BY mean_duration DESC;
   #2.2
		SELECT rating as long_length_ratings 
        FROM film
        GROUP BY rating
        HAVING AVG(length) > 120;
#3
	SELECT last_name 
    FROM actor
    GROUP BY last_name
    HAVING COUNT(last_name) = 1;