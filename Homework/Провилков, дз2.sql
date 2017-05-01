
 /*2*/
 SELECT distinct [Date] 
 FROM Trade.sales

 /*3*/
 select distinct customer
 from Trade.sales
 where [Date] between '29.02.2016' and '7.03.2016'

 /*4*/
 select distinct customer
 from trade.Sales
 order by customer asc

 /*5*/
 select customer, number * price as Стоимость 
 from trade.sales

/*6*/
select *
from trade.sales
where (([date] between '01.01.2013' and '31.01.2013') and name like 'М%') or (number > 5 and price < 10)

/*7*/
select top 4 Customer
from trade.sales
where [date] between '01.09.2013' and '30.09.2013'
order by Customer asc

/*8*/
declare @a nvarchar(max)
set @a = '%'
select customer
from trade.sales
where name like @a

/*9*/
select top 1 N_doc
from trade.sales
order by [date] desc

/*10*/
select top 1 *
from trade.sales
order by price asc