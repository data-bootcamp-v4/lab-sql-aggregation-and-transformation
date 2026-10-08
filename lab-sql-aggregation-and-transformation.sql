-- You need to+ use SQL built-in functions to gain insights relating to the duration of movies:
-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select max(length) as max_duration , min(length) as min_duration from film;

-- Express the average movie duration in hours and minutes. Don't use decimals.

select floor(avg(length)/60) as hours , round(MOD(AVG(length), 60)) as minutest from film;


-- You need to gain insights related to rental dates:
-- Calculate the number of days that the company has been operating.

select DATEDIFF(max(rental_date),min(rental_date)) from rental ;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select *, month(rental_date) as month, weekday(rental_date) as weekday from rental limit 20;

-- Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

select *, if(weekday(rental_date) in (5,6),'weekend','workday')  as DAY_TYPE from rental;

-- You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

select title, IFNULL(rental_duration,'Not Available') from film order by title;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, 
-- along with the first 3 characters of their email address, so that you can address them by their first name and use their email address 
-- to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

select CONCAT(first_name,' ', last_name,' ', left(email, 3)) as personalized_email from customer order by last_name;


-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- The total number of films that have been released.

select count(film_id) from film;

-- The number of films for each rating.

select rating, count(film_id) from film group by rating;

-- The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

select rating, count(film_id) from film group by rating order by count(film_id) desc;


-- Using the film table, determine:
-- The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

select rating, round(avg(length),2) from film group by rating order by avg(length) desc;

-- Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

select rating from film group by rating having avg(length) > 120;

-- Bonus: determine which last names are not repeated in the table actor.

select last_name from actor group by last_name having count(*) = 1;