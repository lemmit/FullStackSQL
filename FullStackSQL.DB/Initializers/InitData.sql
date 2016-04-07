--add some categories
set identity_insert Categories on
insert into Categories(Id, Name) values 
	(1, 'Action'),
	(2, 'Adventure'),
	(3, 'Biography'),
	(4, 'Drama'),
	(5, 'Fantasy'),
	(6, 'Horror'),
	(7, 'Musical')
set identity_insert Categories off
go

--add some movies
set identity_insert Movies on
insert into Movies(Id, Score, Name, CategoryId) values
--action movies
	(1, 7, 'Avengers', 1),
	(2, 8, 'The Dark Knight', 1),
	(3, 9, 'Matrix', 1),
	(4, 6, 'Mr. and Mrs. Smith', 1),
	(5, 8.5, 'Kill Bill', 1),
--adventure movies
	(6, 7, 'Pirates of the Caribbean', 2),
	(7, 7.5, 'Ice Age', 2),
	(8, 10, 'Sherlock Holmes', 2),
	(9, 9, 'Back to the Future', 2),
	(10, 9.5, 'Jurrasic Park', 2),
--biographies
	(11, 10, 'Intouchables', 3),
	(12, 8, 'The Pianist', 3),
	(13, 8.5, 'A Beautiful Mind', 3),
	(14, 7.5, 'The Wolf of Wall Street', 3),
--dramas
	(15, 8, 'The Green Mile', 4),
	(16, 9.5, 'Forest Gump', 4),
	(17, 8.5, 'The Shawshank Redemption', 4),
	(18, 8, 'Leon', 4),
	(19, 9, 'Requiem for a Dream', 4),
--fantasy movies
	(20, 9, 'Lord of the Rings', 5),
	(21, 7.5, 'Bruce Almighty', 5),
	(22, 7, 'The Curious ase of Benjamin Button', 5),
	(23, 10, 'Edward Scissorhands', 5),
	(24, 8.5, 'Harry Potter', 5),
--horror movies
	(25, 7, 'I Am Legend', 6),
	(26, 8, 'The Shining', 6),
	(27, 3, 'Twilight', 6),
	(28, 6, 'Interview with the Vampire', 6),
	(29, 7.5, '1408', 6),
--musicals
	(30, 7.5, 'Sweeney Todd', 7),
	(31, 7, 'Mamma Mia!', 7),
	(32, 8, 'Frozen', 7),
	(33, 9, 'Les Miserables', 7)
set identity_insert Movies off
go