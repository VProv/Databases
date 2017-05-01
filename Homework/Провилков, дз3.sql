/*1*/
declare @sales as table (
	N_doc INT NOT NULL,
	[Date] DATETIME NULL,
	Customer NVARCHAR(MAX) NOT NULL,
	Name NVARCHAR(MAX) NULL,
	Number INT NOT NULL,
	Price FlOAT NOT NULL,
	PRIMARY KEY(N_doc) 
)

INSERT INTO @sales VALUES 
 (1,'14.02.14','ООО «Гарант»','Кирпич облицовочный','500','5.6'),
 (2,'15.03.14','ОАО «Гарант»','Вата','200','1.0'),
 (3,'11.01.14','ОАО «Вектор»','Пенобетон','500','5.2'),
 (4,'12.05.14','ИП Михеева А.П.','Металоконструкции','100','6.0'),
 (5,'16.07.14','ООО «Канал»','Кирпич облицовочный','500','5.6'),
 (6,'20.11.15','ООО «Магазун»','Монтажная пена','25','4.5'),
 (7,'21.01.15','ООО «Мираторг»','Изолента синяя','20','1.6'),
 (8,'11.02.15','ООО «Гарант»','Краска','10','2.6'),
 (9,'01.02.14','ИП «Кожевников С.В.»','Кирпич облицовочный','500','5.6'),
 (10,'05.10.15','ООО «Гарант»','Металоконструкции','100','6.0')

 /*2*/
 select Name, price
 from @sales
 where price = (select max(price) from @sales)


 /*3*/
 select N_doc,[Date] as Дата, (number * price) as '«Стоимость»' 
 from @sales
 where (number * price) = (select max(number * price) from @sales)

 /*4*/
 select customer, sum(number) as 'Кол-во покупок'
 from @sales
 group by customer
 order by sum(number) desc

 /*5*/
 select customer, AVG(number * price) as 'Средняя стоимость покупки'
 from @sales
 group by customer

 /*6*/
 select name, count(distinct customer) as 'Кол-во покупателей'
 from @sales
 group by name

 /*7*/
 select [date], Customer, N_doc
 from @Sales 
 group by [date], Customer, N_doc, price * number
 having min(price * number) = price * number
 order by [date] desc

 /*8*/
 declare @ДатаС datetime
 declare @ДатаПо datetime
 set @ДатаС = '12.12.2014'
 set @ДатаПо = '12.12.2015'

 select count(N_doc) as 'Колво документов'
 from @Sales
 where [date] between @ДатаС and @ДатаПО

 /*9*/
 declare @Дата datetime
 set @Дата = '11.11.2011'

 select *
 from @Sales
 where [date] > @Дата and Price <= 20 and number >= 300
 order by name asc

 /*10*/
 select [date], sum(number * price) as 'Суммарная стоимость'
 from @Sales
 group by [date]
 order by [date] asc

 /*11*/
 select *, DATEDIFF(dd,[date], GetDate()) as 'Прошло дней'
 from @Sales
 order by number * price desc 

 /*12*/
 select Customer, name, sum(number) as 'Колво'
 from @Sales
 group by Customer, name