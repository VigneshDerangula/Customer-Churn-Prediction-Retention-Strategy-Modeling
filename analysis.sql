-- E-commerce Churn (Retail Proxy): SQL analysis (SQLite-compatible)
-- Tables:
--   transactions (from ecommerce_transactions.csv)
--   customers (from customers.csv)
--
-- Snapshot date for churn labeling: 2025-01-01
-- Churn definition: days_since_last_purchase > 90

-- 0) Sanity checks
SELECT COUNT(*) AS txn_count FROM transactions;
SELECT COUNT(DISTINCT customer_id) AS customer_count FROM transactions;

-- 1) Revenue overview
SELECT
  ROUND(SUM(net_value), 2) AS total_revenue,
  ROUND(AVG(net_value), 2) AS avg_order_value,
  ROUND(SUM(net_value) / COUNT(DISTINCT customer_id), 2) AS revenue_per_customer
FROM transactions;

-- 2) Build RFM table (as-of snapshot_date)
WITH last_txn AS (
  SELECT
    customer_id,
    MAX(date(order_date)) AS last_order_date,
    MIN(date(order_date)) AS first_order_date,
    COUNT(*) AS frequency,
    ROUND(SUM(net_value), 2) AS monetary
  FROM transactions
  GROUP BY customer_id
),
rfm AS (
  SELECT
    customer_id,
    CAST(julianday(date('2025-01-01')) - julianday(last_order_date) AS INT) AS recency_days,
    frequency,
    monetary
  FROM last_txn
),
labeled AS (
  SELECT
    *,
    CASE WHEN recency_days > 90 THEN 1 ELSE 0 END AS churn_flag
  FROM rfm
)
SELECT
  COUNT(*) AS customers,
  ROUND(AVG(recency_days), 2) AS avg_recency_days,
  ROUND(AVG(frequency), 2) AS avg_frequency,
  ROUND(AVG(monetary), 2) AS avg_monetary,
  ROUND(100.0 * AVG(churn_flag), 2) AS churn_rate_pct
FROM labeled;

-- 3) Churn rate by channel (based on customer's most recent order channel)
WITH last_order AS (
  SELECT t.*
  FROM transactions t
  JOIN (
    SELECT customer_id, MAX(date(order_date)) AS last_order_date
    FROM transactions
    GROUP BY customer_id
  ) x
  ON t.customer_id = x.customer_id AND date(t.order_date) = x.last_order_date
),
rfm AS (
  SELECT
    customer_id,
    CAST(julianday(date('2025-01-01')) - julianday(MAX(date(order_date))) AS INT) AS recency_days
  FROM transactions
  GROUP BY customer_id
),
labeled AS (
  SELECT customer_id, CASE WHEN recency_days > 90 THEN 1 ELSE 0 END AS churn_flag
  FROM rfm
)
SELECT
  lo.channel,
  COUNT(DISTINCT lo.customer_id) AS customers,
  ROUND(100.0 * AVG(l.churn_flag), 2) AS churn_rate_pct
FROM last_order lo
JOIN labeled l ON l.customer_id = lo.customer_id
GROUP BY lo.channel
ORDER BY churn_rate_pct DESC;

-- 4) Cohort retention (monthly cohorts by first purchase month)
WITH firsts AS (
  SELECT customer_id, MIN(date(order_date)) AS first_date
  FROM transactions
  GROUP BY customer_id
),
cohorts AS (
  SELECT customer_id, strftime('%Y-%m', first_date) AS cohort_month
  FROM firsts
),
activity AS (
  SELECT
    t.customer_id,
    strftime('%Y-%m', date(t.order_date)) AS activity_month
  FROM transactions t
  GROUP BY t.customer_id, strftime('%Y-%m', date(t.order_date))
),
cohort_activity AS (
  SELECT
    c.cohort_month,
    a.activity_month,
    COUNT(DISTINCT a.customer_id) AS active_customers
  FROM cohorts c
  JOIN activity a ON a.customer_id = c.customer_id
  GROUP BY c.cohort_month, a.activity_month
),
cohort_sizes AS (
  SELECT cohort_month, COUNT(*) AS cohort_size
  FROM cohorts
  GROUP BY cohort_month
)
SELECT
  ca.cohort_month,
  ca.activity_month,
  cs.cohort_size,
  ca.active_customers,
  ROUND(100.0 * ca.active_customers / cs.cohort_size, 2) AS retention_pct
FROM cohort_activity ca
JOIN cohort_sizes cs USING (cohort_month)
ORDER BY ca.cohort_month, ca.activity_month;

-- 5) Simple LTV proxy (ARPU * avg active months by cohort)
WITH first_last AS (
  SELECT
    customer_id,
    MIN(date(order_date)) AS first_date,
    MAX(date(order_date)) AS last_date,
    ROUND(SUM(net_value), 2) AS revenue
  FROM transactions
  GROUP BY customer_id
),
cohorts AS (
  SELECT customer_id, strftime('%Y-%m', first_date) AS cohort_month
  FROM first_last
),
life AS (
  SELECT
    customer_id,
    CAST((julianday(last_date) - julianday(first_date)) / 30.0 AS REAL) AS active_months,
    revenue
  FROM first_last
)
SELECT
  c.cohort_month,
  COUNT(*) AS customers,
  ROUND(AVG(l.revenue), 2) AS avg_revenue_per_customer,
  ROUND(AVG(l.active_months), 2) AS avg_active_months,
  ROUND(AVG(l.revenue) / NULLIF(AVG(l.active_months), 0), 2) AS arpu_per_month,
  ROUND((AVG(l.revenue) / NULLIF(AVG(l.active_months), 0)) * AVG(l.active_months), 2) AS ltv_proxy
FROM cohorts c
JOIN life l USING (customer_id)
GROUP BY c.cohort_month
ORDER BY c.cohort_month;
