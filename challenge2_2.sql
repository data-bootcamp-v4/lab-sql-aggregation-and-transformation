-- Challenge 2.2

SELECT * FROM film;

-- 2.2.1

SELECT 
	ROUND(AVG(length), 2) AS avg_duration_minutes, 
    rating 
FROM film 
GROUP BY rating 
ORDER BY ROUND(AVG(length)) DESC;

-- 2.2.2

SELECT 
	ROUND(AVG(length), 2) AS avg_duration_minutes, 
    rating 
FROM film 
GROUP BY rating 
HAVING ROUND(AVG(length), 2) > 120;
