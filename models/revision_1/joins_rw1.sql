-- Joins Model
WITH source_products AS (
    SELECT
        *
    FROM
        {{source('sources', 'products')}}

), source_suppliers AS (
    SELECT
        *
    FROM
        {{source('sources', 'suppliers')}}

), source_categories AS (
    SELECT
        *
    FROM
        {{source('sources', 'categories')}}
	
), source_shippers AS (
    SELECT
        *
    FROM
        {{source('sources', 'shippers')}}

), source_orders AS (
    SELECT
        *
    FROM
        {{source('sources', 'orders')}}

), ref_order_details AS (
    SELECT
        *
    FROM
        {{ref('order_details_rw1')}}

), ref_customers AS (
    SELECT
        *
    FROM
        {{ref('customers_rw1')}}

), ref_employees AS (
    SELECT
        *
    FROM
        {{ref('employees_rw1')}}

), products AS (
    SELECT
        ctg.category_name,
        spp.company_name AS suppliers,
        prd.product_name,
        prd.unit_price,
        prd.product_id
    FROM
        source_products AS prd
    LEFT JOIN
        source_suppliers AS spp
    ON
        prd.supplier_id = spp.supplier_id
    LEFT JOIN
        source_categories as ctg
    ON
        prd.category_id = ctg.category_id

), order_details AS (
    SELECT
        prd.*,
        od.order_id,
        od.quantity,
        od.discount
    FROM
        ref_order_details AS od
    LEFT JOIN
        products AS prd
    ON
        od.product_id = prd.product_id

), orders AS (
    SELECT
        ord.order_date,
        ord.order_id,
        cst.company_name AS customer,
        emp.name AS employee,
        emp.age,
        emp.length_of_service
    FROM
        source_orders AS ord 
    LEFT JOIN
        ref_customers AS cst
    ON
        ord.customer_id = cst.customer_id
    LEFT JOIN 
        ref_employees AS emp
    ON
        ord.employee_id = emp.employee_id
    LEFT JOIN
        source_shippers AS shp
    ON
        ord.ship_via = shp.shipper_id

), final_join AS (
    SELECT
        orddt.*,
        ord.order_date,
        ord.customer,
        ord.employee,
        ord.age,
        ord.length_of_service
    FROM
        order_details AS orddt
    INNER JOIN
        orders AS ord
    ON
        orddt.order_id = ord.order_id
)

SELECT
    *
FROM
    final_join