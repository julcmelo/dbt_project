SELECT
    *
FROM
    {{ref('joins_rw1')}}
WHERE
    date_part(year, order_date) = 2020