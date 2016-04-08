if object_id (N'ElementListView', N'FN') IS NOT NULL
    drop function ElementListView
go
create function ElementListView
(
	@title nvarchar(max),
	@elements_list nvarchar(max)
)
returns xml
AS
begin
	return N'
		<div class="row jumbotron"><h1>' +
			@title +
		N'</h1></div><div class="row">'+
			@elements_list +	
		N'</div>'
end
go
