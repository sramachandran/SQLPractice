--Remove Duplicates

DROP TABLE IF EXISTS sales.contacts;
 
CREATE TABLE dbo.contacts(
    contact_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL,
);


INSERT INTO dbo.contacts
    (first_name,last_name,email) 
VALUES
    ('Syed','Abbas','syed.abbas@example.com'),
    ('Catherine','Abel','catherine.abel@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Pilar','Ackerman','pilar.ackerman@example.com');


--using rown number to determine multiple instances of same record and using rwnumber>1 to delete them

with cte as
(
select 
first_name,
last_name,email,ROW_NUMBER() over (partition by first_name,
last_name,email
order by 
first_name,
last_name,email) rown
from
dbo.contacts
) 

Delete from cte 
where rown>1