{{ config(materialized='table') }}
{{ config(schema='Dimensions') }}


{%- set comment = "This works" -%}
{%- set comment = "Inspired in https://dbtvault.readthedocs.io/en/latest/tutorial/tut_as_of_date/" -%}

{%- set datepart = "day" -%}
{%- set start_date = "TO_DATE('2021/01/01', 'yyyy/mm/dd')" -%}
{%- set end_date = "TO_DATE('2021/04/01', 'yyyy/mm/dd')" -%}


{%- set comment = "This variation also works" -%}

{%- set datepart = "day" -%}
{%- set start_date = "(select MIN(cast(orderdate as date)) from sales.salesorderheader)" -%}
{%- set end_date = "(select MAX(cast(orderdate as date)) + (interval '1 day') from sales.salesorderheader)" -%}

with as_of_date AS (
    {{ dbt_utils.date_spine(
        datepart=datepart, 
        start_date=start_date,
        end_date=end_date
       ) 
    }}
)

SELECT * FROM as_of_date