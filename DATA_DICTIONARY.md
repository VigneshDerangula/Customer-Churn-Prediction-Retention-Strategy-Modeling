# Data Dictionary

## ecommerce_transactions.csv
Synthetic transactional dataset designed for churn + retention modeling (RFM, cohorts, LTV).

- **transaction_id**: unique order id
- **customer_id**: customer key
- **order_date**: order date (YYYY-MM-DD)
- **gross_value**: pre-discount order value
- **items**: number of items in the order
- **channel**: Web / App / Store
- **category**: product category
- **discount_pct**: applied discount percentage (0–40)
- **region**: North / South / East / West
- **payment_method**: Card / UPI / Wallet / COD
- **net_value**: revenue after discount (gross_value * (1 - discount_pct))
- **customer_segment**: Value / Regular / Bargain (hidden driver used for realism)

## customers.csv
Customer reference table (also synthetic).

- **customer_id**
- **segment**: Value / Regular / Bargain
- **first_purchase_date**
- **last_purchase_date**
- **signup_channel**
- **region**
- **age_band**

## Snapshot date used for churn labeling
- **snapshot_date**: `2025-01-01`
- **churn definition (this project)**: customer is churned if `days_since_last_purchase > 90` as of snapshot_date.
