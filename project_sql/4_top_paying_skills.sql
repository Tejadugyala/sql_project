/*
Question: What are the top skills based on salary?
- Look for the average salary associated with each skill for Data Analyst positions
-Focuses on roles with specified salaries, regardless of location
-Why? It reveals how different skills impact salary levels for Data Analyst and helps identigy the most financially rewarding skills to acquire.
*/

select 
    skills,
    round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
where 
    job_title_short='Data Analyst' AND
    salary_year_avg is NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
limit 25