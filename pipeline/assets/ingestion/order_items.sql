/* @bruin

name: raw.order_items
type: duckdb.sql

materialization:
    type: table

@bruin */

SELECT 
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
FROM read_csv_auto('data/olist_order_items_dataset.csv', header=true)