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
-- Business Question:
-- How much total historical revenue is in the dataset,
-- and how much is associated with churned customers?

SELECT
    ROUND(
        SUM(
            TRY_CAST(NULLIF(LTRIM(RTRIM(TotalCharges)), '')
            AS DECIMAL(18,2))
        ), 2
    ) AS Total_Revenue,

    ROUND(
        SUM(
            CASE
                WHEN Churn = 'Yes'
                THEN TRY_CAST(
                    NULLIF(LTRIM(RTRIM(TotalCharges)), '')
                    AS DECIMAL(18,2)
                )
                ELSE 0
            END
        ), 2
    ) AS Churned_Revenue,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Churn = 'Yes'
                THEN TRY_CAST(
                    NULLIF(LTRIM(RTRIM(TotalCharges)), '')
                    AS DECIMAL(18,2)
                )
                ELSE 0
            END
        )
        /
        SUM(
            TRY_CAST(NULLIF(LTRIM(RTRIM(TotalCharges)), '')
            AS DECIMAL(18,2))
        ),
        2
    ) AS Revenue_Loss_Percent

FROM CustomerChurn

WHERE TRY_CAST(
    NULLIF(LTRIM(RTRIM(TotalCharges)), '')
    AS DECIMAL(18,2)
) IS NOT NULL;


-- ========================================================
-- 2. Average Monthly Charges
-- ========================================================
-- Business Question:
-- What is the average monthly charge across customers?

SELECT
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charges
FROM CustomerChurn

WHERE TRY_CAST(
    NULLIF(LTRIM(RTRIM(TotalCharges)), '')
    AS DECIMAL(18,2)
) IS NOT NULL;


-- ========================================================
-- 3. Revenue by Contract Type
-- ========================================================
-- Business Question:
-- Which contract types generate the most historical
-- customer revenue?

SELECT
    Contract,

    COUNT(*) AS Total_Customers,

    ROUND(
        SUM(
            TRY_CAST(
                NULLIF(LTRIM(RTRIM(TotalCharges)), '')
                AS DECIMAL(18,2)
            )
        ), 2
    ) AS Total_Revenue

FROM CustomerChurn

WHERE TRY_CAST(
    NULLIF(LTRIM(RTRIM(TotalCharges)), '')
    AS DECIMAL(18,2)
) IS NOT NULL

GROUP BY Contract
ORDER BY Total_Revenue DESC;


-- ========================================================
-- 4. Revenue by Internet Service
-- ========================================================
-- Business Question:
-- Which internet-service groups contribute the most
-- historical customer revenue?

SELECT
    InternetService,

    COUNT(*) AS Total_Customers,

    ROUND(
        SUM(
            TRY_CAST(
                NULLIF(LTRIM(RTRIM(TotalCharges)), '')
                AS DECIMAL(18,2)
            )
        ), 2
    ) AS Total_Revenue

FROM CustomerChurn

WHERE TRY_CAST(
    NULLIF(LTRIM(RTRIM(TotalCharges)), '')
    AS DECIMAL(18,2)
) IS NOT NULL

GROUP BY InternetService
ORDER BY Total_Revenue DESC;


-- ========================================================
-- 5. Revenue Associated With Churn by Contract
-- ========================================================
-- Business Question:
-- Which contract types have the greatest amount of
-- historical revenue associated with churned customers?

SELECT
    Contract,

    COUNT(*) AS Churned_Customers,

    ROUND(
        SUM(
            TRY_CAST(
                NULLIF(LTRIM(RTRIM(TotalCharges)), '')
                AS DECIMAL(18,2)
            )
        ), 2
    ) AS Churned_Revenue

FROM CustomerChurn

WHERE Churn = 'Yes'
  AND TRY_CAST(
        NULLIF(LTRIM(RTRIM(TotalCharges)), '')
        AS DECIMAL(18,2)
      ) IS NOT NULL

GROUP BY Contract
ORDER BY Churned_Revenue DESC;


-- ========================================================
-- 6. Revenue Associated With Churn by Internet Service
-- ========================================================
-- Business Question:
-- Which internet-service groups have the greatest amount
-- of historical revenue associated with churned customers?

SELECT
    InternetService,

    COUNT(*) AS Churned_Customers,

    ROUND(
        SUM(
            TRY_CAST(
                NULLIF(LTRIM(RTRIM(TotalCharges)), '')
                AS DECIMAL(18,2)
            )
        ), 2
    ) AS Churned_Revenue

FROM CustomerChurn

WHERE Churn = 'Yes'
  AND TRY_CAST(
        NULLIF(LTRIM(RTRIM(TotalCharges)), '')
        AS DECIMAL(18,2)
      ) IS NOT NULL

GROUP BY InternetService
ORDER BY Churned_Revenue DESC;