import pandas as pd
import sqlite3

# CSV file path
csv_file = "data/life_expectancy_raw.csv"

# SQLite database path
db_file = "life_expectancy.db"

# Read CSV
df = pd.read_csv(csv_file)

# Clean column names
df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")

# Connect to SQLite database
conn = sqlite3.connect(db_file)

# Load data into SQLite
df.to_sql(
    "life_expectancy_data",
    conn,
    if_exists="replace",
    index=False
)

# Verify number of rows
cursor = conn.cursor()
cursor.execute("SELECT COUNT(*) FROM life_expectancy_data")
count = cursor.fetchone()[0]

print(f"Data loaded successfully! Total rows: {count}")

# Close connection
conn.close()