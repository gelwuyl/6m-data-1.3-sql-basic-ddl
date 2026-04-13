import duckdb
import os


# Remove existing database file if it exists (to ensure a fresh start)
db_path = "assignment/the-marketing-dump.db"
if os.path.exists(db_path):
    os.remove(db_path)

con = duckdb.connect(db_path)


# Define the SQL script content
sql_script = """ 
-- SQL script for the-marketing-dump database
CREATE SCHEMA IF NOT EXISTS marketing;

-- Add staging table creation statements here
CREATE TABLE IF NOT EXISTS marketing.leads (
    id INTEGER PRIMARY KEY,
    full_name VARCHAR(255),
    contact_info VARCHAR(255),
    signup_date DATE
);

-- import the data from the CSV file into the leads table
COPY marketing.leads FROM 'data/leads_raw.csv' (FORMAT CSV, HEADER);
-- create the view to clean the data
CREATE OR REPLACE VIEW marketing.cleaned_leads AS
SELECT
    id,
    TRIM(full_name) AS full_name,
    TRIM(contact_info) AS email, -- Assuming contact_info contains email addresses
    signup_date
FROM marketing.leads
WHERE contact_info LIKE '%@%'; -- Basic filter to ensure contact_info looks like an email address
"""


# Create the SQL file
sql_file_path = "assignment/the-marketing-dump.db.sql"
with open(sql_file_path, "w") as f:
    f.write(sql_script)
print(f"SQL file created: {sql_file_path}")


# Read the SQL script from file
with open(sql_file_path, "r") as f:
    sql_script = f.read()


con.execute(sql_script)
con.close()
print("Database created successfully!")