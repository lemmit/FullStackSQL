/* CategoryController*/
if object_id (N'CategoryController', N'P') IS NOT NULL
    drop procedure CategoryController
go
if object_id (N'CategoryController_ListMoviesFromCategory', N'P') IS NOT NULL
    drop procedure CategoryController_ListMoviesFromCategory
go
if object_id (N'CategoryController_List', N'P') IS NOT NULL
    drop procedure CategoryController_List;
go

create procedure CategoryController 
	@request xml,
	@response xml OUTPUT
as
begin
	declare @category_id int
	select @category_id = dbo.GetRouteParam(@request, 2)
	if @category_id is null or @category_id = '' 
		exec CategoryController_List @response OUTPUT
	else
		exec CategoryController_ListMoviesFromCategory @category_id, @response OUTPUT
end
go

--controller actions
create procedure CategoryController_ListMoviesFromCategory
	@category_id int,
	@response xml OUTPUT
as
begin
	declare @resp nvarchar(max)
	select @resp = COALESCE(@resp+M.movieCard, M.movieCard)
						FROM 
						(
							select CONCAT(N'<div class="col-md-3"><a class="btn btn-default" href="/Movie/', LTRIM(STR(Id)), N'">', Name, N'</a></div>') as movieCard 
							from Movies
							where Movies.CategoryId = @category_id
						)
						M
	set @response = 
		N'<div class="row jumbotron"><h1>Movies from category: '+
		(select Name from Categories where Categories.Id = @category_id)+
		N'</h1></div>
		<div class="row">'+
			@resp +	
		N'</div>'
end
go

create procedure CategoryController_List
	@response xml OUTPUT
as
begin
	declare @resp nvarchar(max)
	select @resp = COALESCE(@resp+C.categoryCard, C.categoryCard)
						FROM 
						(select CONCAT(N'<div class="col-md-3"><a class="btn btn-default" href="/Category/', LTRIM(STR(Id)), N'">', Name, N'</a></div>') as categoryCard from Categories)
						C
	set @response = N'
		<div class="row jumbotron"><h1>Movie Database</h1></div>
		<div class="row">'+
			@resp +	
		N'</div>'
end
go