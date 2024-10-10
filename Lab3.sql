USE sakila;
SHOW TABLES;

SELECT * FROM actor, film, customer; # Retrieve all the data from the tables actor, film and customer

SELECT title # Titles of all films from the film table
FROM film;

SELECT name	 # List of languages used in films, with the column aliased as language from the language table
FROM language;

SELECT first_name # List of first names of all employees from the staff table
FROM staff;

SELECT DISTINCT release_year # Retrieve unique release years
FROM film;

SELECT SUM(store_id) # Determine the number of stores that the company has
FROM store;

SELECT SUM(staff_id) # Determine the number of employees that the company has
FROM staff; 

SELECT COUNT(rental_id) # Determine how many films are available for rent and how many have been rented
FROM rental
ORDER BY return_date;

SELECT DISTINCT COUNT(last_name)  #D etermine the number of distinct last names of the actors in the database
FROM actor;

SELECT title,length # Retrieve the 10 longest films
FROM film
ORDER BY length DESC
LIMIT 10;

# Use filtering techniques in order to: Retrieve all actors with the first name "SCARLETT"
SELECT actor_id
FROM actor
WHERE first_name = "SCARLETT";

# Retrieve all movies that have ARMAGEDDON in their title and have a duration longer than 100 minutes
SELECT film_id, title
FROM film
WHERE title LIKE "ARMAGEDDON" AND length > 100;

# Retrieve the film titles and their rental duration
SELECT film_id, title, IFNULL(rental_duration, 'Not available') AS rental_duration
FROM film;

# Challenge 2. The total number of films that have been released
SELECT COUNT(film_id)
FROM film;

# The number of films for each rating
SELECT COUNT(film_id)
FROM film
GROUP BY rating;

# The number of films for each rating, sorting the results in descending order of the number of films
SELECT rating, COUNT(film_id) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

# The mean film duration for each rating, and sort the results in descending order of the mean duration
SELECT rating, ROUND(AVG(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
ORDER BY avg_film_duration DESC;

# Identify which ratings have a mean duration of over two hours 
SELECT rating, ROUND(AVG(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
HAVING avg_film_duration > 2;

# Determine which last names are not repeated in the table actor
SELECT  DISTINCT(last_name)
FROM actor;




