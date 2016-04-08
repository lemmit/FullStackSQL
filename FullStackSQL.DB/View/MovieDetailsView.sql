if object_id (N'MovieDetailsView', N'FN') IS NOT NULL
    drop function MovieDetailsView
go
create function MovieDetailsView
(
	@title nvarchar(max),
	@score nvarchar(max),
	@category_name nvarchar(max)
)
returns xml
AS
begin
	return N'<div class="row jumbotron"><h1>Movie</h1></div>
		<div class="row">
			<div class="col-md-3">Title: ' +
				@title +
			N'</div>
			<div class="col-md-3">' +
				N'Score:' + @score +
				N'<br/>Category:' + @category_name +
			N'</div>
		</div>'
end
go
