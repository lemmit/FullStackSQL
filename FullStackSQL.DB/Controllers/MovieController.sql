/* MoviesController */
if object_id (N'MovieController', N'P') IS NOT NULL
    drop procedure MovieController
go
-- controller actions
if object_id (N'MovieController_Details', N'P') IS NOT NULL
    drop procedure MovieController_Details
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

create procedure MovieController_Details
	@movie_id int,
	@response xml OUTPUT
as 
begin
	set @response = 
	N'<div class="jumbotron"><h1>Movie</h1></div>
		<div class="row">
			<div class="col-md-3">Title: ' +
				(select Name from Movies where Movies.Id = @movie_id) +
			N'</div>
			<div class="col-md-3">' +
				N'Score:' + (select STR(Score) from Movies where Movies.Id = @movie_id) +
				N'<br/>Category:' + (select Categories.Name 
									from Categories, Movies 
									where @movie_id = Movies.Id and 
											Movies.CategoryId = Categories.Id) +
			N'</div>
		</div>'
end
go

