--  Challenge 1.2

-- 2.1

SELECT
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS company_lifetime
FROM rental;

-- 2.2

SELECT * FROM rental;

SELECT
	MONTH(rental_date) AS month,
	DAY(rental_date) AS day
FROM rental
LIMIT 20;
