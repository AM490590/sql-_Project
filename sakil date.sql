
use sakila;

-- 1 Average Rental duration for Films
SELECT AVG(rental_duration) 
FROM film ;
-- 2 Distribution of Film Ratings
SELECT rating, COUNT(*) AS count
FROM film
GROUP BY rating;

-- 3 Number of Customers by Country
SELECT country.country, COUNT(customer.customer_id) AS customer_count
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY country.country;

-- 4- Rental Count by Day of the Week
SELECT DAYNAME(rental_date) AS day_of_week, COUNT(*) AS rental_count
FROM rental
GROUP BY DAYNAME(rental_date)
ORDER BY rental_count DESC;

-- 5 Retrieve Inventory Details with Film Titles

SELECT inventory.inventory_id, film.title
FROM inventory
JOIN film ON inventory.film_id = film.film_id;


-- 6- Most Common Film Categories
SELECT category.name, COUNT(*) AS count
FROM film_category
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY count DESC;


-- 7-Relationship Between Film Ratings and Monthly Rental Counts
SELECT film.rating, COUNT(rental.rental_id) AS rental_count
FROM film
LEFT JOIN rental ON film.film_id = rental.inventory_id
GROUP BY film.rating
ORDER BY rental_count DESC;



-- 8-Most Popular Films in Each Country
SELECT country.country, film.title, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN address ON rental.customer_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY country.country, film.title
ORDER BY rental_count DESC;



-- 9- Highest Revenue Generating Films
SELECT film.title, SUM(payment.amount) AS total_revenue
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.title
ORDER BY total_revenue DESC;





-- 10-Language Preferences by Country
SELECT co.country, f.language_id, COUNT(r.rental_id) 
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer cu ON r.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country, f.language_id;


-- 11 Average Payment Amount by Customer
SELECT customer.first_name, customer.last_name, AVG(payment.amount) AS avg_payment
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id
ORDER BY avg_payment DESC;


-- 0
SELECT actor.first_name, actor.last_name, film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id; 
SELECT film.title, store.store_id, COUNT(inventory.inventory_id) AS available_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
GROUP BY film.title, store.store_id
ORDER BY film.title, store.store_id;

-- 13 Customer Ranking by Rental 
SELECT 
    customer.first_name, 
    customer.last_name, 
    COUNT(rental.rental_id) AS rental_count,
    DENSE_RANK() OVER (ORDER BY COUNT(rental.rental_id) DESC) AS rental_rank
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY rental_count DESC;

-- 14 Total Revenue by Actor
SELECT actor.first_name, actor.last_name, SUM(payment.amount) AS total_revenue
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN inventory ON film_actor.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY actor.actor_id
ORDER BY total_revenue DESC;

-- 15  Top 10 Customers by Rental Count
SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS rental_count
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY rental_count DESC
LIMIT 10;

-- 16 - Film Availability by Store
SELECT film.title, store.store_id, COUNT(inventory.inventory_id) AS available_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
GROUP BY film.title, store.store_id
ORDER BY film.title, store.store_id;





use sakila;
SELECT category.name ,AVG(film.rental_rate)AS avg_rental_rate
FROM film

Join film.categroy on film.film_id = film_categroy.film_id
JOIN categroy ON film_categroy.categroy_id = categroy .categroy_id
GROUP BY category.name
HAVING AVG(film.rental_rate) > 3;


