19)write an sql query to find users who purchased different products on different dates i.e  
  products purchased on any given day are not repeated on any other day
Sol:
select userid,count(distinct purchasedate) count_dates
,count(*) count_all,count(distinct productid) count_prod_id from purchase_history
group by userid
having count(distinct purchasedate)>1 and count(*)=count(distinct productid)
