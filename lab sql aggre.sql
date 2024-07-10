USE Sakila;
#1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

    # 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
    #Hint: Look for floor and round functions.*
    SELECT floor(round(Avg(length))/60)
    FROM Film;
    #Calculate the **number of days that the company has been operating**
    SELECT datediff(rental_date,current_date())
    FROM Rental;
    
SELECT datediff(current_date(),rental_date)
FROM Rental;
    
SELECT datediff(current_date(),MIN(rental_date))
FROM Rental;
    
#2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
SELECT MONTH(rental_date) AS "month"
FROM Rental;

SELECT DAYNAME(rental_date) AS Day
FROM Rental;
SELECT monthname(rental_date) AS Month
FROM Rental;
SELECT weekday(rental_date) AS weekday,DAYNAME(rental_date) AS Day
FROM Rental
WHERE weekday(rental_date) <= 5;

SELECT Rental_date,DAYNAME(rental_date) AS Day,monthname(rental_date) AS Month,
CASE
WHEN weekday(rental_date) >= 5
THEN "WEEKEND"
ELSE "WEEKDAY"
END AS WEEKNAME
FROM Rental LIMIT 20;

#You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the **film titles and their rental duration**. 
SELECT title,IFNULL(rental_duration,"Not Available") AS rental_duration 
FROM Film
ORDER BY title;
#concatenated first and last names of customers*
SELECT concat(first_name, " ",last_name)AS full_name, email,
substr(email,1,3)
FROM customer
ORDER BY last_name ASC;

## Challenge 2
SELECT COUNT(*) AS total_number_of_films
FROM film;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

```bash
git add .
git commit -m "Solved lab"
git push origin master
