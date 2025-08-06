# Cancer-Patient-Data-Analysis-SQL-PROJECT-
This project explores a clinical dataset related to cancer patients, focusing on key medical variables such as AJCC cancer stage, tumor laterality, smoking status, vital status, and treatment outcomes (local and regional control).

## Dataset source
- <a href="https://www.cancerimagingarchive.net/collection/hnscc)">Dataset Source</a>

Dataset Tables

1. CancerInfo
Contains demographic and diagnostic information including:

Patient_ID,
Gender,
Age_Diagnosed,
Smoking_Status,
Tumor_Laterality,
AJCC_Stage,
Vital_Status

2. CancerTreatment
Includes treatment and control outcomes:

Patient_ID,
Therapeutic_Combination,
Local_Control,
Regional_Control

Basic Exploratory Queries

-- View raw data ordered by age
SELECT * FROM PortfolioProject..CancerInfo ORDER BY Age_Diagnosed;
SELECT * FROM PortfolioProject..CancerTreatment ORDER BY Age_Diagnosed;

2. Selected Columns for Analysis

SELECT Patient_ID, Gender, Age_Diagnosed, Smoking_Status, Tumor_Laterality, AJCC_Stage, Vital_Status
FROM PortfolioProject..CancerInfo
ORDER BY Age_Diagnosed;

3. Smoking Status Distribution

SELECT DISTINCT Smoking_Status FROM PortfolioProject..CancerInfo;

📊 Smoking Status Analysis
Smoking vs Gender vs Age

SELECT Smoking_Status, Gender, COUNT(*) AS Total, AVG(Age_Diagnosed) AS AvgAge
FROM CancerInfo
GROUP BY Smoking_Status, Gender;

Smoking vs Cancer Stage

SELECT Smoking_Status, AJCC_Stage, COUNT(*) AS PatientCount
FROM CancerInfo
GROUP BY Smoking_Status, AJCC_Stage
ORDER BY Smoking_Status, AJCC_Stage;

Smoking vs Vital Status

SELECT Smoking_Status, Vital_Status, COUNT(*) AS PatientCount
FROM CancerInfo
GROUP BY Smoking_Status, Vital_Status
ORDER BY Smoking_Status;

🧬 Tumor Laterality vs Vital Status

SELECT Vital_Status, Tumor_Laterality, COUNT(*) AS PatientCount
FROM CancerInfo
GROUP BY Tumor_Laterality, Vital_Status
ORDER BY Tumor_Laterality;

📈 Smoking Status Outcome Percentages

WITH TotalPerGroup AS (
    SELECT Smoking_Status, COUNT(*) AS TotalPatients
    FROM CancerInfo
    GROUP BY Smoking_Status
)
SELECT 
    c.Smoking_Status,
    c.Vital_Status,
    COUNT(*) AS PatientCount,
    ROUND(COUNT(*) * 100.0 / t.TotalPatients, 2) AS Percentage
FROM CancerInfo c
JOIN TotalPerGroup t ON c.Smoking_Status = t.Smoking_Status
GROUP BY c.Smoking_Status, c.Vital_Status, t.TotalPatients
ORDER BY c.Smoking_Status, c.Vital_Status;

💉 Treatment Effectiveness
AJCC Stage vs Local Control

SELECT ci.AJCC_Stage, ct.Local_Control, COUNT(*) AS PatientCount
FROM CancerInfo ci
JOIN CancerTreatment ct ON ci.Patient_ID = ct.Patient_ID
GROUP BY ci.AJCC_Stage, ct.Local_Control
ORDER BY ci.AJCC_Stage, ct.Local_Control;

AJCC Stage vs Regional Control

SELECT ci.AJCC_Stage, ct.Regional_Control, COUNT(*) AS PatientCount
FROM CancerInfo ci
JOIN CancerTreatment ct ON ci.Patient_ID = ct.Patient_ID
GROUP BY ci.AJCC_Stage, ct.Regional_Control
ORDER BY ci.AJCC_Stage, ct.Regional_Control;

AJCC Stage vs Both Controls

SELECT ci.AJCC_Stage, ct.Local_Control, ct.Regional_Control, COUNT(*) AS PatientCount
FROM CancerInfo ci
JOIN CancerTreatment ct ON ci.Patient_ID = ct.Patient_ID
GROUP BY ci.AJCC_Stage, ct.Local_Control, ct.Regional_Control
ORDER BY ci.AJCC_Stage, ct.Local_Control, ct.Regional_Control;

🧪 Treatment Type vs Vital Status

SELECT ci.AJCC_Stage, ci.Vital_Status, ct.Therapeutic_Combination, COUNT(*) AS PatientCount
FROM CancerInfo ci
JOIN CancerTreatment ct ON ci.Patient_ID = ct.Patient_ID
GROUP BY ci.AJCC_Stage, ci.Vital_Status, ct.Therapeutic_Combination
ORDER BY ci.AJCC_Stage, ci.Vital_Status, ct.Therapeutic_Combination;

📊 Filtering Based on Patient Volume
Local Control Outcomes With More Than 20 Patients

SELECT AJCC_Stage, Local_Control, COUNT(*) AS CountPatients
FROM CancerInfo
JOIN CancerTreatment ON CancerInfo.Patient_ID = CancerTreatment.Patient_ID
GROUP BY AJCC_Stage, Local_Control
HAVING COUNT(*) > 20;

AJCC Stage vs Vital Status (All & > 3 Patients)

-- All counts
SELECT AJCC_Stage, Vital_Status, COUNT(*) AS CountPatients
FROM CancerInfo
GROUP BY AJCC_Stage, Vital_Status;

-- Only where count > 3
SELECT AJCC_Stage, Vital_Status, COUNT(*) AS CountPatients
FROM CancerInfo
GROUP BY AJCC_Stage, Vital_Status
HAVING COUNT(*) > 3;

🧠 View: Patient Count by Vital Status
Step 1: Drop if it exists

IF OBJECT_ID('vw_PatientVitalStatus', 'V') IS NOT NULL
    DROP VIEW vw_PatientVitalStatus;
GO

Step 2: Create the view

CREATE VIEW vw_PatientVitalStatus AS
SELECT vital_status, COUNT(*) AS PatientCount
FROM CancerInfo
GROUP BY vital_status;
GO

Step 3: Query the view

SELECT * FROM vw_PatientVitalStatus;

