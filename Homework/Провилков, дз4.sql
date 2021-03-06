DECLARE @��������� AS TABLE
(
���� int,
���� datetime,
����������_ID int
 )

 INSERT INTO @��������� VALUES (1,'12.12.2012',1)
 INSERT INTO @��������� VALUES (2,'11.12.2010',2)
 INSERT INTO @��������� VALUES (3,'1.2.2012',3)
 INSERT into @��������� values (4,'10.10.2010',1)
 declare @���������_������ as table (
 ���� int,
 �����_ID int,
 ���� float,
 ����� int)

 INSERT INTO @���������_������ VALUES (1,1,10,5)
 INSERT INTO @���������_������ VALUES (4,1,10,5)
 INSERT INTO @���������_������ VALUES (2,2,22,2)
 INSERT INTO @���������_������ VALUES (3, 3,30,1)

 declare @������ as table (
 �����_ID int,
 ������������ nvarchar(max),
 ���� float,
 ������� int,
 ����� float,
 ����� float
 )

 INSERT INTO @������ VALUES (1,'�������',10, 15,2,1)
 INSERT INTO @������ VALUES (2,'����', 22, 11, 1, 1)
 INSERT INTO @������ VALUES (3,'�������',30, 12,1,13)

 declare @���������� as table (
 ����������_ID int,
 ��� nvarchar(max)
 )

 insert into @���������� values (1, '������ ���� ��������')
 insert into @���������� values (2, '������� ����� ��������')
 insert into @���������� values (3, '������ ���� ���������')

/*2*/
 select ���.����, ���.���
 from @��������� ��� inner join @���������� ���
 on ���.����������_ID = ���.����������_ID
 group by ���.����, ���.���

 /*3*/
 select ���.����, ���.���,max(����.���� * ����.�����) as ���������
 from @��������� ���, @���������� ���, @���������_������ ����
 where ���.����������_ID = ���.����������_ID
 and ���.���� = ����.����
 group by ����.����, ����.�����, ���.����,���.���
 having max(����.���� * ����.�����) = ����.���� * ����.�����
 

 /*4*/
 declare @a int
 set @a = 1

 select ���.���,���.������������
 from @���������� as ���, @������ ���, @��������� ���,@���������_������ as ����
 where ���.����������_ID = ���.����������_ID 
 and
 ���.���� = ����.����
 and
 ����.�����_ID = ���.�����_ID
 and ���.����������_ID = @a

 /*5*/
 declare @����� Datetime
 set @����� = '01.02.2011'
 declare @������ Datetime
 set @������ = '02.02.2012'

 select ���.���, count(distinct ���.������������) as �����
 from @���������� as ���, @������ ���, @��������� ���,@���������_������ as ����
 where ���.����������_ID = ���.����������_ID 
 and
 ���.���� = ����.����
 and
 ����.�����_ID = ���.�����_ID
 and 
 ���.���� between @����� and @������
 group by ���.���

 /*6*/
 select ���.������������, count(distinct ���. ����������_ID) as �����
 from @���������� as ���, @������ ���, @��������� ���,@���������_������ as ����
 where ���.����������_ID = ���.����������_ID 
 and
 ���.���� = ����.����
 and
 ����.�����_ID = ���.�����_ID
 group by ���.������������


 /*7*/
 select ���.����, ���.���, ���.����
 from @���������� as ���, @������ ���, @��������� ���,@���������_������ as ����
 where ���.����������_ID = ���.����������_ID 
 and
 ���.���� = ����.����
 and
 ����.�����_ID = ���.�����_ID
 group by ���.����, ���.���, ���.����, ����.����� * ����.����
 having min(����.����� * ����.����) = ����.����� * ����.����
 and min(����.����� * ����.����) <= 100
 order by ���.���� desc

 /*8*/
 /* ����� � ������ ��� ��������� �����*/

 select count(���. ����) as '����� ����������'
 from @��������� as ���
 where ���.���� between @����� and @������

 /*9*/
 declare @���� datetime
 set @���� = '12.11.2011'

 select ���.���
 from @���������� as ���, @������ ���, @��������� ���,@���������_������ as ����
 where ���.����������_ID = ���.����������_ID 
 and
 ���.���� = ����.����
 and
 ����.�����_ID = ���.�����_ID
 and
 ���.���� > @����
 group by ���.���, ����.���� * ����.�����
 having sum(����.���� * ����.�����) >= 200
 order by ���.��� asc 

 /*10*/
 select ���.����, sum(����.���� * ����.�����) as '�����'
 from @���������� as ���, @������ ���, @��������� ���,@���������_������ as ����
 where ���.����������_ID = ���.����������_ID 
 and
 ���.���� = ����.����
 and
 ����.�����_ID = ���.�����_ID
 group by ���.����
 order by ���.���� desc

 /*11*/
 select ���.����,DATEDIFF(dd,���.����, GetDate()) as '���� ������', ����.���� * ����.����� as '���������'
 from @���������� as ��� inner join @��������� ���
 on ���.����������_ID = ���.����������_ID 
 inner join @���������_������ as ����
 on ���.���� = ����.����
 inner join @������ as ���
 on ����.�����_ID = ���.�����_ID
 group by ���.����, ����.���� * ����.�����, ���.����
 order by (����.���� * ����.�����) desc

 /*12*/
 select ���.����������_ID , ���.�����_ID, sum(����.�����) as '�����'
 from @���������� as ��� inner join @��������� ���
 on ���.����������_ID = ���.����������_ID 
 inner join @���������_������ as ����
 on ���.���� = ����.����
 inner join @������ as ���
 on ����.�����_ID = ���.�����_ID
 group by ���.����������_ID, ���.�����_ID

 /*13*/
 select ���.���
 from @���������� as ��� inner join @��������� ���
 on ���.����������_ID = ���.����������_ID 
 inner join @���������_������ as ����
 on ���.���� = ����.����
 inner join @������ as ���
 on ����.�����_ID = ���.�����_ID
 where ����.���� <> ���.����

 /*14*/
 select ���.���
 from @���������� as ��� inner join @��������� ���
 on ���.����������_ID = ���.����������_ID 
 inner join @���������_������ as ����
 on ���.���� = ����.����
 inner join @������ as ���
 on ����.�����_ID = ���.�����_ID
 where ���.���� between '01.05.2014' and '01.06.2014'
 group by ���.���
 having sum(���.����) > 1

 /*15*/
 select ���.����, ���.���, (���.����� * ����.�����) as '�����'
 from @���������� as ��� inner join @��������� ���
 on ���.����������_ID = ���.����������_ID 
 inner join @���������_������ as ����
 on ���.���� = ����.����
 inner join @������ as ���
 on ����.�����_ID = ���.�����_ID
 order by (���.����� * ����.�����) asc

 /*16*/
 select ���.����, ���.������������, ����.����
 from @���������� as ��� inner join @��������� ���
 on ���.����������_ID = ���.����������_ID 
 inner join @���������_������ as ����
 on ���.���� = ����.����
 inner join @������ as ���
 on ����.�����_ID = ���.�����_ID
 group by ���.����, ���.������������, ����.����

 /*17*/
 select ���.�����_ID, sum(���.����� * ���.�������)as '��������� �����', sum(���.����� * ���. �������) as '��������� ���'
 from @���������� as ��� inner join @��������� ���
 on ���.����������_ID = ���.����������_ID 
 inner join @���������_������ as ����
 on ���.���� = ����.����
 inner join @������ as ���
 on ����.�����_ID = ���.�����_ID 
 group by ���.�����_ID