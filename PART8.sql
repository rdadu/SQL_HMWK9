/*8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
8b. How would you display the view that you created in 8a?
8c. You find that you no longer need the view top_five_genres. Write a query to delete it.

*/

Use Sakila;

CREATE VIEW Top_Five_Genres AS
	SELECT c.name genres , SUM(p.amount) AS total_sales
	FROM payment p
			JOIN rental r ON p.rental_id = r.rental_id
			JOIN inventory i ON r.inventory_id = i.inventory_id
			JOIN film_category fc ON i.film_id = fc.film_id
			JOIN category c ON fc.category_id = c.category_id
	GROUP BY c.category_id
	ORDER BY total_sales DESC
	LIMIT 5;
    
SELECT * 
FROM Top_Five_Genres;

DROP VIEW Top_Five_Genres;