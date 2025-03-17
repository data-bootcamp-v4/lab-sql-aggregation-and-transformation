

-- Retp 1:
-- Ejercicio 1: Consigue y almacena los valores extremos.

SET @min_duracion = (SELECT MIN(length) FROM film);
SET @max_duracion = (SELECT MAX(length) FROM film);
SELECT @min_duracion, @max_duracion;

-- Expresa la duracion promedio de la peli en horas y minutos.

SELECT FLOOR(AVG(length)/60) AS hours, ROUND(AVG(length) % 60) 
AS minutos FROM film;

/* Ejercicio 2:
Numero de dias que la empresa estuvo en funcionamiento:
*/

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS active_days
FROM rental;

 
-- Usando la informacion del alquiler añade dos columnas para el mes y el dia de la semana. Saca los primeros 20 resultados.

SELECT rental_date,
	MONTH(rental_date) AS rental_month, 
	DAYNAME(rental_date) AS rental_day 
FROM rental LIMIT 20;
 
-- Bonus: usando la información de alquiler agrega una columna extra llamada DAY_TYPE con los valores 'weekend' o 'workday', según el día de la semana.


 
-- Reto 2: