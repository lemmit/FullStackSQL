/* MoviesController */
if object_id (N'MovieController', N'P') IS NOT NULL
    drop procedure MovieController
go
create procedure MovieController 
	@request xml,
	@response xml OUTPUT
as
begin
	declare @movie_id int
	select @movie_id = dbo.GetRouteParam(@request, 2)
	if @movie_id is null or @movie_id = ''
		exec CategoryController @request, @response OUTPUT
	else
		exec MovieController_Details @movie_id, @response OUTPUT
end
go

-- controller actions
if object_id (N'MovieController_Details', N'P') IS NOT NULL
    drop procedure MovieController_Details
go
create procedure MovieController_Details
	@movie_id int,
	@response xml OUTPUT
as 
begin
	declare @title nvarchar(max)
	declare @score nvarchar(max)
	declare @category_name nvarchar(max)
	set @title = (select Name from Movies where Movies.Id = @movie_id)
	set @score = (select STR(Score) from Movies where Movies.Id = @movie_id)
	set @category_name = (select Categories.Name 
							from Categories, Movies 
							where @movie_id = Movies.Id and 
								  Movies.CategoryId = Categories.Id)
	select @response = dbo.MovieDetailsView(@title, @score, @category_name)
end
go

