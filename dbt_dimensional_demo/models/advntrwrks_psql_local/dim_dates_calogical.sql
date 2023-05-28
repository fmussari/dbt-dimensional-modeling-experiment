{{ config(materialized='table') }}
{{ config(schema='Dimensions') }}


{%- call statement('get_dates', fetch_result=True) -%}

      SELECT  MIN(cast(orderdate as date)), MAX(cast(orderdate as date)) + (interval '1 day')
      FROM {{ source('pg_sales', 'salesorderheader') }}

{%- endcall -%}


{%- set earliest = load_result('get_dates')['data'][0][0] -%}
{%- set latest = load_result('get_dates')['data'][0][1] -%}


{{ dbt_date.get_date_dimension(
        start_date=earliest, 
        end_date=latest
    ) 
}}