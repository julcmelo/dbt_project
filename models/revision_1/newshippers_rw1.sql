SELECT
    shp.company_name,
    shpem.shipper_email
FROM
    {{source_data('raw_data', 'shippers')}} AS shp
LEFT JOIN
    {{ref('shippers_emails_rw1')}} AS shpem
ON
    shp.shipper_id = shpem.shipper_id