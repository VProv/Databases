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
 (1,'14.02.14','��� �������','������ ������������','500','5.6'),
 (2,'15.03.14','��� �������','����','200','1.0'),
 (3,'11.01.14','��� �������','���������','500','5.2'),
 (4,'12.05.14','�� ������� �.�.','�����������������','100','6.0'),
 (5,'16.07.14','��� ������','������ ������������','500','5.6'),
 (6,'20.11.15','��� ��������','��������� ����','25','4.5'),
 (7,'21.01.15','��� ���������','�������� �����','20','1.6'),
 (8,'11.02.15','��� �������','������','10','2.6'),
 (9,'01.02.14','�� ����������� �.�.�','������ ������������','500','5.6'),
 (10,'05.10.15','��� �������','�����������������','100','6.0')

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