CREATE DATABASE customer_analysis;
USE customer_analysis;
select * from customers limit 10;

# Churn Rate
SELECT churn,
       COUNT(*) AS total_customers,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers), 2) AS percentage
FROM customers
GROUP BY churn;

# Insight: A significant portion of customers have churned, indicating a clear retention issue that needs targeted intervention.

# Churn vs Recency
SELECT recency_group, churn, COUNT(*) AS count
FROM customers
GROUP BY recency_group, churn
ORDER BY recency_group;

# Insight: Customers in “Lost” and “Very Lost” categories show the highest churn rates, proving that customer inactivity is the strongest predictor of churn.

# Spending Behavior vs Churn
SELECT churn,
       AVG(total_spend) AS avg_spend,
       AVG(total_orders) AS avg_orders
FROM customers
GROUP BY churn;

# Insight: Churned customers have lower average spend and fewer orders, indicating that low engagement directly leads to higher churn

# High Value Customers vs Churn

SELECT high_value_customer, churn, COUNT(*) AS count
FROM customers
GROUP BY high_value_customer, churn;

# Insight: High-value customers are less likely to churn, showing that customers with higher spending are more loyal and valuable to the business.

# Region-wise Churn

SELECT region, churn, COUNT(*) AS count
FROM customers
GROUP BY region, churn
ORDER BY region;

# Insight: Churn varies across regions, indicating that location-specific factors (service, delivery, or engagement) may influence customer retention.

# RFM Segmentation

SELECT RFM_score, COUNT(*) AS customers
FROM customers
GROUP BY RFM_score
ORDER BY customers DESC;

# Insight: A large portion of customers fall into mid-to-low RFM segments, suggesting a significant number of customers are at risk of churn and need engagement strategies.

# Revenue from active vs churned customers

SELECT 
    churn,
    SUM(total_spend) AS total_revenue
FROM customers
GROUP BY churn;

# Insight: A substantial portion of total revenue comes from churned customers, highlighting a direct financial impact of customer attrition

# Top 10 Customers by Spend

SELECT customer_id, total_spend
FROM customers
ORDER BY total_spend DESC
LIMIT 10;

# Insight: A small group of customers contributes significantly to revenue, indicating the importance of retaining high-value customers through loyalty programs.

# Customers likely to churn

SELECT *
FROM customers
WHERE recency_group IN ('Lost', 'Very Lost')
AND churn = 'Yes';

# Insight: Customers who are inactive for long periods are highly likely to churn, making them the primary target for re-engagement campaigns.
