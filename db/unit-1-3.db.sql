-- create schema

CREATE SCHEMA IF NOT EXISTS lesson;

-- create a table inside schema lesson. start with 'schema name' first, then 'table name'

CREATE TABLE lesson.users (uid INTEGER, name VARCHAR, email VARCHAR);

-- insert multiple data into TABLE

INSERT INTO
lesson.users (uid, name, email)
VALUES
    (1, 'John Doe', 'john.doe@gmail.com'),
    (2, 'Jane Doe', 'jane.doe@gmail.com'),
    (3, 'John Smith', 'john.smith@gmail.com');

-- alter table users

alter table lesson.users add column start_date date;
 
-- view results of table
select*from lesson.users;
  
 -- rename column
 
alter table lesson.users rename id to uid;

-- truncate TABLE -- removes all rows, keeps table structure

truncate table lesson.users;


-- Creating Tables with Constraints

CREATE TABLE lesson.teachers(
id integer primary key,                             -- unique and not null
name varchar not null,
age integer check (age > 18 and age < 70),
address varchar,
phone varchar,
email varchar check (contains(email,'@')),
);

CREATE TABLE lesson.classes (
  id INTEGER PRIMARY KEY,                           -- primary key
  name VARCHAR NOT NULL,                            -- not null
  teacher_id INTEGER REFERENCES lesson.teachers(id)  -- foreign key
);


CREATE TABLE lesson.students (
    id INTEGER PRIMARY KEY,
    name VARCHAR,
    address varchar,
    phone varchar,
    email VARCHAR check (contains(email,'@')),
    class_id INTEGER REFERENCES lesson.classes(id)
);

-- This resets the connection so you can start a new transaction. error from <TransactionContext Error: Current transaction is aborted (please ROLLBACK) error occurs because a previous SQL command in your current transaction block failed.>
rollback


-- part 3

copy lesson.teachers FROM '/Users/gel/Library/CloudStorage/OneDrive-Personal/Attachments/[NTU PACE-SCTP] 2026.04.04-2026.08.29 Advanced Professional Certificate in Data Science and AI/6m-data-1.3-sql-basic-ddl/data/teachers.csv' (auto_detect true);

copy lesson.classes FROM '/Users/gel/Library/CloudStorage/OneDrive-Personal/Attachments/[NTU PACE-SCTP] 2026.04.04-2026.08.29 Advanced Professional Certificate in Data Science and AI/6m-data-1.3-sql-basic-ddl/data/classes.csv' (auto_detect true);

copy lesson.students FROM '/Users/gel/Library/CloudStorage/OneDrive-Personal/Attachments/[NTU PACE-SCTP] 2026.04.04-2026.08.29 Advanced Professional Certificate in Data Science and AI/6m-data-1.3-sql-basic-ddl/data/students.csv' (auto_detect true);


-- UPDATE lesson.students

UPDATE lesson.students
SET email = 'linda.g@example.com', WHERE id = 4;



-- Activity 4: Index, Table & View
-- Create a unique index on the name column of teachers
CREATE UNIQUE INDEX teachers_name_idx ON lesson.teachers(name);

-- Create a non-unique index on the name column of students
CREATE INDEX students_name_idx ON lesson.students(name);


-- View indexes for teachers table
SELECT index_name, sql
FROM duckdb_indexes,
WHERE table_name = 'teachers';

-- View indexes for students table
SELECT index_name, sql
FROM duckdb_indexes,
WHERE table_name = 'students';


-- CREATE VIEW for teachers table
CREATE VIEW lesson.teachers_view AS
FROM lesson.teachers;

-- CREATE view for students TABLE
CREATE VIEW lesson.students_view AS
SELECT id, name, email
FROM lesson.students;


