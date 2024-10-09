# Challenge 1.1.1
SELECT min(length)  as "min_duration", max(length) as "max_duration" FROM film;

# Challenge 1.1.2
SELECT FLOOR(AVG(length)/60) AS "Hours", ROUND(AVG(length),0) % 60 AS "Minutes"
FROM film;

# Challenge 1.2.1
SELECT DATEDIFF(max(rental_date), min(rental_date)) AS DATEDIFF FROM rental;

# Challenge 1.2.2 
SELECT rental_date, 
	DATE_FORMAT(rental_date, "%M") AS "month",  
    DATE_FORMAT(rental_date, "%Y") AS "year" 
    FROM rental
LIMIT 20;

# Challenge 1.2.3
SELECT rental_date, 
	DATE_FORMAT(rental_date, "%M") AS "month",  
    DATE_FORMAT(rental_date, "%Y") AS "year",
    CASE
		WHEN WEEKDAY(rental_date) <= 5 THEN "Workday"
        ELSE "Weekend"
	END AS "DAY_TYPE"
    FROM rental
LIMIT 20;

# Challenge 1.3
SELECT title,
	CASE
		WHEN rental_duration IS NULL THEN "Not Available"
        ELSE rental_duration
        END AS rental_duration_updated
	FROM film;

# Challenge 2.1.1
SELECT COUNT(release_year) FROM film;

# Challenge 2.1.2
SELECT COUNT(title), rating 
FROM film
GROUP BY rating;

# Challenge 2.2.1
SELECT ROUND(AVG(length),2) AS "Avergage Length", rating 
FROM film
GROUP BY rating;

# Challenge 2.2.2
SELECT ROUND(AVG(length),2) AS "Avergage Length", rating,
	CASE
		WHEN AVG(length)/60 > 2 THEN "YES"
		ELSE "NO"
		END AS "Length over 2h"
FROM film
GROUP BY rating;
