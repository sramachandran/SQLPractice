use TEST


CREATE TABLE Families (
   id int identity constraint PK_JSON_ID primary key,
   doc nvarchar(max)
)

---insert json

insert into Families
values(
'{
  "id": "WakefieldFamily",
  "parents": [
      { "familyName": "Wakefield", "givenName": "Robin" },
      { "familyName": "Miller", "givenName": "Ben" }
  ],
  "children": [
      {
        "familyName": "Merriam",
        "givenName": "Jesse",
        "gender": "female",
        "grade": 1,
        "pets": [
            { "givenName": "Goofy" },
            { "givenName": "Shadow" }
        ]
      },
      { 
        "familyName": "Miller",
         "givenName": "Lisa",
         "gender": "female",
         "grade": 8 }
  ],
  "address": { "state": "NY", "county": "Manhattan", "city": "NY" },
  "creationDate": 1431620462,
  "isRegistered": false
}')

--isjson function to determine if field is json

select * from Families
where ISJSON(doc)>0


--json value to determine vaue of key in key value pair

SELECT JSON_VALUE(f.doc, '$.id')  AS Name, 
       JSON_VALUE(f.doc, '$.address.city') AS City,
       JSON_VALUE(f.doc, '$.address.county') AS County
FROM Families f 
WHERE JSON_VALUE(f.doc, '$.id') = N'WakefieldFamily'
ORDER BY JSON_VALUE(f.doc, '$.address.city') DESC, JSON_VALUE(f.doc, '$.address.state') ASC


--json query is used to select data fromjason array

select 
JSON_QUERY(f.doc,'$.address') as address,
JSON_QUERY(f.doc,'$.parents') as Parents,
JSON_QUERY(f.doc,'$.children') as Children
from Families f


select 
JSON_VALUE(f.doc,'$.id') as id,
JSON_VALUE(f.doc,'$.address.city') as city,
grade,
givenName
from
Families F
cross apply openjson(f.doc,'$.children')
with(grade int, givenName nvarchar(100)) c

SELECT	familyName,
	c.givenName AS childGivenName,
	c.firstName AS childFirstName,
	p.givenName AS petName 
FROM Families f 
	CROSS APPLY OPENJSON(f.doc) 
		WITH (familyName nvarchar(100), children nvarchar(max) AS JSON)
		CROSS APPLY OPENJSON(children) 
		WITH (givenName nvarchar(100), firstName nvarchar(100), pets nvarchar(max) AS JSON) as c
			OUTER APPLY OPENJSON (pets)
			WITH (givenName nvarchar(100))  as p

declare @info varchar(100)
declare @jsoninfo varchar(1000)
set @jsoninfo='{ "state": "NY", "county": "Manhattan", "city": "NY" }'
set @info = JSON_MODIFY(@jsonInfo, '$.city', 'SL')   
select(@info)
SET @info = JSON_MODIFY(@jsonInfo, '$.state', 'WS')   