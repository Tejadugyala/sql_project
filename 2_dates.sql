select job_title_short as title,
job_location as location,
job_posted_date::date as date from job_postings_fact
limit 5;


select job_title_short as title,
job_location as location,
job_posted_date at time zone 'UTC' at time zone 'EST' as date time 
from job_postings_fact
limit 5;


select job_title_short as title,
job_location as location,
job_posted_date at time zone 'UTC' at time zone 'EST' as date_time ,
extract(MONTH from job_posted_date) as date_month,
EXTRACT(YEAR from job_posted_date) as date_year
from job_postings_fact
limit 5;


select 
    count(job_id) as job_posted_count,
    extract(MONTH from job_posted_date) as month
from 
    job_postings_fact
where
    job_title_short='Data Analyst'
GROUP BY
    month
Order BY 
job_posted_count DESC;