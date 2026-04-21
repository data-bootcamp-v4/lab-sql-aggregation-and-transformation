USE sakila;
SELECT
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;
SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;
