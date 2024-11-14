-- Challenge 1
	-- Challenge 1.1
    
SELECT 
    COUNT(*) AS total_films
FROM 
    film;


	-- Challenge 1.2

SELECT 
    rating,
    COUNT(*) AS num_films
FROM 
    film
GROUP BY 
    rating;

	-- Challenge 1.3
    
SELECT 
    rating,
    COUNT(*) AS num_films
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    num_films DESC;


-- Challenge 2
    -- Challenge 2.1

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    avg_duration DESC;

    -- Challenge 2.2
    
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    avg_duration > 120;
    

	-- Bonus

SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(last_name) = 1;

