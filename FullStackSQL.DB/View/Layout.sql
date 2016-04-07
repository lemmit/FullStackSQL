/* Main layout */
if object_id (N'Layout', N'P') IS NOT NULL
    drop procedure Layout
go
create procedure Layout
	@body xml,
	@response xml OUTPUT
as
declare @layout xml
set @layout = N'<html>
					<head>
						<link rel="stylesheet" type="text/css" href="/Content/style.css" />
						<link rel="stylesheet" type="text/css" href="/Content/bootstrap.min.css" />
					</head>
					<body>
					<div class="container">
						<div id="content">
						</div>
					</div>
					<div id="debug">
					</div>
					</body>
				</html>'
begin
	set @layout.modify('insert sql:variable("@body") as first into (/html/body/div/div[@id="content"])[1]')
	set @response = @layout
end
go
