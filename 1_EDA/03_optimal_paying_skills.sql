/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/



SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT(jpf.salary_year_avg) AS corrected_demand_count,
    ROUND(LN(COUNT(jpf.salary_year_avg)),1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.salary_year_avg))) / 1_000_000,3) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sd.skill_id = sjd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL 
GROUP BY 
    sd.skills
HAVING  COUNT(jpf.*) > 100
ORDER BY 
    optimal_score DESC
LIMIT 25
;

/*
After filtering out 'salary_year_avg' that are left NULL, we have the 'corrected_demand_count'
which shows a demand count of jobs with salaries associated with them. I createed a multiplier
column which takes the natural log of the demand count multiplied by the median salary and
divided by 1,000,000 to recieve an optimal score. 

Key takaways:
-Terraform is now the top skill as its median salary regardless of its low demand count. 
-Python, AWS, and SQL return to the top of the list since their demand count pushes them up
regardless of a lower median salary.
-Kafka shows a similar trend to Terraform where deman cound might be lower but its median 
salary pushes it higher on the list.
-Azure is high in demand but its salary keeps it from being higher on the list. 

┌────────────┬───────────────┬────────────────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ corrected_demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │         int64          │     double      │    double     │
├────────────┼───────────────┼────────────────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │                    193 │             5.3 │         0.968 │
│ python     │      135000.0 │                   1133 │             7.0 │         0.949 │
│ aws        │      137320.0 │                    783 │             6.7 │         0.915 │
│ sql        │      130000.0 │                   1128 │             7.0 │         0.914 │
│ airflow    │      150000.0 │                    386 │             6.0 │         0.893 │
│ spark      │      140000.0 │                    503 │             6.2 │         0.871 │
│ snowflake  │      135500.0 │                    438 │             6.1 │         0.824 │
│ kafka      │      145000.0 │                    292 │             5.7 │         0.823 │
│ azure      │      128000.0 │                    475 │             6.2 │         0.789 │
│ java       │      135000.0 │                    303 │             5.7 │         0.771 │
│ scala      │      137290.0 │                    247 │             5.5 │         0.756 │
│ kubernetes │      150500.0 │                    147 │             5.0 │         0.751 │
│ git        │      140000.0 │                    208 │             5.3 │         0.747 │
│ databricks │      132750.0 │                    266 │             5.6 │         0.741 │
│ redshift   │      130000.0 │                    274 │             5.6 │          0.73 │
│ gcp        │      136000.0 │                    196 │             5.3 │         0.718 │
│ hadoop     │      135000.0 │                    198 │             5.3 │         0.714 │
│ nosql      │      134415.0 │                    193 │             5.3 │         0.707 │
│ pyspark    │      140000.0 │                    152 │             5.0 │         0.703 │
│ docker     │      135000.0 │                    144 │             5.0 │         0.671 │
│ mongodb    │      135750.0 │                    136 │             4.9 │         0.667 │
│ go         │      140000.0 │                    113 │             4.7 │         0.662 │
│ r          │      134775.0 │                    133 │             4.9 │         0.659 │
│ github     │      135000.0 │                    127 │             4.8 │         0.654 │
│ bigquery   │      135000.0 │                    123 │             4.8 │          0.65 │
└────────────┴───────────────┴────────────────────────┴─────────────────┴───────────────┘
  25 rows                                                                     5 columns
*/