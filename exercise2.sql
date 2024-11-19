SELECT
    COUNT(job_id) AS job_posted_count,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'AMERICA/NEW_YORK' AS date_time,
   EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_posted_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
    month
ORDER BY
    month;