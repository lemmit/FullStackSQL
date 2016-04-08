if object_id (N'GetRouteParam', N'FN') IS NOT NULL
    drop function GetRouteParam
go
create function GetRouteParam
(
	@request xml,
	@position int
)
returns nvarchar(max)
as
begin
	declare @route_params nvarchar(max)
	set @route_params = @request.query('/Request/Url/Path').value('.', 'nvarchar(max)')
	declare @param nvarchar(max)
	--extract controller name
	set @param = (select Item from dbo.SplitString(@route_params, '/') where ItemIndex = @position)
	return @param
end
go