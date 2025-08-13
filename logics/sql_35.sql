--https://www.linkedin.com/posts/saikishoregudiboina_sql29-activity-7130426695689355264-ocgO/?utm_source=share&utm_medium=member_desktop

CREATE TABLE pizza_toppings
(
 ingredient_cost DECIMAL(5, 2),
 topping_name VARCHAR(50)
);

INSERT INTO pizza_toppings (ingredient_cost, topping_name) VALUES
(0.50, 'Pepperoni'),
(0.70, 'Sausage'),
(0.55, 'Chicken'),
(0.40, 'Extra Cheese'),
(0.25, 'Mushrooms'),
(0.20, 'Green Peppers'),
(0.15, 'Onions'),
(0.25, 'Pineapple'),
(0.30, 'Spinach'),
(0.20, 'Jalapenos')

Question:
Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. 
Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.
Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.
Notes:
1)Do not display pizzas where a topping is repeated. For example, ‘Pepperoni,Pepperoni,Onion Pizza’.
2)Ingredients must be listed in alphabetical order. For example, 'Chicken,Onions,Sausage'. 'Onion,Sausage,Chicken' is not acceptable.

solution:

select 
CONCAT(p1.topping_name, ',', p2.topping_name, ',', p3.topping_name) AS pizza,
p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost AS total_cost
FROM pizza_toppings AS p1
join pizza_toppings AS p2
on p1.topping_name < p2.topping_name 
join pizza_toppings AS p3
on p2.topping_name < p3.topping_name
order by total_cost desc, pizza
