/*1*/ 
USE Test
GO 

CREATE SCHEMA Trade 
GO

/*2*/ 
CREATE TABLE Trade.Sales
(
 N_doc INT NOT NULL,
 [Date] DATETIME NULL,
 Customer NVARCHAR(MAX) NOT NULL,
 Name NVARCHAR(MAX) NULL,
 Number INT NOT NULL,
 Price FlOAT NOT NULL,
 PRIMARY KEY(N_doc) 
 )

 /*3*/ 
 INSERT INTO Trade.Sales VALUES 
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

 /*4*/ 
 SELECT * 
 FROM Trade.Sales

 /*5*/ 
 SELECT N_doc, [Date], Customer 
 FROM Trade.Sales

 /*6*/
 DELETE FROM Trade.Sales

 /*7*/

 DROP TABLE Test.Trade.Sales
 
 /*8*/
 DROP SCHEMA Trade