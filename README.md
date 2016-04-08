Code in this repository is example implementation of SQL-all-the-way MVC web application.  

How it works?  
[Selfhosted Nancy]->[Request object]->[Ado.Net] -> [Router stored procedure]->[Appropriate controller]  
C# application is server-like app that routes whole request to the stored procedure (it is possible to easily change .NET/Nancy example with e.g. Node or something else) and holds no logic at all.  

Important part (and where you probably want to start reading the code) is Router that dispatches part of the route and runs  controller stored procedure based on naming convention. Controllers encapsulate logic about which action should be called and do further url parsing. Actions fill data into view functions.  

Deployment:  
deploy FullstackSQL.DB to your database - use FullstackSQL.DB.sql script, or Publish from Visual Studio  
Run: 
set connection string in FullstackSQL App.config and run ;)  

The project was intended to extend my knowledge about T-SQL. Probably many thing can be designed better. Message me if you have an idea how to make it better ;)