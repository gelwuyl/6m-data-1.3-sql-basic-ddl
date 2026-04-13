 
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
