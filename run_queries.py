import sqlite3

# Connect to database
conn = sqlite3.connect("life_expectancy.db")
cursor = conn.cursor()

# Read SQL file
with open("sql/week1_queries.sql", "r", encoding="utf-8") as file:
    sql_script = file.read()

# Remove comments
lines = []
for line in sql_script.splitlines():
    if not line.strip().startswith("--"):
        lines.append(line)

sql_script = "\n".join(lines)

# Run each query
queries = [q.strip() for q in sql_script.split(";") if q.strip()]

for i, query in enumerate(queries, 1):
    print("\n" + "=" * 60)
    print(f"QUERY {i} RESULT")
    print("=" * 60)

    try:
        cursor.execute(query)
        rows = cursor.fetchall()

        for row in rows:
            print(row)

    except Exception as e:
        print("ERROR:", e)

conn.close()

print("\nAll queries completed.")