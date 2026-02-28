# E-commerce Churn Prediction & Retention Strategy Modeling (RFM + Cohorts + LTV)

This project uses an **e-commerce transactional dataset** (retail churn proxy) to:
- Define **churn** using purchase inactivity
- Build **RFM features** (Recency, Frequency, Monetary)
- Create **cohort retention** views
- Estimate **LTV proxy**
- Train a baseline **churn prediction model**
- Validate that **SQL outputs match Python metrics** (in-sync)

## Dataset
Included in this repo (synthetic but realistic):
- `data/ecommerce_transactions.csv`
- `data/customers.csv`
- `data/DATA_DICTIONARY.md`

Snapshot date used for labeling: **2025-01-01**  
Churn definition: **days_since_last_purchase > 90**

## Quickstart
```bash
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
python scripts/load_to_sqlite.py
```

Open and run:
- `notebooks/ecommerce_churn_rfm_sql_python.ipynb`

## Repo structure
- `data/` dataset files + generated SQLite DB
- `sql/analysis.sql` SQL queries (SQLite-compatible)
- `scripts/load_to_sqlite.py` CSV → SQLite loader
- `notebooks/ecommerce_churn_rfm_sql_python.ipynb` full Python analysis + charts + SQL/Python sync checks

## GitHub upload
Unzip and run:
```bash
git init
git add .
git commit -m "E-commerce churn: RFM + cohorts + SQL/Python"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```
