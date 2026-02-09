WITH signup_users AS (
    SELECT
        user_id,
        MIN(event_time) AS signup_time
    FROM events
    WHERE event_name = 'user_signed_up'
    GROUP BY user_id
),
post_signup_activity AS (
    SELECT DISTINCT
        e.user_id
    FROM events e
    JOIN signup_users s
      ON e.user_id = s.user_id
     AND e.event_time > s.signup_time
)
SELECT
    COUNT(DISTINCT s.user_id) AS signup_users,
    COUNT(DISTINCT p.user_id) AS users_with_post_signup_activity
FROM signup_users s
LEFT JOIN post_signup_activity p
  ON s.user_id = p.user_id;