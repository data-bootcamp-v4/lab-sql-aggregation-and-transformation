use sakila; 

/*  You need to use SQL built-in functions to gain insights relating to the duration of movies:
1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions.*/
 SELECT max(length) as max_duration from sakila.film; 
 SELECT min(length) as min_duration from sakila.film; 
SELECT floor (avg(length)/60) as HOURS , round(avg(length))-(floor(avg(length)/60))*60 as MINUTES from sakila.film; 

/* 2.You need to gain insights related to rental dates:
2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
Hint: use a conditional expression.*/

SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) as Days_Operating from sakila.rental; 
SELECT rental_id,rental_date,inventory_id,customer_id,return_date,staff_id,last_update, DATE_FORMAT(rental_date,'%M') as Month, Dayname(rental_date) as Weekday_Of_Rental from sakila.rental LIMIT 20; 
SELECT rental_id,rental_date,inventory_id,customer_id,return_date,staff_id,last_update, DATE_FORMAT(rental_date,'%M') as Month, Dayname(rental_date) as Weekday_Of_Rental ,
case
WHEN dayofweek(rental_date) IN(1,7) THEN 'Weekend' 
else 'Workday' end as Day_Type from sakila.rental limit 20;  

/*You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
Hint: Look for the IFNULL() function.*/
SELECT title as Film_Name , IFNULL(RENTAL_DURATION,'Not Available') as Rental_Duration from sakila.film ORDER by title asc; 
SELECT concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME, LEFT(EMAIL,3) as Email_Address from sakila.customer ORDER BY LAST_NAME asc;

/*1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
1.1 The total number of films that have been released.
1.2 The number of films for each rating.
1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly. */

SELECT count(film_id)  from sakila.film where RELEASE_YEAR IS NOT NULL AND RELEASE_YEAR  NOT IN ('', ' ');
SELECT count(Film_id) as Number_Of_Films, rating  from sakila.film group by rating ;
SELECT count(Film_id) as Number_Of_Films, rating  from sakila.film group by rating order by count(film_id) DESC;   

/* Using the film table, determine:
2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
Bonus: determine which last names are not repeated in the table actor.*/

SELECT rating, Round(avg(rental_duration),2) as Mean_Film_Duration from Sakila.film group by rating order by Mean_Film_Duration DESC; 
SELECT rating, Round(avg(rental_duration),2) as Mean_Film_Duration from Sakila.film group by rating  having avg(rental_duration)>120 order by Mean_Film_Duration DESC; 
SELECT last_name from sakila.actor group by last_name having count(last_name)=1;





 