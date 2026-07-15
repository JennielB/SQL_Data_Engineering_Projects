SELECT 
    table_name,
    column_name,
    data_type
FROM information_schema.columns 
WHERE table_name = 'job_postings_fact'; 
/*using information_schema.columns
 get the schema of the columns*/

SELECT CAST('123' AS INTEGER); 
-- casting string to int
    
SELECT 
    CAST(job_id AS VARCHAR)||'-'||CAST(company_id AS VARCHAR) AS combined_id,
    --Conatinated together strings with a '-' in the middle
    CAST(job_work_from_home AS INT) AS job_wfh_int, -- from boolean to numeric value
    CAST(job_posted_date AS DATE) AS job_pd_date, -- from timestamp to date only
    CAST(salary_year_avg AS DECIMAL(10,0)) --from double to no demical places,
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 
    25;


-- Replacing 'CAST()' with the the oporator '::'
SELECT 
    job_id::VARCHAR||'-'||company_id::VARCHAR AS combined_id,
    job_work_from_home :: INT AS job_wfh_int, 
    job_posted_date :: DATE AS job_pd_date, 
    salary_year_avg :: DECIMAL(10,0) 
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 
    25;
