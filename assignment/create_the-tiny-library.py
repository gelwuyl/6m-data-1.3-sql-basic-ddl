import duckdb
import os

# Remove existing database file if it exists (to ensure a fresh start)
db_path = "assignment/the-tiny-library.db"
if os.path.exists(db_path):
    os.remove(db_path)

con = duckdb.connect(db_path)


# Define the SQL script content
sql_script = """ 
-- SQL script for the-tiny-library database
CREATE SCHEMA IF NOT EXISTS library;
-- 1. Books (The Inventory)
CREATE TABLE library.books (
    isbn VARCHAR(13) PRIMARY KEY,       -- ISBN is a natural unique identifier
    title VARCHAR NOT NULL,
    author VARCHAR NOT NULL,
    published_year INTEGER
);
-- 2. Members (The Users)
CREATE TABLE library.members (
    member_id INTEGER PRIMARY KEY,
    full_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE,               -- Ensures no two members share an email
    join_date DATE
);
-- 3. Loans (The Transaction/Link Table)
CREATE TABLE library.loans (
    loan_id INTEGER PRIMARY KEY,
    loan_date DATE NOT NULL,
    return_date DATE,                   -- Can be NULL (currently borrowed)
    book_isbn VARCHAR(13) REFERENCES library.books(isbn),
    member_id INTEGER REFERENCES library.members(member_id)
);
"""


# Create the SQL file
sql_file_path = "assignment/the-tiny-library.db.sql"
with open(sql_file_path, "w") as f:
    f.write(sql_script)
print(f"SQL file created: {sql_file_path}")


# Read the SQL script from file
with open("assignment/the-tiny-library.db.sql", "r") as f:
    sql_script = f.read()


con.execute(sql_script)
con.close()
print("Database created successfully!")