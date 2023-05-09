SELECT * FROM person.person
LIMIT 100

SELECT table_name, table_schema, table_type
FROM information_schema.tables
WHERE table_type='BASE TABLE' AND 
	table_schema NOT IN ('pg_catalog', 'information_schema')
	
SELECT * FROM person.person
LIMIT 100

SELECT productid, name, 
FROM production.product
LIMIT 100


SELECT * FROM target.dim_product
LIMIT 100

SELECT * FROM production.productphoto
LIMIT 100

