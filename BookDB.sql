CREATE DATABASE BookDB

CREATE TABLE Authors(
Id int primary key identity,
[Name] nvarchar (50),
Surname nvarchar (50)
)

CREATE TABLE Books(
Id int primary key identity,
[Name] nvarchar (100)
check (len(name) >1 and len(name) <101),
AuthorId int references Authors(Id),
PageCount int
check ( pagecount >9)
)

INSERT INTO Authors
values ('Turkan','Dadasova'),('Anar','Balacayev'),('Resul','Rustamli')

INSERT INTO Books
values ('Nece dersde Deadshot oynanilir?',1,10),('Qayib yazma hobbysi',2,7986896),('Telebeleri atib getme ensiklopediyasi',3,5757969)

CREATE VIEW View_adi_tapammadim
as
SELECT CONCAT(a.name,' ',a.Surname)as [FullName],b.Id,b.Name as [Book name],b.PageCount  FROM Books as b
join Authors as a
on b.AuthorId=a.Id

SELECT * from View_adi_tapammadim

CREATE PROCEDURE usp_SearchBooksByName (@Name nvarchar(50))
as
begin
    SELECT CONCAT(A.Name, ' ', A.Surname) as FullName,B.Id as BookId,B.Name as BookName,B.PageCount FROM Books as B
    JOIN Authors A ON B.AuthorId = A.Id
    WHERE
        B.Name LIKE @Name
        
END

EXEC usp_SearchBooksByName 'Qayib yazma hobbysi'

CREATE PROCEDURE usp_SearchBooksByAuthor (@Name nvarchar(50))
as
begin
    SELECT CONCAT(A.Name, ' ', A.Surname) as FullName,B.Id as BookId,B.Name as BookName,B.PageCount FROM Books as B
    JOIN Authors A 
	ON B.AuthorId = A.Id
    WHERE A.Name LIKE @Name
        
END

EXEC usp_SearchBooksByAuthor 'Turkan'

CREATE PROCEDURE usp_InsertAuthor (@Name nvarchar(50),@Surname nvarchar(50))
as
BEGIN
    INSERT INTO Authors
    VALUES (@Name,@Surname)
END

EXEC usp_InsertAuthor 'Peri','Memmedova'

SELECT * FROM Authors

CREATE PROCEDURE usp_UpdateAuthor (@OldName nvarchar(50),@NewName nvarchar(50),@NewSurname nvarchar(50))
as
BEGIN
    UPDATE Authors
    SET Name = @NewName,
        Surname = @NewSurname
    WHERE Name = @OldName
END

EXEC usp_UpdateAuthor 'Peri','Qureys','Qedirli'

SELECT * FROM Authors

CREATE PROCEDURE usp_DeleteAuthor (@Name nvarchar(50))
as
BEGIN
    DELETE Authors
    WHERE Name = @Name
END

EXEC usp_DeleteAuthor 'Qureys'

INSERT INTO Books
values ('Gunde 34233 dene story atma seneti',1,234),('Oxumadan kesilmeden BDUda heyatda qalma rehberi',1,545),('Cevrenin sahesinin tapilmasi',2,10)

SELECT * FROM Books

CREATE VIEW use_GetAuthor
as
select A.ID ,Concat(A.Name,'.',A.Surname) as FullName,count(B.ID) as BooksCount ,
max(B.PageCount) as MaxPageCount from Authors as A
join Books as B
on B.AuthorID=A.ID
group by A.ID,A.Name ,A.Surname

SELECT * FROM use_GetAuthor
