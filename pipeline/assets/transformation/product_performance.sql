/* @bruin

name: analytics.product_performance
type: duckdb.sql

materialization:
    type: table

depends:
    - raw.products
    - raw.order_items

@bruin */

SELECT 
    p.product_id,
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) as times_ordered,
    COUNT(oi.order_item_id) as total_items_sold,
    SUM(oi.price) as total_revenue,
    AVG(oi.price) as avg_item_price,
    SUM(oi.freight_value) as total_shipping_cost,
    ROUND(SUM(oi.price) / COUNT(DISTINCT oi.order_id), 2) as revenue_per_order
FROM raw.products p
LEFT JOIN raw.order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_category_name
HAVING COUNT(oi.order_item_id) > 0
ORDER BY total_revenue DESC