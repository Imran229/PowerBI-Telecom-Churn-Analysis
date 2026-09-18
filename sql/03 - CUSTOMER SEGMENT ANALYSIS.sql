/*
==========================================================
03 - CUSTOMER SEGMENT ANALYSIS
==========================================================

Business Problem:
Which telecom services and payment methods are associated
with higher observed customer churn?

This analysis supports:
- Service-Based Churn Analysis
==========================================================
*/


-- ========================================================
-- 1. Churn by Internet Service
-- ========================================================
-- Business Question:
-- Which internet-service groups have higher observed churn?

SELECT
    InternetService,
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

GROUP BY InternetService
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 2. Churn by Online Security
-- ========================================================
-- Business Question:
-- Do customers with and without Online Security
-- show different churn rates?

SELECT
    OnlineSecurity,
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

GROUP BY OnlineSecurity
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 3. Churn by Tech Support
-- ========================================================
-- Business Question:
-- Do customers with and without Tech Support
-- show different churn rates?

SELECT
    TechSupport,
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

GROUP BY TechSupport
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 4. Churn by Payment Method
-- ========================================================
-- Business Question:
-- Which payment methods are associated with higher
-- observed customer churn?

SELECT
    PaymentMethod,
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

GROUP BY PaymentMethod
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 5. Churn by Admin Ticket Volume
-- ========================================================
-- Business Question:
-- Does the number of administrative tickets relate to
-- different observed churn rates?

SELECT
    numAdminTickets,
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

GROUP BY numAdminTickets
ORDER BY numAdminTickets;