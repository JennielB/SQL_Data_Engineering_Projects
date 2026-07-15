--.read Lessons/1.21_DDL_DML_Pt1.sql 
--this file Drops and Creates from scratch each time without errors. 


/* Creating a dropping databases just to get it down,
and utilizing the 'IF (NOT) EXISTS' codition.  
*/

USE data_jobs;

DROP DATABASE IF EXISTS jobs_mart;

CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

USE jobs_mart;

/*
Creating and dropping Schema as show bellow.
*/
SELECT
    *
FROM information_schema.schemata
WHERE catalog_name = 'jobs_mart';

CREATE SCHEMA IF NOT EXISTS staging;

--DROP SCHEMA IF EXISTS staging;

/*
Creating and dropping tables. 
*/

CREATE TABLE IF NOT EXISTS staging.preffered_roles(
    role_id INT PRIMARY KEY,
    role_name VARCHAR
)
;

--DROP TABLE IF EXISTS main.preffered_roles;

SELECT 
    *
FROM information_schema.tables
WHERE 
    table_catalog = 'jobs_mart'
;

/*
INSERT INTO practice.
*/

INSERT INTO staging.preffered_roles(role_id, role_name)
VALUES 
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3,'Software Engineer')
;

SELECT 
    *
FROM staging.preffered_roles
;


ALTER TABLE staging.preffered_roles
ADD COLUMN prefered_role BOOLEAN ;

/*
ALTER TABLE staging.preffered_roles
DROP COLUMN prefered_role;
*/

