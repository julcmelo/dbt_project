-- Customers Model
with source_connection AS (
    SELECT
        *
    FROM
        {{source_data('raw_data', 'customers')}}

), markup AS (
    SELECT
        *,
        FIRST_VALUE(customer_id) OVER (
                                        PARTITION BY company_name, contact_name
                                        ORDER BY company_name
                                        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS result
    FROM
        source_connection

), remove_duplicate(
    SELECT
        DISTINCT
            result
    FROM
        markup

), final_version(
    SELECT
        *
    FROM
        source_connection
    WHERE
        customer_id in (SELECT
                            result
                        FROM
                            remove_duplicate)
)

SELECT
    *
FROM
    final_version