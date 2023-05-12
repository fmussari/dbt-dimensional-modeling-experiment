
with as_of_date AS ( 
    with rawdata as (
        with p as (
            select 0 as generated_number union all select 1
        ), unioned as (

        select
            p0.generated_number * power(2, 0)
            + 
            p1.generated_number * power(2, 1)
            + 
            p2.generated_number * power(2, 2)
            + 
            p3.generated_number * power(2, 3)
            + 
            p4.generated_number * power(2, 4)
            + 
            p5.generated_number * power(2, 5)
            + 
            p6.generated_number * power(2, 6)
            + 1
            as generated_number
        from
            p as p0
            cross join 
            p as p1
            cross join 
            p as p2
            cross join 
            p as p3
            cross join 
            p as p4
            cross join 
            p as p5
            cross join 
            p as p6
        )
        select *
        from unioned
        where generated_number <= 90
        order by generated_number
    ),
    all_periods as (
        select (
            TO_DATE('2021/01/01', 'yyyy/mm/dd') + ((interval '1 day') * (row_number() over (order by 1) - 1))
        ) as date_day
        from rawdata
    ),
    filtered as (
        select *
        from all_periods
        where date_day <= TO_DATE('2021/04/01', 'yyyy/mm/dd')
    )
    select * from filtered
)

SELECT DATE_day as AS_OF_DATE FROM as_of_date