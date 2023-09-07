WITH source_connection AS (
    SELECT
        *
    FROM
        {{source('sources', 'customers')}}

), markup AS (
    SELECT
        *,
        FIRST_VALUE(customer_id) OVER (
                                        PARTITION BY company_name, contact_name 
                                        ORDER BY company_name
                                        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS result
    FROM
        source_connection
        
), removed_duplicate AS (
    SELECT 
        DISTINCT 
            result
    FROM
        markup

), final_version AS (
    SELECT 
        *
    FROM
        source_connection
    WHERE
        customer_id in (SELECT
                            result
                        FROM
                            removed_duplicate)
)

SELECT
    *
FROM
    final_version