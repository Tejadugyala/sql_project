/*
Question: What are the most optimal skills to learn
-Identify skills in high demand and associated with high average salaries for data analyst roles
-Concentrates on remote positions with sepcified salaries
-Why? Targets skills that offer job security and financial benefits, offering strategic insights for career development in data analysis
*/
WITH skills_demand AS(
    select 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    from job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    where 
        job_title_short='Data Analyst' AND
        salary_year_avg is NOT NULL AND
        job_work_from_home ='TRUE'
    GROUP BY
        skills_dim.skill_id

),
average_salary AS (
    select
        skills_job_dim.skill_id, 
        round(avg(salary_year_avg),0) as avg_salary
    from job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    where 
        job_title_short='Data Analyst' AND
        salary_year_avg is NOT NULL
    GROUP BY
        skills_job_dim.skill_id

)
select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from skills_demand
INNER join average_salary on skills_demand.skill_id=average_salary.skill_id
WHERE   
    demand_count>10
ORDER BY
    avg_salary DESC,
    demand_count DESC
limit 25

