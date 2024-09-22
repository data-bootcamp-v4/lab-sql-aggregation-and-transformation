
-- Challenge 1: Movie Duration Insights

-- 1.1 Obtener la duración más corta y más larga de las películas (max_duration y min_duration)
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Contar cuántas películas tienen una duración mayor que 120 minutos
SELECT 
    COUNT(*) AS films_above_120_minutes
FROM film
WHERE length > 120;

-- 1.3 Obtener el promedio de duración de todas las películas, redondeado a 2 decimales
SELECT 
    ROUND(AVG(length), 2) AS avg_duration
FROM film;

-- Challenge 2: Category Insights

-- 2.1 Obtener la cantidad total de películas por categoría, ordenado de mayor a menor
SELECT 
    c.name AS category_name,
    COUNT(f.film_id) AS total_films
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_films DESC;

-- 2.2 Obtener el promedio de duración por categoría, redondeado a 2 decimales
SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;
