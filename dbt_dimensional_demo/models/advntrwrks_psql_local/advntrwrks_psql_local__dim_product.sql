
with src_production_product as (
    select * from {{ source('psql_local', 'product') }}
),

final_tbl as (
    select * from src_production_product
) 

select * from final_tbl

--SELECT * FROM production.product