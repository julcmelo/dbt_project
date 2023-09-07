-- Order_details Model
WITH products AS (
    SELECT
        *
    FROM
        {{source('sources', 'products')}}

), order_details AS (
    SELECT
        *
    FROM
        {{source('sources', 'order_details')}}
)

SELECT
    od.order_id,
    od.product_id,
    od.unit_price,
    od.quantity,
    prd.product_name,
    prd.supplier_id,
    prd.category_id,
    (od.unit_price * od.quantity) AS total,
    ((prd.unit_price * od.quantity) - total) AS discount
FROM
    order_details AS od 
LEFT JOIN 
    products AS prd 
ON 
    od.product_id = prd.product_id