WITH signup_users AS (
    SELECT
        user_id,
        MIN(event_time) AS signup_time
    FROM events
    WHERE event_name = 'user_signed_up'
    GROUP BY user_id
),
returning_users AS (
    SELECT DISTINCT
        e.user_id
    FROM events e
    JOIN signup_users s
      ON e.user_id = s.user_id
     AND e.event_time > s.signup_time
)
SELECT
    COUNT(DISTINCT s.user_id) AS users_signed_up,
    COUNT(DISTINCT r.user_id) AS users_returned
FROM signup_users s
LEFT JOIN returning_users r
  ON s.user_id = r.user_id;