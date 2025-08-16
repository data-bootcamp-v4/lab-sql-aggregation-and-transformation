# Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
select max(length) as max_duration,
	   min(length) as min_duration
from sakila.film;

# Express the **average movie duration in hours and minutes**. Don't use decimals.
select floor(avg(length)) as avg_length,
       floor(avg(length)/60) as avg_lengh_hour,
       floor(mod(avg(length),60)) as avg_lengh_minute
from sakila.film;

# Calculate the **number of days that the company has been operating**.
select max(rental_date),
       min(rental_date),
       DATEDIFF(max(rental_date),min(rental_date)) as total_operation_days
from sakila.rental;

# retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
create table rental_month_weekday
select *,
       date_format(rental_date,'%M') as rental_month,
       date_format(rental_date,'%W') as rental_weekday
from sakila.rental
limit 20;

# Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week
select *, 
       case when rental_weekday in ('SATURDAY','SUNDAY') THEN 'weekend'
       else 'workday'
       end as DAY_TYPE
from rental_month_weekday;


# retrieve the **film titles and their rental duration**as
select title,
	   coalesce(rental_duration,'Not Available') as film_rental_duration
from sakila.film
order by title asc;

# retrieve the **concatenated first and last names of customers**, along with the **first 3 characters of their email** address
# The results should be ordered by last name in ascending order to make it easier to use the data.*
select concat(first_name,' ',last_name) as Customer_Name,
	   left(email,3) as email_first3_char
from sakila.customer
order by last_name asc;

# The **total number of films** that have been released.
select count(*) as total_num_films
from sakila.film;

# The **number of films for each rating**.
# sorting** the results in descending order of the number of films.
select rating, count(*) as total_num_films_byRating
from sakila.film
group by rating
order by total_num_films_byRating desc;

# The **mean film duration for each rating**, and sort the results in descending order of the mean duration. 
create table avg_film_duration_rating as
select rating,round(avg(length),2) as avg_film_duration
from sakila.film
group by rating
order by avg_film_duration desc;

# Identify **which ratings have a mean duration of over two hours** 
select rating,round(avg(length),2) as avg_film_duration
from sakila.film
group by rating
having round(avg(length),2) > 120;


# determine which last names are not repeated in the table `actor`.
select last_name
from actor
group by last_name
having count(*) = 1
