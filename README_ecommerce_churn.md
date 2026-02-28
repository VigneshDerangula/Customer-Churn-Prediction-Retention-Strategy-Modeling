# 🛍️ E-commerce Customer Churn Prediction & Retention Strategy Modeling

**RFM Analysis • Cohort Retention • LTV Modeling • SQL + Python
Integration**

------------------------------------------------------------------------

## 🚀 Executive Summary

This project simulates a real-world **Product & Growth Analytics churn
use case** using transaction-level e-commerce data.

Instead of relying on a pre-labeled churn dataset, churn is
strategically defined as:

> **A customer is considered churned if no purchase occurs within 90
> days of the snapshot date.**

The objective is to model customer behavior, quantify revenue-at-risk,
and support data-driven retention strategy decisions using both SQL and
Python.

------------------------------------------------------------------------

## 🎯 Business Objectives

-   Define churn using behavioral inactivity logic
-   Engineer RFM (Recency, Frequency, Monetary) features
-   Perform cohort-based retention analysis
-   Estimate Customer Lifetime Value (LTV proxy)
-   Train a churn prediction model
-   Validate SQL outputs against Python calculations

------------------------------------------------------------------------

## 📊 Key Insights & Findings

### 1️⃣ Churn Behavior Patterns

-   Customers with **high recency (long inactivity)** show significantly
    higher churn probability.
-   Low-frequency buyers churn at disproportionately higher rates.
-   Heavy discount users exhibit moderately elevated churn risk,
    indicating price sensitivity.

### 2️⃣ Revenue Concentration

-   Top \~20% of customers contribute a disproportionately large share
    of total revenue (Pareto effect).
-   High-monetary customers show stronger retention behavior compared to
    bargain segments.

### 3️⃣ Cohort Retention Trends

-   Early-month retention drop is steepest within the first 2--3 months
    post-acquisition.
-   Customers acquired through higher-engagement channels show better
    long-term retention.
-   Retention stabilizes after month 6 for loyal segments.

### 4️⃣ Lifetime Value Insights

-   Active lifetime varies significantly across customer segments.
-   Higher ARPU customers maintain longer purchase cycles.
-   Revenue-at-risk estimation highlights priority segments for
    retention campaigns.

### 5️⃣ Predictive Modeling Performance

-   Random Forest classifier successfully identifies churn risk using
    behavioral features.
-   Top predictive drivers include:
    -   Recency (days since last purchase)
    -   Purchase frequency
    -   Monetary value
    -   Category diversity
-   Model demonstrates strong classification performance and business
    interpretability.

------------------------------------------------------------------------

## 🛠 Technical Architecture

### Data Layer

-   Transaction-level dataset (synthetic but realistic)
-   Customer reference table

### SQL Layer

-   RFM aggregation queries
-   Cohort retention analysis
-   LTV proxy computation
-   Churn labeling logic
-   SQL ↔ Python metric reconciliation

### Python Layer

-   Feature engineering (RFM + behavioral features)
-   Cohort modeling
-   Retention visualization (Matplotlib)
-   Random Forest churn prediction model
-   Confusion matrix & feature importance analysis

------------------------------------------------------------------------

## 📁 Repository Structure

data/ - ecommerce_transactions.csv - customers.csv - DATA_DICTIONARY.md

sql/ - analysis.sql

notebooks/ - ecommerce_churn_rfm_sql_python.ipynb

scripts/ - load_to_sqlite.py

------------------------------------------------------------------------

## 🔍 Skills Demonstrated

-   Product & Growth Analytics Thinking
-   Behavioral Customer Modeling
-   Revenue-at-Risk Quantification
-   Cohort Retention Analysis
-   Lifetime Value Estimation
-   End-to-End SQL + Python Validation
-   Business-Oriented Machine Learning

------------------------------------------------------------------------

## 🧠 Ideal For Roles In

-   Product Analytics
-   Growth Analytics
-   Revenue Strategy
-   Data Science
-   Business Intelligence
-   Customer Strategy

------------------------------------------------------------------------

## 📌 Conclusion

This project demonstrates how analytics teams move beyond simple churn
classification and instead:

-   Define churn strategically
-   Quantify revenue exposure
-   Analyze retention dynamics
-   Support targeted intervention strategies
-   Align SQL and Python metrics for analytical consistency

It bridges business thinking with technical execution --- replicating a
real-world growth analytics workflow.

------------------------------------------------------------------------
