-- =====================================================================
-- Lab | SQL Data Aggregation and Transformation (base de datos sakila)
-- =====================================================================
USE sakila;


-- =====================================================================
-- CHALLENGE 1
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1.1 Duración más corta y más larga
-- ---------------------------------------------------------------------
-- MAX() y MIN() son funciones de agregación: resumen toda la columna en un único valor.
-- Resultado: 185 y 46 minutos.
SELECT MAX(length) AS max_duration,
       MIN(length) AS min_duration
FROM film;

-- ---------------------------------------------------------------------
-- 1.2 Duración media en horas y minutos, sin decimales
-- ---------------------------------------------------------------------
-- La media es 115.27 minutos.
-- - Horas: FLOOR(media / 60). FLOOR redondea siempre hacia abajo: 1.92 horas -> 1.
--   Por qué no ROUND: ROUND(1.92) daría 2 horas, que es falso.
-- - Minutos: el resto de dividir entre 60 (operador %), redondeado: 55.27 -> 55.
-- Resultado: 1 hora y 55 minutos.
SELECT FLOOR(AVG(length) / 60)  AS avg_hours,
       ROUND(AVG(length) % 60)  AS avg_minutes
FROM film;

-- Misma idea presentada como texto con CONCAT, que une valores en una sola cadena.
SELECT CONCAT(FLOOR(AVG(length) / 60), 'h ', ROUND(AVG(length) % 60), 'min') AS avg_duration
FROM film;

-- ---------------------------------------------------------------------
-- 2.1 Número de días que la empresa lleva operando
-- ---------------------------------------------------------------------
-- DATEDIFF(fecha_final, fecha_inicial) devuelve los días entre dos fechas.
-- Uso la fecha del último y del primer alquiler. Resultado: 266 días.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- ---------------------------------------------------------------------
-- 2.2 Información de alquileres con el mes y el día de la semana (20 filas)
-- ---------------------------------------------------------------------
-- MONTHNAME() y DAYNAME() devuelven el nombre del mes y del día (en inglés).
-- Alternativa: MONTH() y DAYOFWEEK() devuelven números; los nombres se leen mejor en un informe.
SELECT *,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date)   AS rental_weekday
FROM rental
LIMIT 20;

-- ---------------------------------------------------------------------
-- 2.3 BONUS: columna DAY_TYPE con 'weekend' o 'workday'
-- ---------------------------------------------------------------------
-- CASE es el "if" de SQL. DAYOFWEEK() devuelve 1 para domingo y 7 para sábado,
-- así que el fin de semana es IN (1, 7).
-- Por qué DAYOFWEEK y no DAYNAME: comparar números no depende del idioma del servidor.
SELECT *,
       CASE
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental;

-- ---------------------------------------------------------------------
-- 3. Títulos y duración del alquiler; los NULL como 'Not Available'
-- ---------------------------------------------------------------------
-- IFNULL(valor, alternativa) devuelve la alternativa cuando el valor es NULL.
-- Ahora mismo no hay NULL en rental_duration, pero la consulta queda preparada
-- por si aparecen en el futuro, como pide el enunciado.
-- Alternativa estándar (funciona en otros motores): COALESCE(rental_duration, 'Not Available').
SELECT title,
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- ---------------------------------------------------------------------
-- 4. BONUS: nombre completo y primeras 3 letras del email, ordenado por apellido
-- ---------------------------------------------------------------------
-- CONCAT une nombre, espacio y apellido. SUBSTRING(texto, inicio, longitud) corta
-- el texto: desde la posición 1, 3 caracteres. En SQL las posiciones empiezan en 1, no en 0.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       SUBSTRING(email, 1, 3)             AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- =====================================================================
-- CHALLENGE 2
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1.1 Número total de películas estrenadas
-- ---------------------------------------------------------------------
-- Todas tienen release_year (2006), así que cuento las filas. Resultado: 1000.
SELECT COUNT(*) AS total_films
FROM film;

-- ---------------------------------------------------------------------
-- 1.2 Número de películas por clasificación (rating)
-- ---------------------------------------------------------------------
-- GROUP BY rating crea un grupo por cada clasificación y COUNT(*) cuenta las filas de cada grupo.
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- ---------------------------------------------------------------------
-- 1.3 Lo mismo, ordenado de más a menos películas
-- ---------------------------------------------------------------------
-- Puedo ordenar por el alias number_of_films porque ORDER BY se evalúa después del SELECT.
-- Resultado: PG-13 (223), NC-17 (210), R (195), PG (194), G (178).
-- Conclusión: el catálogo está bastante repartido; PG-13 es la clasificación con más títulos.
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- ---------------------------------------------------------------------
-- 2.1 Duración media por clasificación, con 2 decimales, de mayor a menor
-- ---------------------------------------------------------------------
-- Resultado: PG-13 120.44, R 118.66, NC-17 113.23, PG 112.01, G 111.05.
SELECT rating,
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- ---------------------------------------------------------------------
-- 2.2 Clasificaciones con duración media de más de dos horas
-- ---------------------------------------------------------------------
-- HAVING filtra grupos después de agregar. Por qué no WHERE: WHERE filtra filas
-- antes de agrupar y no puede usar AVG(). Dos horas = 120 minutos.
-- Resultado: solo PG-13 (120.44).
SELECT rating,
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- ---------------------------------------------------------------------
-- 3. BONUS: apellidos que no se repiten en la tabla actor
-- ---------------------------------------------------------------------
-- Agrupo por apellido y me quedo con los grupos de una sola fila. Resultado: 66 apellidos.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;
