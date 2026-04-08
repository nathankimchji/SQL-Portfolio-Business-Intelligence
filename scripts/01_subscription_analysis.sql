/* 
PROJECT: SaaS Subscription & Churn Analysis
GOAL: Identify customer segments and monthly revenue growth.
SQL SKILLS: CTEs, Window Functions (SUM OVER), and Aggregations.
*/

-- CTE 1: Creating our raw 'Subscriptions' data
WITH raw_subscriptions AS (
    SELECT 1 as sub_id, '2025-01-01'::date as start_date, 100 as customer_id, 50 as monthly_amount, 'Active' as status
    UNION ALL SELECT 2, '2025-01-05'::date, 101, 50, 'Active'
    UNION ALL SELECT 3, '2025-01-15'::date, 102, 150, 'Churned'
    UNION ALL SELECT 4, '2025-02-01'::date, 103, 50, 'Active'
    UNION ALL SELECT 5, '2025-02-10'::date, 104, 150, 'Active'
),

-- CTE 2: Calculating Monthly Revenue Growth using a Window Function
monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', start_date) as report_month,
        SUM(monthly_amount) as revenue
    FROM raw_subscriptions
    GROUP BY 1
)

SELECT 
    report_month,
    revenue,
    -- PRO MOVE: This window function shows the "running total" revenue
    SUM(revenue) OVER (ORDER BY report_month) as running_total_revenue,
    -- This calculates the % growth from the previous month
    ROUND((revenue - LAG(revenue) OVER (ORDER BY report_month)) / LAG(revenue) OVER (ORDER BY report_month) * 100, 2) as pct_growth
FROM monthly_revenue;
