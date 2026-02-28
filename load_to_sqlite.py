import os
import sqlite3
import pandas as pd

TX_CSV = os.path.join('data', 'ecommerce_transactions.csv')
CUST_CSV = os.path.join('data', 'customers.csv')
DB_PATH = os.path.join('data', 'ecommerce_churn.db')

def main():
    if not os.path.exists(TX_CSV) or not os.path.exists(CUST_CSV):
        raise FileNotFoundError("Missing data files. Ensure data/ecommerce_transactions.csv and data/customers.csv exist.")

    tx = pd.read_csv(TX_CSV)
    cust = pd.read_csv(CUST_CSV)

    con = sqlite3.connect(DB_PATH)
    tx.to_sql('transactions', con, if_exists='replace', index=False)
    cust.to_sql('customers', con, if_exists='replace', index=False)
    con.close()

    print(f"Loaded transactions={len(tx):,} and customers={len(cust):,} into {DB_PATH}")

if __name__ == '__main__':
    main()
