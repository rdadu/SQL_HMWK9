/* 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q 
whose language is English.*/

Use Sakila;

SELECT title
FROM film f
WHERE f.title LIke 'K%' OR f.title like "Q%" 
AND  language_id in (
	SELECT language_id 
    FROM language
    WHERE name = 'English'
    );

/*7b. Use subqueries to display all actors who appear in the film Alone Trip.*/
	
SELECT first_name, last_name 
FROM actor
WHERE actor_id IN (
    SELECT actor_id 
	FROM film_actor
	WHERE film_id IN (
		SELECT film_id 
		FROM film f
		WHERE f.title = 'Alone Trip'
		)
    );
    
/* 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
*/
SELECT first_name, last_name, email
FROM customer
WHERE store_id IN 
	(SELECT store_id FROM store WHERE address_id in 
		(SELECT address_id FROM address WHERE city_id IN 
			(SELECT city_id FROM city WHERE country_id IN 
				(SELECT country_id FROM country WHERE country = 'Canada')
			)
		)
	)
ORDER BY last_name;    
    
/*Using joins - 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.*/
    
SELECT first_name,last_name, email
FROM customer cu
        JOIN store s ON cu.store_id = s.store_id
        JOIN address a ON s.address_id = a.address_id
        JOIN city c  ON a.city_id = c.city_Id
        JOIN country co ON c.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY last_name;
   
   
 /* 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as 
 family films.sales_by_film_category*/
 
 SELECT title, description, rental_rate, name category
 FROM category c
        JOIN film_category fc ON c.category_id = fc.category_id
        JOiN film f ON fc.film_id = f.film_id
 WHERE name = 'family';
 
/*7e. Display the most frequently rented movies in descending order.  */

SELECT f.title, description, count(r.rental_id) AS total_rentals
FROM payment p
        JOIN rental r ON p.rental_id = r.rental_id
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY total_rentals DESC;
    
/*7f. Write a query to display how much business, in dollars, each store brought in.*/

SELECT s.store_id, SUM(p.amount) AS total_sales
FROM payment p
        JOIN rental r ON p.rental_id = r.rental_id
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_sales ASC;


/* 7g. Write a query to display for each store its store ID, city, and country.*/

SELECT s.store_id, co.country, c.city
FROM  store s 
        JOIN address a ON s.address_id = a.address_id
        JOIN city c  ON a.city_id = c.city_Id
        JOIN country co ON c.country_id = co.country_id
ORDER BY store_id;
    
 /*7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)   */
 
SELECT c.name genres , SUM(p.amount) AS total_sales
FROM payment p
        JOIN rental r ON p.rental_id = r.rental_id
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film_category fc ON i.film_id = fc.film_id
        JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY total_sales DESC
LIMIT 5;
    