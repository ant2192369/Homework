use sakila;
select * from actor
# display last and first name 
select first_name, last_name from actor 
# Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
# apprend strings to one another
select concat(first_name, ' ', last_name) as 'Actor Name'
from actor;

select actor_id, last_name, first_name 
from actor
# to filter records 
where first_name = "JOE";

select last_name from actor
# because it contains letters gen use percent symbol 
where last_name like "%GEN%"


select last_name from actor 
where last_name like "%LI%"
group by last_name,first_name;

select country_id, country  from country
where country in ("Afghanistan","Bangladesh","China");

# we are creating a new column http://www.mysqltutorial.org/mysql-add-column/( great source)

alter table actor 
add column actor_age varchar(77) null after last_name

alter table actor 
change column actor_age actor_age blob;
select * from actor;

alter table actor 
drop column description;

# find all actors whose last names start with li 

select last_name, count(*) as count_of_actors
from actor
group by last_name;

# find the number of actors who share the same last name so its a similar code as above 
select last_name, count(*) as count_of_actors
from actor
group by last_name
# the having clause is better utilized here as opposed to the where clause due to the aggregate function of count
having count_of_actors >=3;

update actor
# instead of selecting we update due to the existing records in the table
set first_name= "HARPO"
# use the where because it determines how many records are updated.  also AND clause the AND clause is preffered on the condition of the true statement of the same last name. 
where first_name = "GROUCHO" AND last_name = "WILLIAMS";
update actor 
set  first_name = "GROUCHO"
where actor_id = 172;

# You cannot locate the schema of the `address` table. Which query would you use to re-create it?

select * from information_schema.columns 
where table_name = "address";

# Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
select last_name, first_name , payment
from staff s
join address a
on s.address_id=a.address_id;
select * from payment;

select  payment.staff_id, staff.first_name, staff.last_name, payment.amount, payment.payment_date
from staff s 
inner join payment p
on s.staff_id= p.staff_id AND payment_date like "2008-08%";

select title, count(*) as num_actor
from film 
join film_actor fa using(film_id)
group by film_id;

select title, count(*) from inventory
join film using (film_id)
where title = "HUNCHBACK IMPOSSIBLE"; "according to the count is 6"


select last_name, first_name, sum(amount)
from customer 
right join payment using (customer_id)
group by customer_id 
order by last_name, first_name;

select * from language;
#titles of movies starting with the letters `K` and `Q` whose language is English. multiple conditions use or. dont forget the percent sign when using like clause 
select title from film 
join language using(language_id)
where name = "ENGLISH" and (title like "Q%" or title like  "K%");
# subqueries time  Use subqueries to display all actors who appear in the film `Alone Trip`.

select last_name, first_name from film_actor
join film using (film_id)
  (select last_name, first_name from actor 
     join actor using(actor_id)
     where title = "ALONE TRIP"
     );
     
     #You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

     
select last_name, first_name, email 
from customer c
       join address  using(address_id)
        join city using(city_id)
           join country using(country_id)
           
           where country = "canada";
           

           
   # Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
   select * from film;    
   
    select title, description rating
    from film
    join film_category using(film_id)
    join category using(category_id)
    
    where name = "FAMILY";
    
   # Display the most frequently rented movies in descending order.
   
   select f.title,count(*) as rental_count
   from rental r 
   join inventory i
    
    on (r.inventory_id=i.inventory_id)
	join film f 
       on( i.film_id=f.film_id)
       group by f.title
       order by rental_count desc;
       
# Write a query to display how much business, in dollars, each store brought in.
store

select * from store;
select * from sales_by_store; # in your schemas click on views and you can see sales_by_stores. 

 # Write a query to display for each store its store ID, city, and country.
 select store_id, city, country
 from store 
 # use multiple joins 
 join address using(address_id)
 join city using(city_id)
 join country using(country_id)
 
 
#List the top five genres in gross revenue in descending order.
select * from sales_by_film_category 
order by total_sales desc; # use the views info under your sakilla 

# since we used a view to solve the problem above we must now create one of the top 5 genres
# create a view of top 5 genres by highest gross revenue to lowest gross revenue 

create view of top_five_genres ( category, total_sales)
as
 select * from sales_by_film_category
 order by total_sales desc 
 limit 5 ; 
 
 
# how to view top five genres

select * from top_five_genres;
drop top_five_genres; 









   
	
	





























