--https://www.linkedin.com/feed/update/urn:li:activity:7129406579057033218/

CREATE TABLE items (
 item_id INT,
 item_type VARCHAR(50),
 item_category VARCHAR(50),
 square_footage DECIMAL(10, 2)
);

INSERT INTO items (item_id, item_type, item_category, square_footage)
VALUES 
 (1374, 'prime_eligible', 'mini refrigerator', 68.00),
 (4245, 'not_prime', 'standing lamp', 26.40),
 (5743, 'prime_eligible', 'washing machine', 325.00),
 (8543, 'not_prime', 'dining chair', 64.50),
 (2556, 'not_prime', 'vase', 15.00),
 (2452, 'prime_eligible', 'television', 85.00),
 (3255, 'not_prime', 'side table', 22.60),
 (1672, 'prime_eligible', 'laptop', 8.50),
 (4256, 'prime_eligible', 'wall rack', 55.50),
 (6325, 'prime_eligible', 'desktop computer', 13.20);

Question:
Amazon wants to maximize the number of items it can stock in a 500,000 square feet warehouse. 
It wants to stock as many prime items as possible, and afterwards use the remaining square footage to stock the most number 
of non-prime items.
Write a query to find the number of prime and non-prime items that can be stored in the 500,000 square feet warehouse. 
Output the item type with prime_eligible followed by not_prime and the maximum number of items that can be stocked.
Assumptions:
1)Prime and non-prime items have to be stored in equal amounts, regardless of their size or square footage. 
  This implies that prime items will be stored separately from non-prime items in their respective containers, but within each container, 
  all items must be in the same amount.
2)Non-prime items must always be available in stock to meet customer demand, so the non-prime item count should never be zero.
3)Item count should be whole numbers (integers).

sol:
with prime as
 (
select item_type,sum(square_footage) as square_footage_per_container
,count(item_id) as items_per_container
,floor(500000/sum(square_footage)) * count(item_id) as total_count_of_items
from items
where item_type='prime_eligible' 
group by item_type
)
select item_type,total_count_of_items from prime
union
select item_type,
floor(floor(500000-(select floor(500000/square_footage_per_container)*square_footage_per_container from prime))/sum(square_footage))*count(item_id)
from items
where item_type='not_prime' 
group by item_type
