{{ config(materialized='table') }}
{{ config(schema='Dimensions') }}



{{ dbt_date.get_date_dimension(
        start_date='2015-01-01', 
        end_date='2022-12-31'
    ) 
}}