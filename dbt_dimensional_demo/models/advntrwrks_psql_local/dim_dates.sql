{{ config(materialized='table') }}
{{ config(schema='Dimensions') }}


{%- set datepart = "day" -%}
{%- set start_date = "TO_DATE('2021/01/01', 'yyyy/mm/dd')" -%}
{%- set end_date = "TO_DATE('2021/04/01', 'yyyy/mm/dd')" -%}

{%- set datepart = "day" -%}
{%- set start_date = "(select MIN(cast(orderdate as date)) from sales.salesorderheader)" -%}
{%- set end_date = "(select MAX(cast(orderdate as date)) + (interval '1 day') from sales.salesorderheader)" -%}


{%- set comment_1 = "Inspirado en https://dbtvault.readthedocs.io/en/latest/tutorial/tut_as_of_date/" -%}


with as_of_date AS (

    {{ dbt_utils.date_spine(
        datepart=datepart, 
        start_date=start_date,
        end_date=end_date
       ) 
    }}
    
)

SELECT * FROM as_of_date