WITH markup AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY company_name, contact_name ORDER BY company_name) AS row_num
    FROM 
        {{source('sources', 'customers')}}

), removed_duplicate AS (
    SELECT
        DISTINCT
            company_name,
            contact_name
    FROM
        markup

), final_version AS (
    SELECT
        mp.*
    FROM
        markup as mp
    INNER JOIN 
        removed_duplicate as rd 
    ON 
        mp.company_name = rd.company_name
        AND mp.contact_name = rd.contact_name
)

SELECT
    *
FROM
    final_version
WHERE 
    row_num = 1
