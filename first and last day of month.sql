use AdventureWorks2017

--End of current Month

select EOMONTH(getdate()) --replace with any date field for any day of month

--First day of current month

select dateadd(day,1,EOMONTH(getdate(),-1))

--First day of month of  any date

select DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)

--first monday o each month

select DATEADD(ww, DATEDIFF(ww, 0, DATEADD(mm, DATEDIFF(mm, 0, OrderDate), 0)), 0),OrderDate from sales.SalesOrderHeader