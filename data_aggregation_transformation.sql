-- Preparar o banco de dados
USE sakila;

--  == Desafio 1 == --

-- 1. Funções internas do SQL para obter insights:
-- 1.1 Determine as durações de filme mais curtas e mais longas
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Expresse o duração média do filme em horas e minutos.
SELECT
    CONCAT(
        FLOOR(ROUND(AVG(length)) / 60),
        ' hours and ',
        MOD(ROUND(AVG(length)), 60),
        ' minutes'
    ) AS average_film_duration
FROM film;

-- 2. Obter insights relacionados às datas de aluguel:
-- 2.1 Calcule o número de dias que a empresa tem operado.
SELECT
    DATEDIFF(
        MAX(rental_date),
        MIN(rental_date)
    ) AS operating_days
FROM rental;

-- 2.2 Recupere informações de aluguel e adicione duas colunas adicionais para mostrar o mês e o dia da semana do aluguel.
SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bônus: Recuperar informações de aluguel e adicionar uma coluna adicional chamada DAY_TYPEcom valores 'fim de semana' ou 'dia de trabalho', dependendo do dia da semana.
SELECT
    *,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7)
            THEN 'fim de semana'
        ELSE 'dia de trabalho'
    END AS DAY_TYPE
FROM rental;

-- 3. Rrecupere os títulos do filme e sua duração de aluguel. 
SELECT
    title,
    IFNULL(rental_duration, 'Não disponível') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bônus: Recuperar os primeiros e últimos nomes concatenados dos clientes, juntamente com os primeiros 3 caracteres de seu endereço de e-mail.
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- == Desafio 2 == --

-- Analisar os filmes da coleção para obter mais alguns insights. Usando o film tabela, determinar:
-- 1.1 Total de filmes que foram lançados.
SELECT
    COUNT(*) AS total_films
FROM film;

-- 1.2 O número de filmes para cada classificação.
SELECT
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3 O número de filmes para cada classificação, classificando os resultados em ordem decrescente do número de filmes. 
SELECT
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- 2 Usando o film tabela, determinar: 
-- 2.1 A duração média do filme para cada classificação, e classificar os resultados em ordem decrescente da duração média. 
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2 Identificar quais classificações têm uma duração média de mais de duas horas para ajudar a selecionar filmes para clientes que preferem filmes mais longos.
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;

-- 3 Bônus: determine quais sobrenomes não são repetidos na tabela actor.
SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
