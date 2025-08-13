23)
write a query to determine items for each order are taken from which batch. assume that items 
are sequentially taken from each batch starting from first batch
Sol:
with batch_cte as 
        (select *, row_number() over(order by batch_id) as rn
        from (
            with recursive batch_split as
                (select batch_id, 1 as quantity from batch
                union all
                select b.batch_id, (cte.quantity+1) as quantity
                from batch_split cte
                join batch b on b.batch_id = cte.batch_id and b.quantity > cte.quantity)
            select batch_id, 1 as quantity
            from batch_split) x),
    order_cte as
        (select *, row_number() over(order by order_number) as rn
        from (
            with recursive order_split as
                (select order_number, 1 as quantity from orders
                union all
                select o.order_number, (cte.quantity+1) as quantity
                from order_split cte
                join orders o on o.order_number = cte.order_number and o.quantity > cte.quantity)
            select order_number, 1 as quantity
            from order_split) x)
select o.order_number, b.batch_id, sum(o.quantity) as quantity
from order_cte o
left join batch_cte b on o.rn = b.rn
group by o.order_number, b.batch_id
order by o.order_number, b.batch_id;
