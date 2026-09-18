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

    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) AS Churned_Customers,

    SUM(CASE
        WHEN Churn = 'No' THEN 1
        ELSE 0
    END) AS Retained_Customers,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent

FROM CustomerChurn
WHERE TRY_CAST(NULLIF(LTRIM(RTRIM(TotalCharges)), '') AS DECIMAL(18,2))
      IS NOT NULL;


-- ========================================================
-- 2. Churn by Contract Type
-- ========================================================
-- Business Question:
-- Which contract types have higher observed churn?

SELECT
    Contract,
    COUNT(*) AS Total_Customers,

    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) AS Churned_Customers,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent

FROM CustomerChurn
WHERE TRY_CAST(NULLIF(LTRIM(RTRIM(TotalCharges)), '') AS DECIMAL(18,2))
      IS NOT NULL

GROUP BY Contract
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 3. Churn by Tenure Group
-- ========================================================
-- Business Question:
-- Are newer customers showing different churn rates
-- compared with longer-tenure customers?

SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49-72 Months'
    END AS Tenure_Group,

    COUNT(*) AS Total_Customers,

    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) AS Churned_Customers,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent

FROM CustomerChurn
WHERE TRY_CAST(NULLIF(LTRIM(RTRIM(TotalCharges)), '') AS DECIMAL(18,2))
      IS NOT NULL

GROUP BY
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49-72 Months'
    END

ORDER BY
    CASE
        WHEN tenure <= 12 THEN 1
        WHEN tenure <= 24 THEN 2
        WHEN tenure <= 48 THEN 3
        ELSE 4
    END;


-- ========================================================
-- 4. Churn by Customer Demographics
-- ========================================================
-- Business Question:
-- How does churn differ across gender, senior citizen,
-- partner and dependent status?

SELECT
    gender,
    SeniorCitizen,
    Partner,
    Dependents,

    COUNT(*) AS Total_Customers,

    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) AS Churned_Customers,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent

FROM CustomerChurn
WHERE TRY_CAST(NULLIF(LTRIM(RTRIM(TotalCharges)), '') AS DECIMAL(18,2))
      IS NOT NULL

GROUP BY
    gender,
    SeniorCitizen,
    Partner,
    Dependents

ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 5. Average Tenure by Churn Status
-- ========================================================
-- Business Question:
-- Do churned customers have different average tenure
-- compared with retained customers?

SELECT
    Churn,
    COUNT(*) AS Customer_Count,

    ROUND(
        AVG(CAST(tenure AS DECIMAL(10,2))),
        2
    ) AS Average_Tenure_Months

FROM CustomerChurn
WHERE TRY_CAST(NULLIF(LTRIM(RTRIM(TotalCharges)), '') AS DECIMAL(18,2))
      IS NOT NULL

GROUP BY Churn;