# E-commerce Analytics Pipeline with Bruin

A complete data pipeline built with Bruin that demonstrates data ingestion, transformation, and quality checks using real e-commerce data.

## What This Project Does

This pipeline analyzes Brazilian e-commerce data to provide insights on:
- Customer purchasing behavior and lifetime value
- Product performance and revenue analysis
- Order patterns and trends

##  Pipeline Overview

**Data Flow:**
- Raw Data (CSV) → Ingestion → Transformation → Analytics

**Assets:**
- 4 Ingestion assets (customers, orders, products, order_items)
- 2 Transformation assets (customer_metrics, product_performance)
- 5 Data quality checks

##  Quick Start (5 minutes)

### Prerequisites
- [Bruin CLI](https://github.com/bruin-data/bruin) installed
- Python 3.8+ with DuckDB

### Installation

1. **Clone this repository:**
```bash
git clone <your-repo-url>
cd Bruin_Project
```

Run the pipeline:
```bash
bruin run pipeline/
```


### Project Structure
```bash
Bruin_Project/
├── .bruin.yml                  # Bruin configuration
├── pipeline/
│   ├── pipeline.yml            # Pipeline definition
│   └── assets/
│       ├── ingestion/          # Raw data loading
│       │   ├── customers.sql
│       │   ├── orders.sql
│       │   ├── products.sql
│       │   └── order_items.sql
│       └── transformation/     # Business logic
│           ├── customer_metrics.sql
│           └── product_performance.sql
├── data/                       # Source CSV files
└── docs/                       # Documentation
```

### Key Features Demonstrated
1. Simple Data Ingestion
Using DuckDB's native CSV reading:

```bash
SELECT * FROM read_csv_auto('data/customers.csv', header=true)
```

2. Dependency Management
Bruin automatically runs assets in the correct order:
```bash
depends:
    - raw.customers
    - raw.orders
```
3. Data Quality Checks
Built-in validation:
```bash
columns:
    - name: customer_id
      checks:
          - name: not_null
          - name: unique
```

4. Business Metrics
Calculate customer lifetime value, product performance, and more!

### About the Data
This project uses the Brazilian E-Commerce Public Dataset from Kaggle, which contains real anonymized data from 100k orders.
