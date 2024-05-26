-- 1. Rank films by length
SELECT title, length, RANK() OVER (ORDER BY length DESC) AS rank
FROM film
WHERE length > 0;

-- 2. Rank films by length within the `rating` category
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS rank
FROM film
WHERE length > 0;

-- 3. How many films are there for each of the categories in the category table?
SELECT c.name AS category_name, COUNT(fc.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- 4. Which actor has appeared in the most films?
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY film_count DESC
LIMIT 1;

-- 5. Which is the most active customer?
SELECT cu.first_name, cu.last_name, COUNT(r.rental_id) AS rental_count
FROM customer cu
JOIN rental r ON cu.customer_id = r.customer_id
GROUP BY cu.customer_id
ORDER BY rental_count DESC
LIMIT 1;

-- Bonus: Which is the most rented film?
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 1;