{{ config(materialized='table') }}
{{ config(schema='Dimensions') }}

with src_product as (
    select * 
    from {{ source('pg_production', 'product') }}
),

src_product_subcategory as (
    select *
    from {{ source('pg_production', 'productsubcategory') }}
),

src_product_category as (
    select *
    from {{ source('pg_production', 'productcategory') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['src_product.productid']) }} as product_key,
    src_product.productid,
    src_product.name as product_name,
    src_product.productnumber,
    src_product.color,
    src_product.class,
    src_product_subcategory.name as product_subcategory_name,
    src_product_category.name as product_category_name
from src_product
left join src_product_subcategory 
    on src_product.productsubcategoryid = src_product_subcategory.productsubcategoryid
left join src_product_category 
    on src_product_subcategory.productcategoryid = src_product_category.productcategoryid