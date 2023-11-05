{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM
    {{source_data('raw_data', 'categories')}}