/*
What are the highest paying skills for data engineers?
-Calculate the median salary for each skill required in data engineering postions
-Focus on remote positions with specified salaries
-Include skill frequency to identify both salary and demand
-Why? Helps idnetify which skills command the highest compensation while also showing
    how common thos skills are, providing a more coplete picture for skill development priorities
*/


SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sd.skill_id = sjd.skill_id
WHERE 
    job_title_short = 'Data Engineer'
    AND job_work_from_home = TRUE
GROUP BY 
    sd.skills
HAVING  COUNT(jpf.*) > 100
ORDER BY 
    median_salary DESC
LIMIT 25
;

/*
Here we see the resutls of our query written above and we find that Rust has the highest median
salary (210000) in the data set with a demand count above 100. That being said we also see that
it is not the most demanded skill in our top 25 list. That belongs to Airflow with a demand count
of 9996 and a respectable salary of 150000. Other skills that strike a balance between high demand
and high salary are Golang, Terraform, Ruby, Kubernetes, and Airflow. 

Key Takeaways:
-Rust commands the highest median salary (210000) in the data set while not being very in demand.
-Airflow, Kubernetes, and terraform are the most indemand from this data set all making above 
150000.
-Crystal, Node and VMware all barley make the list due to demand count and are outside of the top
10 of the list.



┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ atlassian  │      151500.0 │          249 │
│ c          │      151500.0 │          444 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ ruby       │      150000.0 │          736 │
│ node       │      150000.0 │          179 │
│ airflow    │      150000.0 │         9996 │
│ css        │      150000.0 │          262 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
*/