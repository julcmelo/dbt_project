-- standard config
{{
    config(
        materialized='view'
    )
}}

SELECT
    *
FROM
    {{source_data_rw1('raw_data', 'categories')}}