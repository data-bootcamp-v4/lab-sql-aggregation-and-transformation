use sakila;

##### 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:

    # 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
    select min(length) as min_duration, max(length) as max_duration
    from film;
    # min_duration = 46, max_duration = 185
    
    # 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions. 
	select round(avg(length)) as avg_movie_duration
    from film; # 115 mins
    
##### 2. You need to gain insights related to rental dates:

    # 2.1 Calculate the number of days that the company has been operating.
        # Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
	select datediff(max(rental_date), min(rental_date)) as operating_days
    from rental; # 266 days ago. 
	
    # 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
	select date_format(rental_date, "%W"), date_format(rental_date, "%m")
    from rental
    limit 20;
    
    # 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
        # Hint: use a conditional expression. 
	select *,
		case
			when dayofweek(rental_date) in (1,7) then "weekday" # cos week starts with sunday
            else "weekend"
         end as weekday_of_rental
	from rental;

### 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
### If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
# Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
# Hint: Look for the IFNULL() function.
select title,
	case 
		when isnull(rental_duration) then "not available"
        else rental_duration
        end as rental_duration
from film; 

### CHALLENGE 2 ###

    ##### 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
        # 1.1 The total number of films that have been released.
        select count(film_id)
        from film; # 1000 films 
        
        # 1.2 The number of films for each rating.
        select rating, count(*) as n_films
        from film
        group by rating; 
        
        # 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
        # This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
		select rating, count(*) as n_films
        from film
        group by rating 
        order by n_films; 
        
    ##### 2. Using the film table, determine:
        # 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
        # Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
        select round(avg(length)) as avg_duration
        from film
        group by rating
        order by avg_duration desc;
        
        # 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
        select rating, avg(length) as avg_duration
        from film
        # where length > 120 # wrong to filter with where!
        group by rating
        having avg_duration > 120; # what changes is that we are filtering already on the GROUP DATA with having instead of where 
        
		# Bonus: determine which last names are not repeated in the table actor.
        select distinct last_name
        from actor;
