SELECT
    *
FROM
    {{ref('joins')}}
WHERE
    category_name = '{{var('category')}}'