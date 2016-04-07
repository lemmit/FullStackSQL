/*
Application Router
*/
if object_id (N'Router', N'P') IS NOT NULL
    drop procedure Router;
go
create procedure Router 
	@request xml,
	@response xml OUTPUT
as
begin
	declare @view xml
	begin try
		declare @controller_name nvarchar(max)
		--extract controller name
		select @controller_name = dbo.GetRouteParam(@request, 1)

		if @controller_name is null or @controller_name = ''
			-- show home view on empty route
			exec CategoryController @request, @response = @view OUTPUT
		else 
			--call appropriate controller procedure
			begin
				declare @controller_procedure_cmd varchar(max)
				set @controller_procedure_cmd = @controller_name + N'Controller'
				exec @controller_procedure_cmd @request, @response = @view OUTPUT
			end
	end try
	begin catch
		if ERROR_NUMBER() = 2812
			set @view = N'<h1>Error - route controller not found [' + @controller_name + N']'+ ERROR_MESSAGE() +N'</h1>'
		else 
			set @view = N'<h1>Unknown error:' + ERROR_MESSAGE() + N'</h1>'
	end catch

	exec Layout @view, @response output
	--add debug info
	--set @response.modify('insert sql:variable("@request") into (/html/body/div[@id="debug"])[1]')
end
go