SELECT
    {{field_return()}}
FROM
    {{ref('joins')}}
WHERE
    category_name = {{var('category')}}