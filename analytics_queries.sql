SELECT DISTINCT country FROM Users;

SELECT COUNT(*) AS active_subscriptions_count 
FROM Subscriptions 
WHERE status = 'Active';

SELECT user_id, name, email 
FROM Users 
WHERE referral_source = 'Referral';

SELECT plan_name, monthly_price 
FROM Plans 
WHERE monthly_price > 10.00;

SELECT user_id, plan_id, start_date, end_date 
FROM Subscriptions 
WHERE status = 'Cancelled';

SELECT MAX(minutes_streamed) AS max_minutes, AVG(minutes_streamed) AS avg_minutes 
FROM Usage_Logs;

SELECT COUNT(*) AS tv_streaming_sessions 
FROM Usage_Logs 
WHERE device_type = 'Smart TV';

SELECT SUM(p.monthly_price) AS total_monthly_mrr
FROM Subscriptions s
JOIN Plans p ON s.plan_id = p.plan_id
WHERE s.status = 'Active';

SELECT u.country, SUM(p.monthly_price) AS total_revenue
FROM Users u
JOIN Subscriptions s ON u.user_id = s.user_id
JOIN Plans p ON s.plan_id = p.plan_id
WHERE s.status = 'Active'
GROUP BY u.country
ORDER BY total_revenue DESC;

SELECT device_type, SUM(minutes_streamed) AS total_mins
FROM Usage_Logs
GROUP BY device_type
ORDER BY total_mins DESC;

SELECT u.country, AVG(l.minutes_streamed) AS avg_session_time
FROM Users u
JOIN Usage_Logs l ON u.user_id = l.user_id
WHERE u.country = 'United States'
GROUP BY u.country;

SELECT p.plan_name, COUNT(s.sub_id) AS total_subscribers
FROM Plans p
LEFT JOIN Subscriptions s ON p.plan_id = s.plan_id
GROUP BY p.plan_name;

SELECT country, COUNT(user_id) AS user_count
FROM Users
GROUP BY country
HAVING COUNT(user_id) > 5;

SELECT u.user_id, u.name, SUM(l.minutes_streamed) AS cumulative_minutes
FROM Users u
JOIN Usage_Logs l ON u.user_id = l.user_id
GROUP BY u.user_id, u.name
ORDER BY cumulative_minutes DESC
LIMIT 5;

SELECT user_id, name, email 
FROM Users 
WHERE user_id NOT IN (SELECT DISTINCT user_id FROM Subscriptions);

SELECT u.referral_source, COUNT(u.user_id) AS active_premium_users
FROM Users u
JOIN Subscriptions s ON u.user_id = s.user_id
WHERE s.plan_id = 3 AND s.status = 'Active'
GROUP BY u.referral_source;

SELECT AVG(end_date - start_date) AS avg_days_before_churn
FROM Subscriptions
WHERE status = 'Cancelled';

SELECT u.user_id, u.name, u.country, SUM(l.minutes_streamed) AS total_mins,
       DENSE_RANK() OVER (PARTITION BY u.country ORDER BY SUM(l.minutes_streamed) DESC) AS rank_in_country
FROM Users u
JOIN Usage_Logs l ON u.user_id = l.user_id
GROUP BY u.user_id, u.name, u.country;

SELECT signup_date, COUNT(user_id) AS daily_signups,
       SUM(COUNT(user_id)) OVER (ORDER BY signup_date) AS running_total_users
FROM Users
GROUP BY signup_date;

WITH HeavyStreamers AS (
    SELECT user_id, SUM(minutes_streamed) AS total_time
    FROM Usage_Logs
    GROUP BY user_id
    HAVING SUM(minutes_streamed) > 300
)
SELECT h.user_id, h.total_time, p.plan_name
FROM HeavyStreamers h
JOIN Subscriptions s ON h.user_id = s.user_id
JOIN Plans p ON s.plan_id = p.plan_id
WHERE p.plan_name = 'Basic' AND s.status = 'Active';

SELECT u.user_id, u.name, COALESCE(SUM(l.minutes_streamed), 0) AS total_watched,
       CASE 
           WHEN SUM(l.minutes_streamed) >= 500 THEN 'Binge Watcher'
           WHEN SUM(l.minutes_streamed) BETWEEN 150 AND 499 THEN 'Regular Streamer'
           ELSE 'Low Engagement'
       END AS user_segment
FROM Users u
LEFT JOIN Usage_Logs l ON u.user_id = l.user_id
GROUP BY u.user_id, u.name;

SELECT COUNT(*) AS total_subscriptions,
       SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_subscriptions,
       ROUND((SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100, 2) AS churn_rate_percentage
FROM Subscriptions;

SELECT ROUND(SUM(p.monthly_price) / COUNT(DISTINCT s.user_id), 2) AS arpu
FROM Subscriptions s
JOIN Plans p ON s.plan_id = p.plan_id
WHERE s.status = 'Active';

SELECT DISTINCT u.user_id, u.name
FROM Users u
JOIN Usage_Logs l ON u.user_id = l.user_id
WHERE l.minutes_streamed > (SELECT AVG(minutes_streamed) FROM Usage_Logs);

SELECT DISTINCT user_id 
FROM Usage_Logs 
WHERE device_type = 'Mobile'
INTERSECT
SELECT DISTINCT user_id 
FROM Usage_Logs 
WHERE device_type = 'Smart TV';