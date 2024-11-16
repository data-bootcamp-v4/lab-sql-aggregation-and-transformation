use sakila;

SELECT CONCAT(first_name, last_name, LEFT(email, 3)) AS head
FROM customer;
