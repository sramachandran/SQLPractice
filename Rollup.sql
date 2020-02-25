--rollups


--The SQL Server ROLLUP is a subclause of the GROUP BY clause which provides a shorthand for defining multiple grouping sets. 
--Unlike the CUBE subclause, ROLLUP does not create all possible grouping sets based on the dimension columns; the CUBE makes a subset of those.

--When generating the grouping sets, ROLLUP assumes a hierarchy among the dimension columns and only generates grouping sets based on this hierarchy.


SELECT
    city,
    StateProvinceName,
    SUM (SalesQuota) sales
FROM
[Sales].[vSalesPerson]
GROUP BY
    ROLLUP(city, StateProvinceName);
	
	
