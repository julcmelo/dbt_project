{{
    config(
        materialized='incremental',
        unique_key='category_id'
    )
}}

SELECT
    *
FROM
    {{soure_data_rw1('raw_data', 'categories')}}