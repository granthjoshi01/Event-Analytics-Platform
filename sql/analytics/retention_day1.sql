WITH signup_users AS (
    SELECT
        user_id,
        DATE(MIN(event_time)) AS signup_date
    FROM events
    WHERE event_name = 'user_signed_up'
    GROUP BY user_id
),
activity AS (
    SELECT DISTINCT
        user_id,
        DATE(event_time) AS activity_date
    FROM events
)
SELECT
    s.signup_date,
    COUNT(DISTINCT s.user_id) AS cohort_size,
    COUNT(DISTINCT a.user_id) AS day_1_retained
FROM signup_users s
LEFT JOIN activity a
  ON s.user_id = a.user_id
 AND a.activity_date = s.signup_date + INTERVAL '1 day'
GROUP BY s.signup_date
ORDER BY s.signup_date;