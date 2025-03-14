# Challenge 2
# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:

SELECT * FROM film;

# 1.1 The total number of films that have been released.
SELECT COUNT(release_year)
FROM film;

-- no duplicates
SELECT 
	title,
    COUNT(*)
FROM film
GROUP BY title
HAVING COUNT(*) > 1;

# 1.2 The number of films for each rating.

-- I addedas UNION as a check if the ratings are equal to the number of films from task 1.1.

SELECT rating, COUNT(rating) as n_of_rating
FROM film
GROUP BY rating
UNION ALL 
SELECT 'sum of all ratings', COUNT(*)
FROM film;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
#This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
# Using the film table, determine:
SELECT rating, COUNT(rating) as n_of_rating
FROM film
GROUP BY rating
ORDER BY n_of_rating DESC;

# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT 
	rating, 
    COUNT(rating) as n_of_rating, 
    ROUND(AVG(length), 2) as avg_length_rating
FROM film
GROUP BY rating
ORDER BY avg_length_rating DESC;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
    rating, 
    COUNT(rating) as n_of_rating, 
    ROUND(AVG(length), 2) as avg_length_rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_length_rating DESC;

# Bonus: determine which last names are not repeated in the table actor.
SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) <= 1;


