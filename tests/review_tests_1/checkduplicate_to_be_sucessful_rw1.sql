SELECT
    count(*) AS count_register,
    company_name,
    contact_name
FROM
    {{ref('customers_rw1')}}
GROUP BY
    company_name,
    contact_name
HAVING
    count_register > 1
    