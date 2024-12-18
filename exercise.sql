SELECT jobs.job_id,
    skills_job.skill_id,
    job_posted_date AS dates,
    skills.skills,
    skills.type,
    job_title AS job,
    salary_year_avg >= 70000 AS salary,
    EXTRACT( QUARTER FROM job_posted_date ) AS quarter
FROM job_postings_fact AS jobs
    LEFT JOIN skills_job_dim AS skills_job ON jobs.job_id = skills_job.job_id
    LEFT JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE EXTRACT( QUARTER FROM job_posted_date) = 1

SELECT 
    salary_year_avg
    