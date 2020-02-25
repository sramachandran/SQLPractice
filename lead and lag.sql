--LAG() function to access a row at a specific physical offset which comes before the current row
--LEAD() is a window function that provides access to a row at a specified physical offset which follows the current row.


--LEAD

SELECT 
 JobTitle,
 city,
 StateProvinceName,
 LEAD(SalesQuota,1) OVER (
 PARTITION BY  JobTitle,
 city,
 StateProvinceName
 ORDER BY  JobTitle,
 city,
 StateProvinceName
 ) next_month_sales
FROM 
 sales.vSalesPerson
