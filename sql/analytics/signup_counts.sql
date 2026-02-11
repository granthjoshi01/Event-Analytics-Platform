SELECT
    DATE(event_time) AS signup_date,
    COUNT(*) AS signups
FROM events
WHERE event_name = 'user_signed_up'
GROUP BY DATE(event_time)
ORDER BY signup_date;