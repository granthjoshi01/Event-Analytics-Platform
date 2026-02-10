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
),
retention AS (
    SELECT
        s.signup_date,
        (a.activity_date - s.signup_date) AS days_since_signup,
        COUNT(DISTINCT a.user_id) AS active_users
    FROM signup_users s
    JOIN activity a
      ON s.user_id = a.user_id
     AND a.activity_date >= s.signup_date
    GROUP BY s.signup_date, days_since_signup
)
SELECT
    signup_date,
    days_since_signup,
    active_users
FROM retention
ORDER BY signup_date, days_since_signup;