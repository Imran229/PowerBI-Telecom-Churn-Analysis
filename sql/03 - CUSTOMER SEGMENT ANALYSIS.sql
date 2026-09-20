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
SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(Churn = 'Yes') AS Churned_Customers,
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2) AS Churn_Rate_Percent
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY InternetService
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 2. Churn by Online Security
-- ========================================================
SELECT
    OnlineSecurity,
    COUNT(*) AS Total_Customers,
    SUM(Churn = 'Yes') AS Churned_Customers,
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2) AS Churn_Rate_Percent
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY OnlineSecurity
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 3. Churn by Tech Support
-- ========================================================
SELECT
    TechSupport,
    COUNT(*) AS Total_Customers,
    SUM(Churn = 'Yes') AS Churned_Customers,
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2) AS Churn_Rate_Percent
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY TechSupport
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 4. Churn by Payment Method
-- ========================================================
SELECT
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(Churn = 'Yes') AS Churned_Customers,
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2) AS Churn_Rate_Percent
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY PaymentMethod
ORDER BY Churn_Rate_Percent DESC;


-- ========================================================
-- 5. Churn by Admin Ticket Volume
-- ========================================================
SELECT
    numAdminTickets,
    COUNT(*) AS Total_Customers,
    SUM(Churn = 'Yes') AS Churned_Customers,
    ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 2) AS Churn_Rate_Percent
FROM Telecom_customer_churn
WHERE TRIM(TotalCharges) <> ''
GROUP BY numAdminTickets
ORDER BY numAdminTickets;
