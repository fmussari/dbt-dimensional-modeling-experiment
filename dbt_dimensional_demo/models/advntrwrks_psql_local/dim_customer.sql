{{ config(materialized='table') }}
{{ config(schema='Dimensions') }}

with 
stg_customer as (
    select
        customerid,
        personid,
        storeid
    from {{ source('pg_sales', 'customer') }}
),

stg_person as (
    select
        businessentityid,
        concat(coalesce(firstname, ''), ' ', coalesce(middlename, ''), ' ', coalesce(lastname, '')) as fullname
    from {{ source('pg_person', 'person') }}
),

stg_store as (
    select
        businessentityid as storebusinessentityid,
        name as storename
    from {{ source('pg_sales', 'store') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['stg_customer.customerid']) }} as customer_key,
    stg_customer.customerid,
    stg_person.businessentityid,
    stg_person.fullname,
    stg_store.storebusinessentityid,
    stg_store.storename
from stg_customer
left join stg_person on stg_customer.personid = stg_person.businessentityid
left join stg_store on stg_customer.storeid = stg_store.storebusinessentityid