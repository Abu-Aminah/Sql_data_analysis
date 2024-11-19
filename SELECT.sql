SELECT
    AVG(salary_year_avg) AS yearly_avg,
    AVG(salary_hour_avg) AS hourly_avg,
    job_schedule_type
FROM
    job_postings_fact
WHERE
    job_posted_date >= '2023-06-01'
GROUP BY
    job_schedule_type
LIMIT 10;