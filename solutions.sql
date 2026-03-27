-----------------
-- CHALLENGE 1 --
-----------------
-- 1.1
SELECT
    MAX(f.length) AS `max_duration`,
    MIN(f.length) AS min_duration
FROM film f;


-- 1.2
SELECT
    CONCAT(
        CAST(FLOOR(AVG(f.length) / 60) AS INT), "H ",
        CAST(AVG(f.length) % 60 AS INT), "M"
    ) AS avg_duration
FROM film f;

-- 2.1
SELECT
	CAST(
		JULIANDAY(MAX(r.rental_date)) - JULIANDAY(MIN(r.rental_date))
		AS INT
	) AS days_operating
FROM rental r;

-- 2.2
SELECT
    *, 
    strftime('%m', r.rental_date) AS rental_month, 
    strftime('%w', r.rental_date) AS rental_weekday
FROM rental r
LIMIT 20;

-- 2.3
SELECT
    *,
    CASE
		WHEN strftime('%w', r.rental_date) IN ('0', '6')
			THEN 'weekend'
            ELSE 'workday'
	END AS DAY_TYPE
FROM rental r;

-- 3
SELECT
	f.title,
	IFNULL(
		CAST(f.rental_duration AS TEXT),
		'Not Available'
	) AS rental_duration
FROM film f
ORDER BY f.title ASC;

-- BONUS 4
SELECT
	CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
	SUBSTR(c.email, 1, 3) AS email_prefix
FROM customer c
ORDER BY c.last_name ASC;


-----------------
-- CHALLENGE 2 --
-----------------
-- 1.1
SELECT COUNT(*) AS total_films FROM film;

-- 1.2
SELECT
    f.rating,
    COUNT(*) AS num_films
FROM film f
GROUP BY f.rating;

-- 1.3
SELECT
    f.rating,
    COUNT(*) AS num_films
FROM film f
GROUP BY f.rating
ORDER BY num_films DESC;

-- 2.1
SELECT
    f.rating,
    ROUND(AVG(f.length), 2) AS mean_duration
FROM film f
GROUP BY f.rating
ORDER BY mean_duration DESC;

-- 2.2
SELECT
    f.rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film f
GROUP BY f.rating
  HAVING mean_duration > 120;

-- 3
SELECT last_name
FROM actor
GROUP BY last_name
  HAVING COUNT(*) = 1;
