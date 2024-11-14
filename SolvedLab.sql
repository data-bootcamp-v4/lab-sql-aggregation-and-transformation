-- CHALLENGE 1

-- 1.1 Determinar la duración más corta y más larga de las películas
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;

-- 1.2 Expresar la duración promedio de las películas en horas y minutos
-- Hint: Look for floor and round functions.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    FLOOR(AVG(length) % 60) AS avg_minutes 
FROM film;

-- 2.1 Calcular el número de días que la empresa ha estado operando
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating 
FROM rental;

-- 2.2 Recuperar información de alquiler y agregar columnas para el mes y el día de la semana
SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%M') AS rental_month, 
    DATE_FORMAT(rental_date, '%W') AS rental_weekday 
FROM rental 
LIMIT 20;

-- 2.3 Bonus: Agregar una columna llamada DAY_TYPE con valores 'weekend' o 'workday'
-- Hint: use a conditional expression.
SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%M') AS rental_month, 
    DATE_FORMAT(rental_date, '%W') AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' 
        ELSE 'workday' 
    END AS DAY_TYPE 
FROM rental 
LIMIT 20;

-- Recuperar títulos de películas y su duración de alquiler, reemplazando valores NULL
-- Hint: Look for the IFNULL() function.
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM film 
ORDER BY title ASC;

-- Bonus: Recuperar nombres concatenados de los clientes y los primeros 3 caracteres de su correo electrónico
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    SUBSTRING(email, 1, 3) AS email_prefix 
FROM customer 
ORDER BY last_name ASC;

-- CHALLENGE 2

-- 1.1 Determine the total number of films that have been released
SELECT 
    COUNT(*) AS total_films 
FROM film;

-- 1.2 Determine the number of films for each rating
SELECT 
    rating, 
    COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating;

-- 1.3 Determine the number of films for each rating, sorting the results in descending order of the number of films
SELECT 
    rating, 
    COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating 
ORDER BY number_of_films DESC;

-- 2.1 Determine the mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
HAVING mean_duration > 120;

-- Bonus: Determine which last names are not repeated in the table actor
SELECT 
    last_name 
FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;