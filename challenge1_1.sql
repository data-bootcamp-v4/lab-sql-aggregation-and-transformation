-- Challenge 1.1

-- Determinar cuestiones de duracion

SELECT
	MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;


-- 1.2

SELECT 
    ROUND(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;