# Exploritory Data Analysis w/ SQL: Job Market Analysis  

![Project 1 Overview](..\Images\1_1_Project1_EDA.png)  

A SQL data project that explores the job market for Data Engineers, this project is to demonstrate my ability to **write production-ready analytical SQL, create efficient queries, and turn buisness questions into data driven insight.**  

## Executive Summary  
- **Project Scope:** Build 3 SQL queries to determine the skills required for Data Engineering based on **Demand, Pay, and Optimizing for both** variables. 
- **Data Moodeling:** Used **multi-table joins** across fact and demension tables to access relevent data for buisness insight.
- **Analytics:** Applied **aggregations, filtering, and sorting** to discover top skills based on demand, salary, and overall value.
- **Outcomes:** Delivered **acctionable conclusions** regarding Python/SQL predominance, cloud technologies on the rise, and salary paterns.   

Queries:  
[`01_top_demanded_skills`](../1_EDA/01_top_demanded_skills.sql) - Demand analysis with multi-table joins  
[`02_top_paying_skills`](..\1_EDA\02_top_paying_skills.sql) - Salary analysis with aggregations  
[`03_optimal_paying_skills`](..\1_EDA\03_optimal_paying_skills.sql) - Combined demand/salary optimization query  

## Problem and Context  

Part of what a Job Market analyst does is:  
- **Track Skills:** determine which skills are most in demand, which are loosing relevence  
and which are gaining popularity.  
- **Track Pay:** determine what the job market values skills and roles across regions, work  
environments and industries. 
- **Influence Priorities:** assisting desicion makers in determining the appropriate skills  
balanced with pay.  

This project utilizes a **Data Warehouse** of real jobs for the analysis, the warehouse is  
built using a star schema, the ERD is shown bellow:  
![Entity Relationship Diagram](..\Images\1_2_Data_Warehouse.png)


## Tech Stack  

- **Query Engine:** DuckDB (OLAP) and MotherDuck UI.
- **Languages:** SQL
- **Data Model:** Star schema with fact, dimension and bridge tables.
- **Development:** VScode for SQL editing and Terminal for DuckDB CLI.
- **Version Control:** Git/GitHub for versioned SQL scripts.  

## Analysis Overview

### Queries  

1. **[`TOP DEMANDED SKILLS`](..\1_EDA\01_top_demanded_skills.sql):** Here I answer: *What are the most in demand skills for Data Engineers?* by joining the `job_postings_fact` table witht the `skills_dim` table using the `skills_job_dim` as a bridge.    

2. **[`TOP PAYING SKILLS`](..\1_EDA\02_top_paying_skills.sql):** Here I answer: *What are the highest paying skills for Data Engineers?* by alteing the querie used previously to pull `salary_year_avg` while maintinging demand count to compare.

3. **[`OPTIMAL PAYING SKILLS`](..\1_EDA\03_optimal_paying_skills.sql):** Here I take the results of both queries (Demand and Pay) and create a multiplier to balance pay and demand, multiply them together and receive an optimal score for each skill. 

**Key Insights:**  
1. Here I find the the top languages are **1)SQL and 2)Python**. The top cloud technologies are **3)AWS and 4)Azure**, and top tools are **5)Apache Spark and 6)AirFlow**. 

2. I find that **1)Rust and 2)Golang** command the highets median salaries among Languages. But in the top 25 of the list **3)Terraform, 17)Airflow, and 20)Kubernetes** command the strongest demand count, **Terraform** being the 3rd overall skill described in the series shows it is both high paying and highly demanded.

3. The results show **1)Terraform** still topping the list but **4)SQL and 2)Python** re-appearing thanks to their enormous demand count. The table results also show the corrected demand count and median salary to show what numbers are used in the final optimal score. 



## SQL Skills Demonstrated  
### Query Design and Optimization:
- **Joins:** Multi_table `INNER JOIN` across `job_postings_fact`, `skills_job_dim`, and `skills_dim`. 

- **Agregations:** `COUNT()`, `MEDIAN()`, and `ROUND()` used for statistical analysis.

- **Filtering:** Boolean logic with `WHERE` clauses and muitiple condition such as (`job_work_from_home`, `salary_year_avg IS NOT NULL`, etc.) 

- **Sorting and Limiting:** `ORDER BY` with `DESC` and `LIMIT` for top-N analysis. 

### Data Analysis Techniques:

- **Grouping:** `GROUP BY` for catagorical skill analysis.

- **Conditional Logic:** `CASE WHEN` statments for derived metrics.

- **Mathamatical Functions:**`LN()` for natural Log transormation to normalize demand metrics.

- **Caluculated Metics:** Derived optimal score combinbing log_transformed demand with Median Salary.

- **HAVING Clauses:** Filtering agregated results.

- **NUll Handeling:** Proper filtering for incomplete records (`
jpf.salary_year_avg IS NOT NULL
`) 