---CUBE

--Grouping sets specify groupings of data in a single query. For example, the following query defines a single grouping set represented as (brand):


--can be used to generate multiple grouping sets

--partial grouping sets

use AdventureWorks2017

select p.rowguid,a.City,b.City,max(s.UnitPrice) as UnitPrice from sales.SalesOrderDetail s
join sales.SpecialOfferProduct p on s.ProductID=p.ProductID
join sales.SalesOrderHeader sh on s.SalesOrderID=sh.SalesOrderID
join person.Address a on sh.ShipToAddressID=a.AddressID
join person.Address b on sh.BillToAddressID=b.AddressID
group by
p.rowguid,
cube(a.City,b.city)

--full grouping sets

use AdventureWorks2017

select p.rowguid,a.City,b.City,max(s.UnitPrice) as UnitPrice from sales.SalesOrderDetail s
join sales.SpecialOfferProduct p on s.ProductID=p.ProductID
join sales.SalesOrderHeader sh on s.SalesOrderID=sh.SalesOrderID
join person.Address a on sh.ShipToAddressID=a.AddressID
join person.Address b on sh.BillToAddressID=b.AddressID
group by
cube(p.rowguid,a.City,b.city)



select p.rowguid,a.City,b.City,max(s.UnitPrice) as UnitPrice from sales.SalesOrderDetail s
join sales.SpecialOfferProduct p on s.ProductID=p.ProductID
join sales.SalesOrderHeader sh on s.SalesOrderID=sh.SalesOrderID
join person.Address a on sh.ShipToAddressID=a.AddressID
join person.Address b on sh.BillToAddressID=b.AddressID
group by p.rowguid,a.City,b.City
order by a.City,b.City