SELECT
    shp.company_name,
    shpem.shipper_email
FROM
    {{source('sources','shippers')}} AS shp
LEFT JOIN
    {{ref('shippers_emails')}} AS shpem
ON
    shp.shipper_id = shpem.shipper_id