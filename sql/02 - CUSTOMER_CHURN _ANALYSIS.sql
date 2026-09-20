/*
==========================================================
02 - CUSTOMER CHURN ANALYSIS
==========================================================

Business Problem:
Which customer groups are associated with higher
customer churn?

This analysis supports:
- Executive Overview
- Customer Churn Demographics
==========================================================
*/


-- ========================================================
-- 1. Overall Customer Churn
-- ========================================================
-- Business Question:
-- How many customers have churned and what is the
-- overall churn rate?

SELECT
    COUNT(*) AS Total_Customers,

    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,

    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Retained_Customers,

    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent

FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> '';


-- ========================================================
-- ========================================================
-- 2. Churn by Contract Type
-- ========================================================
SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(Churn = 'Yes') AS Churned_Customers,
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2) AS Churn_Rate_Percent
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY Contract
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 3. Churn by Tenure Group
-- ========================================================
-- ========================================================
-- 3. Churn by Tenure Group (Fixed for ONLY_FULL_GROUP_BY)
-- ========================================================
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49-72 Months'
    END AS Tenure_Group,
    
    COUNT(*) AS Total_Customers,
    SUM(Churn = 'Yes') AS Churned_Customers,
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2) AS Churn_Rate_Percent
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY Tenure_Group
ORDER BY MIN(tenure);


-- ========================================================
-- 4. Churn by Customer Demographics
-- ========================================================
-- Gender  impact
SELECT 
    'Gender' AS Demographic_Factor, 
    gender AS Category, 
    COUNT(*) AS Total_Customers,
    SUM(Churn = 'Yes') AS Churned_Customers,
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2) AS Churn_Rate_Percent
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY gender

UNION ALL

-- 
SELECT 
    'Senior Citizen', 
    CASE WHEN SeniorCitizen = 1 THEN 'Yes' ELSE 'No' END,
    COUNT(*),
    SUM(Churn = 'Yes'),
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2)
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY SeniorCitizen

UNION ALL

-- impact on Partner 
SELECT 
    'Partner', 
    Partner, 
    COUNT(*),
    SUM(Churn = 'Yes'),
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2)
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY Partner

UNION ALL

-- Impact on Dependents 
SELECT 
    'Dependents', 
    Dependents, 
    COUNT(*),
    SUM(Churn = 'Yes'),
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2)
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY Dependents

ORDER BY Demographic_Factor, Churn_Rate_Percent DESC;


-- ========================================================
-- 5. Average Tenure by Churn Status
-- ========================================================
SELECT
    Churn,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(tenure), 2) AS Average_Tenure_Months
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY Churn;
