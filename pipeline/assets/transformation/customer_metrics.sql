/* @bruin

name: analytics.customer_metrics
type: duckdb.sql

materialization:
    type: table

depends:
    - raw.customers
    - raw.orders
    - raw.order_items

columns:
    - name: customer_id
      type: varchar
      description: "Unique customer identifier"
      checks:
          - name: not_null
          - name: unique
    
    - name: total_orders
      type: integer
      description: "Total number of orders placed by customer"
      checks:
          - name: not_null
          - name: positive
    
    - name: total_spent
      type: decimal
      description: "Total amount spent by customer"
      checks:
          - name: not_null

@bruin */

SELECT 
    c.customer_id,
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id) as total_orders,
    COUNT(DISTINCT oi.product_id) as unique_products_purchased,
    COALESCE(SUM(oi.price), 0) as total_spent,
    COALESCE(AVG(oi.price), 0) as avg_order_value,
    MIN(o.order_purchase_timestamp) as first_order_date,
    MAX(o.order_purchase_timestamp) as last_order_date
FROM raw.customers c
LEFT JOIN raw.orders o ON c.customer_id = o.customer_id
LEFT JOIN raw.order_items oi ON o.order_id = oi.order_id
WHERE o.order_id IS NOT NULL
GROUP BY c.customer_id, c.customer_city, c.customer_state
ORDER BY total_spent DESC