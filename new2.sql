SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;


SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_job;


WITH january_jobs AS(
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;



SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
FROM
        job_postings_fact
WHERE
        job_no_degree_mention = true
        ORDER BY company_id
);




WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
FROM
        job_postings_fact
GROUP BY
        company_id
)

SELECT 
        company_dim.name AS company_name,
        company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC


WITH skills_jobs_count AS (
        SELECT 
                skill_id,
                COUNT(*) AS total_postings
        FROM skills_job_dim
        GROUP BY skill_id
)
SELECT 
        skills_dim.skills,
        skills_jobs_count.total_postings
FROM skills_dim
LEFT JOIN skills_jobs_count ON skills_jobs_count.skill_id = skills_dim.skill_id
ORDER BY total_postings DESC



WITH company_size AS (
    SELECT 
        COUNT(*) AS company_cat,
        company_id
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT 
        company_cat,

    CASE
        WHEN company_cat <= 10 THEN 'small_size'
        WHEN company_cat BETWEEN 11 AND 50 THEN 'medium_size'
        ELSE 'large_size'
    END AS company_group
FROM company_size
ORDER BY company_cat DESC;


WITH remote_job_skills AS (
SELECT 
       
        skill_id,
        COUNT(*) AS skills_count
FROM
        skills_job_dim AS skills_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_job.job_id
WHERE job_postings.job_work_from_home = True AND
        job_postings.job_title_short = 'Data Analyst'
GROUP BY skill_id
)

SELECT 
        skill.skill_id,
        skills AS skill_name,
        skills_count
FROM remote_job_skills
INNER JOIN skills_dim AS skill ON skill.skill_id = remote_job_skills.skill_id
ORDER BY skills_count DESC
;


SELECT

    EXTRACT(QUARTER FROM job_posted_date) AS quarter
    
FROM
    job_postings_fact AS jobs

WHERE
    EXTRACT(QUARTER FROM job_posted_date) = 1

UNION ALL

SELECT *
FROM skills_dim
    ;