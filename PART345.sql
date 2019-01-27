/* 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
4a. List the last names of actors, as well as how many actors have that last name.
4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
5a. You cannot locate the schema of the address table. Which query would you use to re-create it?*/

ALTER TABLE actor
ADD COLUMN description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, count(last_name) from actor
GROUP BY last_name; 

SELECT last_name, count(last_name) from actor
GROUP BY last_name
HAVING count(last_name) > 1;

UPDATE actor
set first_name = 'HARPO', last_name = 'WILLIAMS'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

UPDATE actor
set first_name = 'GROUCHO', last_name = 'WILLIAMS'
where first_name = 'HARPO' and last_name = 'WILLIAMS';

DESCRIBE address;