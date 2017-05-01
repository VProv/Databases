use budget
drop table t

go 
use budget create table t (
id int, 
x int, 
y int,
value float
primary key(id,x,y)
)

insert into t values 
(1,1,1,1),
(1,2,1,0),
(1,1,2,0),
(1,2,2,1),

(2,1,1,1),
(2,2,1,2),
(2,2,2,0),
(2,1,2,3),

(3,1,1,2),
(3,2,1,4),
(4,1,1,2),
(4,1,2,1),

(5,1,1,2),
(5,1,2,1),
(5,1,3,1),
(6,1,1,2)

/*создадим вспомогательные функции*/

declare @id int
set @id = 1

use budget 
go

if object_id (N'dbo.f_vector',N'FN') is not null
		drop function  dbo.f_vector;
		
go
create function dbo.f_vector (@id as int)
returns Nvarchar(max)
as 
begin
	declare @max_x int
	declare @max_y int
	declare @res nvarchar(max)
	set @max_x = (select Max(x) from t where id = @id)
	set @max_y = (select max(y) from t where id = @id)

	if (@max_x > 1 and @max_y = 1) set @res = 'вектор'
	else set @res = 'не вектор'
return @res
end


go



use Budget 
go
if object_id (N'dbo.f_transp', N'IF') is not null
	drop function dbo.f_transp;
go

create function dbo.f_transp (@id as int)
returns table
as
return
( select id, y as [x], x as [y], value
from t where id = @id
);


sELECT * fROM dbo.f_transp(1)


use budget 
go

if object_id (N'dbo.f_kvadrat', N'FN') is not null
	drop function dbo.f_kvadrat;
go
create function dbo.f_kvadrat (@id as int)
returns nvarchar(max)
as

begin

	declare @max_x int
	declare @max_y int
	declare @res nvarchar(max)
	set @max_x = (select max(x) from t where id = @id)
	set @max_y = (select max(y) from t where id = @id)

	if (@max_x = @max_y) set @res ='квадратная'
	else set @res = 'не квадратная'
	return @res
end



/*1*/
use budget 
go

if object_id (N'dbo.f_simmetric', N'FN') is not null
	drop function dbo.f_simmetric;
go
create function dbo.f_simmetric (@idn as int)
returns nvarchar(max)
as
begin

declare @res nvarchar(max)
if (SELECT CASE 
			WHEN (dbo.f_kvadrat (@idn) = 'не квадратная') THEN 'не симметричная'
			ELSE 
				CASE
					WHEN (
						SELECT SUM(ABS(t1.value - t2.value))
						FROM dbo.f_transp(@idn) AS t1, (SELECT * FROM T WHERE id = @idn) as t2
						WHERE t1.id = t2.id AND t1.x = t2.x AND t1.y = t2.y AND t1.value <> t2.value 
						) > 0
					
					THEN 'не симметричная'
					ELSE 'симметричная'
				END
	   END AS Результат) = 'не симметричная' set @res = 'false'
else	set @res = 'true'
return @res
end

/*2*/
use budget
go

if object_id (N'dbo.f_identity', N'FN') is not null
	drop function dbo.f_identity;
go
create function dbo.f_identity (@ids as int)
returns nvarchar(max)
as
begin

declare @res nvarchar(max)
if (SELECT CASE 
			WHEN (dbo.f_kvadrat (@ids) = 'не квадратная') THEN 'не единичная'
			ELSE 
				CASE
					WHEN (
						SELECT COUNT(value)
						FROM T 
						WHERE x=y AND value <> 1
						AND id = @ids
						) > 0
					
					THEN 'не единичная'
					ELSE 
						CASE
							WHEN (
								SELECT COUNT(value)
								FROM T 
								WHERE x<>y AND value <> 0
								AND id = @ids
								) > 0
							THEN 'не единичная'
							ELSE 'единичная'	
						END
				END
	   END AS Результат) = 'не единичная' set @res = 'false'
else set @res = 'true'
return @res
end

/*3*/

use budget
go

if object_id (N'dbo.f_canSum', N'FN') is not null
	drop function dbo.f_canSum;
go
create function dbo.f_canSum (@id1 as int,@id2 as int)
returns nvarchar(max)
as
begin
declare @res nvarchar(max)
	declare @Xsize1 int
	declare @Xsize2 int
	declare @Ysize1 int
	declare @Ysize2 int
	set @Xsize1 = (SELECT MAX(x) FROM T WHERE id=@id1)
	set @Xsize2 = (SELECT MAX(x) FROM T WHERE id=@id2)
	set @Ysize1 = (SELECT MAX(y) FROM T WHERE id=@id1)
	set @Ysize2 = (SELECT MAX(y) FROM T WHERE id=@id2)
	if (@Xsize1 = @Xsize2 and @Ysize1 = @Ysize2) set @res = 'true'
	else set @res = 'false'
return @res
end

/*4*/
use budget
go

if object_id (N'dbo.f_Summing', N'IF') is not null
	drop function dbo.f_Summing;
go
create function dbo.f_Summing (@id1 as int,@id2 as int)
returns table
as
return
(
	select t1.x,t1.y, t1.value + t2.value as value
	from (SELECT * FROM T WHERE id = @id2) as t2, (SELECT * FROM T WHERE id = @id1) as t1
	where t2.x = t1.x and t1.y = t2.y
);

use budget
go

if object_id (N'dbo.f_Val', N'FN') is not null
	drop function dbo.f_Val;
go
create function dbo.f_Val (@id as int, @a as int, @b as int)
returns int
as
begin
	return (select value from T where id = @id and x = @a and y = @b)
end

/*5*/
use budget
go

if object_id (N'dbo.f_canMultyply', N'FN') is not null
	drop function dbo.f_canMultyply;
go
create function dbo.f_canMultyply (@id1 as int,@id2 as int)
returns nvarchar(max)
as
begin
declare @res nvarchar(max)
	declare @Xsize2 int
	declare @Ysize1 int
	set @Xsize2 = (SELECT MAX(x) FROM T WHERE id=@id2)
	set @Ysize1 = (SELECT MAX(y) FROM T WHERE id=@id1)
	if (@Ysize1 = @Xsize2) set @res = 'true'
	else set @res = 'false'
return @res
end

/*6*/
use budget
go

IF OBJECT_ID(N'dbo.f_multiply', N'IF') IS NOT NULL
DROP FUNCTION dbo.f_multiply
GO

CREATE FUNCTION dbo.f_multiply (@id1 INT, @id2 INT)
RETURNS TABLE
AS
RETURN
(
SELECT T1.x, T2.y, SUM(T1.value * T2.value) AS value
FROM (SELECT * FROM T WHERE id = @id1) T1 INNER JOIN (SELECT * FROM T WHERE id = @id2) T2
ON T1.y = T2.x
GROUP BY T1.x, T2.y
);



