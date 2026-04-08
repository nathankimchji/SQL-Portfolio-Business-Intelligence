/* 
PROJECT: Saas Subscription & Churn Analysis
GOAL: Identify customer segments and monthly revenue growth.
SQL SKILL: CTEs, Window Functions (SUM OVER), and Aggregations.
*/

-- CTE 1: Creating raw 'Subscriptions' data
WITH raw_subscriptions AS (
  SELECT 1 as sub_id, '2026-01-01'::date as start_date, 100 as customer_id, 50
  UNION ALL SELECT 2, '2026-01-05'::date, 101, 50, 'Active'
  UNION ALL SELECT 3, '2026-01-06'::date, 102, 150, 'Churned'
  UNION ALL SELECT 4, '2026-02-01'::date, 103, 50, 'Active'
  UNION ALL SELECT 5, '2026-02-10'::date, 104, 150, 'Active'
),

-- CTE 2: Calculating Monthly Revenue Growth using a Window Functino
monthly_revenue AS (
  SELECT
    DATE_TRUNC('month', start_date) as report_month,
    SUM(monthly_amount) as revenue
  FROM raw_subscriptions
  GROUP BY 1
)
