WITH signup_users AS (
    SELECT
        user_id,
        DATE(MIN(event_time)) AS signup_date
    FROM events
    WHERE event_name = 'user_signed_up'
    GROUP BY user_id
),
day1_activity AS (
    SELECT DISTINCT
        e.user_id
    FROM events e
    JOIN signup_users s
      ON e.user_id = s.user_id
     AND DATE(e.event_time) = s.signup_date + INTERVAL '1 day'
)
SELECT
    COUNT(DISTINCT s.user_id) AS signup_users,
    COUNT(DISTINCT d.user_id) AS users_active_on_day_1
FROM signup_users s
LEFT JOIN day1_activity d
  ON s.user_id = d.user_id;