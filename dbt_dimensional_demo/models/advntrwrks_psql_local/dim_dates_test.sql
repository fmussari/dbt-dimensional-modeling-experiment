

{%- call statement('my_statement', fetch_result=True) -%}
      SELECT MIN(cast(orderdate as date)) FROM {{ source('pg_sales', 'salesorderheader') }}
{%- endcall -%}

{%- set my_var = load_result('my_statement')['data'][0][0] -%}

SELECT {{ load_result('my_statement')['data'][0][0] }}  AS x