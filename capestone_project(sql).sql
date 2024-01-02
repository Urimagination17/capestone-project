use sakila;
show tables;
select * from actor_info;
-- Display full name of actors 
select concat(first_name,' ', last_name) as full_name
from actor_info;

-- Display the no. of times first name appearing
select first_name, count(*) as name_count
from actor_info
group by first_name;

-- Count of actors who have unique first names
select first_name, count(*) as name_count
from actor_info
group by first_name
having count(*) = 1;

-- Display no. of times last name appears in the database
select last_name, count(*) as name_count
from actor_info
group by last_name;

-- Display all unique last names in database
select last_name, count(*) as name_count
from actor_info
group by last_name
having count(*) = 1;

show tables;
select * from film;

--  Movies with rating = R
select title from film
where rating = 'R';

-- Movies that are not R rated
select title from film
where rating != 'R';

-- Movies suitable for audience below 13 years old
select * from film
where rating = 'PG-13';

-- replacement cost is $11
select * from film
where replacement_cost <= 11.00;

-- replacement cost between $11 nad $12
select * from film
where replacement_cost >= 11.00 and replacement_cost <= 20.00;

-- list of recors in descending order of their cost
select * from film
order by replacement_cost desc;

show tables;
select * from film_list;
select * from actor;
select * from film_actor;

-- display name of top 3 movies with the greatest no. of actors
select f.film_id, f.title as movie_title, count(a.actor_id) as actor_count
from film f
join film_actor fa on fa.film_id = f.film_id
join actor a on a.actor_id = fa.actor_id
group by f.film_id, f.title
order by actor_count desc
limit 3;

-- Display film title starting with k and q 
SELECT  title
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%'
ORDER BY title;

-- Display all the actors who appeared in film Agent Truman
select concat(a.first_name, a.last_name) as full_name
from film f
join film_actor fa on fa.film_id = f.film_id
join actor a on a.actor_id = fa.actor_id
where f.title = 'Agent Truman';

show tables;
select * from rental;
select * from film;
select * from film_category;

-- Movies categorized as family films
select f.film_id, f.title as movie_name
from film f
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id
where c.name = 'Family';

-- Display max,min and average rental rate of movies based on rating
select rating,
max(rental_rate) as max_rental_rate,
min(rental_rate) as min_rental_rate,
avg(rental_rate) as avg_rental_rate
from film
group  by rating
order by avg_rental_rate;

-- Display movies in descending order of their rental frequecies so the managemnt can maintain copies of those movies
select f.film_id,f.title as movie_name, count(r.rental_id) as rental_frequency
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by f.film_id,f.title
order by rental_frequency desc;

-- Categories where the avg film replace cost and the average film rate is more than $15
select c.name as category_name, count(f.film_id) as film_count
from  category c
join film_category fc on fc.category_id = c.category_id
join film f on f.film_id = fc.film_id
group by c.category_id,c.name
having avg(f.replacement_cost) - avg(f.rental_rate) > 15.00;

select * from category;
select * from film;
select * from film_category;

-- display film categories in which no. of movies i greater than 70
select c.name as category_name, count(f.film_id) as film_count
from category c
join film_category fc on fc.category_id = c.category_id
join film f on f.film_id = fc.film_id
group by c.category_id, c.name
having film_count > 70

