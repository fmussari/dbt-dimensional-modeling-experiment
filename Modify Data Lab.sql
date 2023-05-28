-- Modify Data - Lab
-- https://microsoftlearning.github.io/dp-080-Transact-SQL/Instructions/Labs/05-modify-data.html

CREATE SCHEMA IF NOT EXISTS z_modify_data_lab;

--DROP TABLE z_modify_data_lab.call_log;
 --CREATE TABLE IF NOT EXISTS z_modify_data_lab.CallLog
CREATE TABLE IF NOT EXISTS z_modify_data_lab.call_log
 (
     --CallID int IDENTITY PRIMARY KEY NOT NULL, --MS SQL
	 call_id int PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY, --PSQL
     --CallTime datetime NOT NULL DEFAULT GETDATE(),
	 call_time timestamp NOT NULL DEFAULT NOW(),
     --SalesPerson nvarchar(256) NOT NULL,
	 sales_person char(256) NOT NULL,
     customer_id int NOT NULL REFERENCES sales.customer(customerid),
     --PhoneNumber nvarchar(25) NOT NULL,
	 phone_number char(25) NOT NULL,
     --Notes nvarchar(max) NULL
	 notes text NULL
 );
 
INSERT INTO z_modify_data_lab.call_log (call_time, sales_person, customer_id, phone_number, notes)
VALUES
('2015-01-01T12:30:00', 'adventure-works\pamela0', 1, '245-555-0173', 'Returning call re: enquiry about delivery'),
(DEFAULT, 'adventure-works\quarto', 2, '245-555-0174', 'Caveats');
 
 
INSERT INTO z_modify_data_lab.call_log
VALUES
(DEFAULT, DEFAULT, 'adventure-works\jupyter', 2, '245-555-0175', 'Sedici');

INSERT INTO z_modify_data_lab.call_log (sales_person, customer_id, phone_number)
VALUES
('adventure-works\jillian0', 3, '279-555-0130');


INSERT INTO z_modify_data_lab.call_log
VALUES
--(DATEADD(mi,-2, GETDATE()), 'adventure-works\jillian0', 4, '710-555-0173', NULL),
-- Esta traducción la hizo Bard usando `CURRENT_DATE`, pero en realidad se necesita `NOW()`
(DEFAULT, NOW() + INTERVAL '-2 minutes', 'adventure-works\jillian5', 12, '710-555-0173', DEFAULT),
(DEFAULT, CURRENT_DATE + INTERVAL '-2 minutes', 'adventure-works\shu4', 13, '828-555-0186', 'Called');

SELECT * FROM z_modify_data_lab.call_log

SELECT NOW() + INTERVAL '-2 minutes', CURRENT_DATE + INTERVAL '-2 minutes'

-- OTRA TABLA
SELECT * FROM sales.salesperson 
JOIN person.person ON sales.salesperson.businessentityid=person.person.businessentityid




INSERT INTO z_modify_data_lab.call_log (sales_person, customer_id, phone_number, notes)
SELECT SalesPerson, CustomerID, Phone, 'Sales promotion call'
FROM SalesLT.Customer
WHERE CompanyName = 'Big-Time Bike Store';

