--https://www.linkedin.com/feed/update/urn:li:activity:7126047852455202816/

Question:
write a SQL query to find all the couples of trade for same stock that happened in the range of 10 sec and having the price difference more than 25%
note: output should also contain the list of percentage of price difference between the two trades

Create Table Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
)
Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19)

solution:
select T1.trade_id,T2.trade_id,T1.trade_timestamp,T2.trade_timestamp,T1.price,T2.price,
abs((T1.price-T2.price)*1.0*100/T1.price) as percent_price
--T1.trade_id, T2.trade_id)
from trade_tbl T1
join
trade_tbl T2
on T1.trade_id<>T2.trade_id
where DATEDIFF(second,T1.trade_timestamp,T2.trade_timestamp) between 0 and 10
and abs((T1.price-T2.price)*1.0*100/T1.price)>=25
order by T1.trade_id
