
CREATE OR REPLACE FUNCTION db_to_csv(path TEXT) RETURNS void AS $$
declare
   tables RECORD;
   statement TEXT;
begin
FOR tables IN 

SELECT 
   (table_schema || '.' || table_name) AS schema_table,
   (table_schema || '__' || table_name) AS csv_name
   FROM information_schema.tables t INNER JOIN information_schema.schemata s 
   ON s.schema_name = t.table_schema 
   WHERE 
   		t.table_schema NOT IN ('pg_catalog', 'information_schema', 'configuration') 
		-- AND table_schema IN ('z_modify_data_lab')
		AND table_schema NOT IN ('Dimensions', 'target', 'z_modify_data_lab')
   		AND t.table_type NOT IN ('VIEW')
   ORDER BY schema_table
   
LOOP
   --statement := 'COPY ' || tables.schema_table || ' TO ''' || path || '/' || tables.schema_table || '.csv' ||''' DELIMITER '';'' CSV HEADER';
   --statement := 'COPY ' || tables.schema_table || ' TO ''' || path || '/' || tables.schema_table || '.csv' ||''' DELIMITER E''\t'' CSV HEADER';
   statement := 'COPY ' || tables.schema_table || ' TO ''' || path || '/' || tables.csv_name || '.csv' ||''' DELIMITER '','' CSV HEADER FORCE QUOTE *';
   EXECUTE statement;
END LOOP;
return;  
end;
$$ LANGUAGE plpgsql;




DO $$ BEGIN
    PERFORM db_to_csv('M:\2023-04. dbt dimensional modelling tutorial\csv_from_postgres');
END $$;

