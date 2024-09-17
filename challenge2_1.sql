-- Challenge 2

-- 2.1.1

SELECT COUNT(*) AS film_number FROM film; -- Nª de películas estrenadas

-- 2.1.2

SELECT COUNT(title) AS film_number, rating FROM film GROUP BY rating; -- Nº de películas por rating

-- 2.1.3

SELECT COUNT(title) AS film_numbers, rating FROM film GROUP BY rating ORDER BY COUNT(title) DESC;

