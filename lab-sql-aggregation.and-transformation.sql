USE sakila;

-- 1
SELECT c.name AS category, COUNT(fc.film_id) AS num_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- 2
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 3
SELECT i.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;

-- 4
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- 5
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- 6
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;

-- 7
SELECT f.title, COUNT(i.inventory_id) AS copies_in_store_1
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY f.title;

-- 8
SELECT f.title,
  CASE WHEN IFNULL(COUNT(i.inventory_id), 0) > 0
       THEN 'Available' ELSE 'NOT available' END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;