/*
==========================================================
04 - REVENUE IMPACT ANALYSIS
==========================================================

Business Problem:
How much historical revenue is associated with customer
churn, and which customer segments contribute to it?

This analysis supports:
- Revenue Impact Analysis
==========================================================
*/


-- ========================================================
-- 1. Overall Revenue and Churned Revenue
-- ========================================================
SELECT
    ROUND(SUM(CAST(TotalCharges AS DECIMAL(18,2))), 2) AS Total_Revenue,
    
    ROUND(SUM(CASE 
        WHEN Churn = 'Yes' THEN CAST(TotalCharges AS DECIMAL(18,2)) 
        ELSE 0 
    END), 2) AS Churned_Revenue,
    
    ROUND(100.0 * SUM(CASE 
        WHEN Churn = 'Yes' THEN CAST(TotalCharges AS DECIMAL(18,2)) 
        ELSE 0 
    END) / SUM(CAST(TotalCharges AS DECIMAL(18,2))), 2) AS Revenue_Loss_Percent

FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> '';


-- ========================================================
-- 2. Average Monthly Charges
-- ========================================================
SELECT
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charges
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> '';


-- ========================================================
-- 3. Revenue by Contract Type
-- ========================================================
SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(CAST(TotalCharges AS DECIMAL(18,2))), 2) AS Total_Revenue
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY Contract
ORDER BY Total_Revenue DESC;


-- ========================================================
-- 4. Revenue by Internet Service
-- ========================================================
SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(CAST(TotalCharges AS DECIMAL(18,2))), 2) AS Total_Revenue
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY InternetService
ORDER BY Total_Revenue DESC;
ORDER BY Total_Revenue DESC;


-- ========================================================
-- 5. Revenue Associated With Churn by Contract
-- ========================================================
SELECT
    Contract,
    COUNT(*) AS Churned_Customers,
    ROUND(SUM(CAST(TotalCharges AS DECIMAL(18,2))), 2) AS Churned_Revenue
FROM Telecom_customer_churn
WHERE Churn = 'Yes'
  AND TRIM(TotalCharges) <> ''
GROUP BY Contract
ORDER BY Churned_Revenue DESC;


-- ========================================================
-- 6. Revenue Associated With Churn by Internet Service
-- ========================================================
SELECT
    InternetService,
    COUNT(*) AS Churned_Customers,
    ROUND(SUM(CAST(TotalCharges AS DECIMAL(18,2))), 2) AS Churned_Revenue
FROM Telecom_customer_churn
WHERE Churn = 'Yes'
  AND TRIM(TotalCharges) <> ''
GROUP BY InternetService
ORDER BY Churned_Revenue DESC;
