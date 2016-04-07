create table Movies (
	Id int not null primary key identity(1,1),
	Score float not null,
    Name varchar(64) not null,
	CategoryId int not null foreign key references Categories(Id)
) 
go