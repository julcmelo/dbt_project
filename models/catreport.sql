{{
    config(
        materialized='incremental',
        unique_key='category_id'
    )
}}

SELECT
    *
FROM 
    {{source('sources', 'categories')}}