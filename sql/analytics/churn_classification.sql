WITH user_last_activity AS (
    SELECT
        user_id,
        MAX(event_time) AS last_event_time
    FROM events
    GROUP BY user_id
),
user_inactivity AS (
    SELECT
        user_id,
        CURRENT_DATE - DATE(last_event_time) AS days_since_last_activity
    FROM user_last_activity
)
SELECT
    CASE
        WHEN days_since_last_activity < 7 THEN 'active'
        WHEN days_since_last_activity < 14 THEN 'soft_churn'
        WHEN days_since_last_activity < 30 THEN 'churned'
        ELSE 'hard_churn'
    END AS churn_status,
    COUNT(*) AS users
FROM user_inactivity
GROUP BY churn_status
ORDER BY
    CASE churn_status
        WHEN 'active' THEN 1
        WHEN 'soft_churn' THEN 2
        WHEN 'churned' THEN 3
        WHEN 'hard_churn' THEN 4
    END;