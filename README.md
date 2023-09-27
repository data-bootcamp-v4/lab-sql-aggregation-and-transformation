![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Lab | SQL Data Aggregation and Transformation

<details>
  <summary>
   <h2>Learning Goals</h2>
  </summary>

  This lab allows you to practice and apply the concepts and techniques taught in class. 

  Upon completion of this lab, you will be able to:
  
- Use SQL built-in functions such as COUNT, MAX, MIN, AVG to aggregate and summarize data, and use GROUP BY to group data by specific columns. Use the HAVING clause to filter data based on aggregate functions. 
- Use SQL to clean, transform, and prepare data for analysis by handling duplicates, null values, renaming columns, and converting data types. Use functions like ROUND, DATE_DIFF, CONCAT, and SUBSTRING to manipulate data and generate insights.
- Use conditional expressions for creating new columns. 


  <br>
  <hr> 

</details>

<details>
  <summary>
   <h2>Prerequisites</h2>
  </summary>

Before this starting this lab, you should have learnt about:

- SELECT, FROM, ORDER BY, LIMIT, WHERE, GROUP BY, and HAVING clauses.
- DISTINCT keyword to return only unique values, AS keyword for using aliases.
- Built-in SQL functions such as COUNT, MAX, MIN, AVG, ROUND, DATEDIFF, or DATE_FORMAT.
- CASE statement for conditional logic.
  <br>
  <hr> 

</details>


## Introduction

Welcome to the SQL Data Aggregation and Transformation lab!

In this lab, you will practice how to use SQL queries to extract insights from the  [Sakila](https://dev.mysql.com/doc/sakila/en/) database which contains information about movie rentals. 

In this lab, you'll build on your SQL skills by practicing how to use the GROUP BY and HAVING clauses to group data and filter results based on aggregate values. You will also practice how to handle null values, rename columns, and use built-in functions like MAX, MIN, ROUND DATE_DIFF, CONCAT, and SUBSTRING to manipulate and transform data for generating insights.

Throughout the lab, you will work with two SQL query files: `sakila-schema.sql`, which creates the database schema, and `sakila-data.sql`, which inserts the data into the database. You can download the necessary files locally by following the steps listed in [Sakila sample database - installation](https://dev.mysql.com/doc/sakila/en/sakila-installation.html). 

You can also use the Entity Relationship Diagram (ERD) of the database to guide your analysis:

<br>

![DB schema](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/database-sakila-schema.png)

<br><br>


## Challenge 1


1. As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
	- 1.1 Determine the **shortest and longest movie durations** and name the values as max_duration and min_duration.
	- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals. *Hint: look for floor and round functions.*
2. We need to use SQL to help us gain insights into our business operations related to rental dates:
	- 2.1 Calculate the **number of days that the company has been operating**. *Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.*
	- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
	- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values **'weekend' or 'workday'**, depending on the day of the week. *Hint: use a conditional expression.*
3. We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the **film titles and their rental duration**. If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results by the film title in ascending order. *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.* *Hint: look for the IFNULL() function.*

4. As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. To achieve this, we want to retrieve the **concatenated first and last names of our customers**, along with the **first 3 characters of their email** address, so that we can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier for us to use the data.

## Challenge 2

1. We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
	- 1.1 The **total number of films** that have been released.
	- 1.2 The **number of films for each rating**.
	- 1.3 The **number of films for each rating, and sort** the results in descending order of the number of films.
	This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.
2. We need to track the performance of our employees. Using the rental table, determine the **number of rentals processed by each employee**. This will help us identify our top-performing employees and areas where additional training may be necessary.
3. Using the film table, determine:
   - 3.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.
	- 3.2 Identify **which ratings have a mean duration of over two hours**, to help us select films for customers who prefer longer movies.
4. Determine which last names are not repeated in the table actor.

## Requirements

- Fork this repo
- Clone it to your machine


## Getting Started

Complete the challenges in this readme in a `.sql`file.

## Submission

- Upon completion, run the following commands:

```bash
git add .
git commit -m "Solved lab"
git push origin master
```

- Paste the link of your lab in Student Portal.
