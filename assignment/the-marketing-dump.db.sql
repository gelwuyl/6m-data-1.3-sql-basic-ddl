 
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
