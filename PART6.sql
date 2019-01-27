/* 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
6d. How many copies of the film Hunchback Impossible exist in the inventory system?
6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

*/

Use Sakila;

SELECT  first_name, last_name, address 
FROM staff s
INNER JOIN address a
ON (s.address_id = a.address_id);

SELECT first_name, last_name, SUM(p.amount) as TotalSales
FROM staff s
INNER JOIN payment p
ON (s.staff_id=p.staff_id)
WHERE payment_date BETWEEN '2005-08-01' AND '2015-08-31'
GROUP BY s.staff_id;


SELECT title, COUNT(actor_id) no_of_actors
FROM film f
INNER JOIN film_actor fa
ON (f.film_id = fa.film_id)
GROUP BY f.film_id;


SELECT title, count(inventory_id) as number_available
FROM film f
INNER JOIN inventory i
ON (f.film_id = i.film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY f.film_id;

SELECT c.first_name, c.last_name, SUM(p.amount) as TotalPaid 
FROM payment p
INNER JOIN customer c
ON (p.customer_id = c.customer_id)
GROUP BY c.customer_id
ORDER BY last_name Asc;