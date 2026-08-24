from urllib.parse import quote_plus
import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

# Load credentials from .env file
load_dotenv()



host = os.getenv("MYSQL_HOST")
user = os.getenv("MYSQL_USER")
password = os.getenv("MYSQL_PASSWORD")
database = os.getenv("MYSQL_DATABASE")

# Create SQLAlchemy engine (connection to MySQL)
encoded_password = quote_plus(password)
engine = create_engine(f"mysql+pymysql://{user}:{encoded_password}@{host}/{database}")

# Load CSVs
customers = pd.read_csv("data/raw/customers.csv")
products = pd.read_csv("data/raw/products.csv")
sales = pd.read_csv("data/raw/sales.csv")

# Push into MySQL tables (tables already exist from schema.sql, so we append)
customers.to_sql("customers", engine, if_exists="append", index=False)
print("Customers loaded:", len(customers))

products.to_sql("products", engine, if_exists="append", index=False)
print("Products loaded:", len(products))

sales.to_sql("sales", engine, if_exists="append", index=False)
print("Sales loaded:", len(sales))

print("All data loaded successfully.")