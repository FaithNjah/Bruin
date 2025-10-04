/* @bruin

name: raw.customers
type: duckdb.sql

materialization:
    type: table

@bruin */

SELECT 
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM read_csv_auto('data/olist_customers_dataset.csv', header=true)