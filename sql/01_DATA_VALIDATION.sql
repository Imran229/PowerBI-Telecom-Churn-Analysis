create database telecom_customer_churn;
use telecom_customer_churn;
CREATE TABLE Telecom_customer_churn (
    customerID VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen TINYINT,          
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,                     
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10, 2),  
    TotalCharges DECIMAL(10, 2),   
    numAdminTickets INT,
    Churn VARCHAR(5)
);
select * from telecom_customer_churn;
select count(*) from telecom_customer_churn;

/*
==========================================================
01 - DATA VALIDATION
==========================================================

Business Problem:
Before analyzing customer churn, we need to make sure
the dataset is complete, unique and suitable for analysis.

Dataset: Telecom Customer Churn
Table: Telecom_customer_churn
==========================================================
*/


-- ========================================================
-- 1. Check the total number of customer records
-- ========================================================
-- Business Question:
-- How many customer records are available in the dataset?

SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT customerID) AS Unique_Customers
FROM CustomerChurn;


-- ========================================================
-- 2. Check for duplicate customer IDs
-- ========================================================
-- Business Question:
-- Are there duplicate customers that could affect
-- our churn calculations?

SELECT
    customerID,
    COUNT(*) AS Record_Count
FROM CustomerChurn
GROUP BY customerID
HAVING COUNT(*) > 1;


-- ========================================================
-- 3. Check missing TotalCharges values
-- ========================================================
-- Business Question:
-- Are there missing TotalCharges values that could
-- affect revenue analysis?

SELECT
    COUNT(*) AS Missing_TotalCharges
FROM CustomerChurn
WHERE TotalCharges IS NULL
   OR LTRIM(RTRIM(TotalCharges)) = '';


-- ========================================================
-- 4. Identify the records with missing TotalCharges
-- ========================================================
-- Business Question:
-- Which customer records have missing revenue values?

SELECT
    customerID,
    tenure,
    MonthlyCharges,
    TotalCharges,
    Churn
FROM CustomerChurn
WHERE TotalCharges IS NULL
   OR LTRIM(RTRIM(TotalCharges)) = '';


-- ========================================================
-- 5. Check the main churn categories
-- ========================================================
-- Business Question:
-- Are the expected Churn categories present in the data?

SELECT
    Churn,
    COUNT(*) AS Customer_Count
FROM CustomerChurn
GROUP BY Churn;


-- ========================================================
-- 6. Check basic numeric ranges
-- ========================================================
-- Business Question:
-- Are tenure and monthly charges within reasonable ranges?

SELECT
    MIN(tenure) AS Minimum_Tenure,
    MAX(tenure) AS Maximum_Tenure,
    MIN(MonthlyCharges) AS Minimum_MonthlyCharges,
    MAX(MonthlyCharges) AS Maximum_MonthlyCharges
FROM CustomerChurn;

