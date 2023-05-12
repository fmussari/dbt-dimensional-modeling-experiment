
{%- call statement('get_dates', fetch_result=True) -%}

      SELECT  MIN(cast(orderdate as date)), MAX(cast(orderdate as date)) 
      FROM {{ source('pg_sales', 'salesorderheader') }}

{%- endcall -%}

{%- set earliest = load_result('get_dates')['data'][0][0] -%}
{%- set latest = load_result('get_dates')['data'][0][1] -%}

SELECT cast('{{ earliest }}' as date) AS earliest, cast('{{ latest }}' as date) AS latest