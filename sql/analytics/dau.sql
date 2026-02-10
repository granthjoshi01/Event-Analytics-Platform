SELECT
    DATE(event_time) AS event_date,
    COUNT(DISTINCT user_id) AS dau
FROM events
GROUP BY DATE(event_time)
ORDER BY event_date;