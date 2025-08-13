--https://www.linkedin.com/feed/update/urn:li:activity:7128252402339610624/

create table rider_status
(
order_date date,
number_of_orders int,
status_of_order varchar(20),
monetary_value int,
service_name varchar(20)
);

insert into rider_status values
('2023-11-08', 75, 'success', 60000, 'pool'),
('2023-11-08', 50, 'cancelled', 12000, 'black'),
('2023-11-09', 90, 'success', 10000, 'xl'),
('2023-11-10', 60, 'cancelled', 20000, 'pool'),
('2023-11-11', 80, 'success', 55000, 'black'),
('2023-11-11', 40, 'cancelled', 13000, 'xl'),
('2023-11-12', 70, 'success', 7000, 'pool'),
('2023-11-13', 85, 'cancelled', 22000, 'black'),
('2023-11-14', 55, 'success', 45000, 'xl'),
('2023-11-14', 95, 'cancelled', 9000, 'pool')

Question:
write a query to find top 2 highest cancellation rate,average monetary value and maximum order count across order_dates among service_names

sol:
select top 2 service_name,
round(100*1.0*sum(case when status_of_order='cancelled' then number_of_orders else 0 end)/sum(number_of_orders),2) as cancellation_rate,
1.0*AVG(monetary_value) as avg_value
,max((number_of_orders)) as max_orders
from rider_status
group by service_name
order by cancellation_rate desc
