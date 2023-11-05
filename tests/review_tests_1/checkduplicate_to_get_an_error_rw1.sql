SELECT
    count(*) AS count_register,
    company_name,
    contact_name
FROM
    {{source_data_rw1('raw_data', 'customers')}}
GROUP BY
    company_name,
    contact_name
HAVING
    count_register > 1