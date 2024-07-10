#JOINS
select city, country
FROM city
INNER JOIN country
using (country_id);


# showing all joins
select *
FROM city
INNER JOIN country
using (country_id);


SELECT Film_catagory, catogory
FROM Film_catagory, catogory
INNER JOIN catogory 
using (catogory_id);

#film_id and the name of th cat it belongs 

SELECT Film_id, name
FROM  category
INNER JOIN film_category 
using (category_id);

#retive no. of film per category in desc order

SELECT count(film_id),name
from category 
INNER JOIN film_category 
using (category_id)
Group by name
order by count(film_id) DESC;

##retive no. of address per city in our database
#sort in decs oreder
SELECT city,count(*)
from address
INNER JOIN city
using (city_id)
Group by city
order by count(*) DESC;

##retive no. of address per country in our database (need to add three table )
#sort in decs oreder

SELECT country,count(*)
from address
INNER JOIN city
using (city_id)
INNER JOIN country
using (country_id)
Group by country
order by count(*) DESC;

#subqury

SELECT First_name , last_name
FRom actor
inner join film_actor
using(actor_id)
WHERE film_id =1 ;

#retrive first and last name in actor id
SELECT First_name , last_name
FRom actor
inner join film_actor
using (actor_id)
WHERE film_id IN (1,2,3);

#actor id is 2
SELECT First_name , last_name
FRom actor
WHERE actor_id IN (1,2,3);

SELECT First_name , last_name
FRom actor
WHERE film_id =2;

combo

SELECT First_name , last_name
FRom actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id =2);
                    
SELECT film_id 
FROM film
WHERE title = "Academy Dinosaur")

SELECT First_name , last_name
FRom actor
WHERE actor_id IN (SELECT actor_id 
					FROM film_actor
					WHERE title = "Academy Dinosaur");
                    
#'                 
SELECT First_name , last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
					WHERE film_id IN (SELECT film_id
										FROM film_category
										WHERE catefory_id IN (SELECT category_id
										FROM catogory
										WHERE name =" sports")));


# retrive all the inventory ids of the movies in english (using subqueris)

SELECT inventory_id
FROM inventory
WHERE film_id IN (select film_id 
					FROM film 
                    WHERE language_id IN (SELECT language_id
											FROM language
                                            WHERE name = "English"));


# do the same with joins
SELECT inventory_id
from inventory
INNER JOIN film
using (film_id)
INNER JOIN language
using (language_id)
WHERE name = "English";

