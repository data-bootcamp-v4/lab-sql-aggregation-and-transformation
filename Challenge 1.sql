-- Challenge 1
	-- Challenge 1.1
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM 
    film;
    
    
	-- Challenge 1.2
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    MOD(ROUND(AVG(length)), 60) AS avg_minutes
FROM 
    film;
    
    -- Challenge 2
	-- Challenge 2.1
    
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM 
    rental;

	-- Challenge 2.2
SELECT 
    rental_id,
    customer_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;
    
    
	-- Challenge 2.3
    
SELECT 
    rental_id,
    customer_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM 
    rental
LIMIT 20;

-- Challenge 3
SELECT
    f.title AS film_title,
    IFNULL(f.rental_duration, 'Not Available') AS rental_duration
FROM
    film f
ORDER BY
    f.title ASC;



-- Bonus
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUBSTRING(c.email, 1, 3) AS email_prefix
FROM
    customer c
ORDER BY
    c.last_name ASC;


