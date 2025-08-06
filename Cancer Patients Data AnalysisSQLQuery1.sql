Select *
From PortfolioProject..CancerInfo
order by Age_Diagnosed


Select *
From PortfolioProject..CancerTreatment




-- select columns that will be used 

Select Patient_ID, Gender, Age_Diagnosed, Smoking_status,Tumor_laterality, AJCC_Stage,  vital_status
From PortfolioProject..CancerInfo
Order by Age_Diagnosed;


Select Distinct Smoking_Status From PortfolioProject..CancerInfo


-- Analyzing Smoking_Status VS Gender  VS Age_diagnosed

Select Smoking_Status, Gender, COUNT(*) AS Total, AVG(Age_Diagnosed) AS AvgAge
From PortfolioProject..CancerInfo
Group by Smoking_Status, Gender;


--Smoking Status vs AJCC Stage(Cancer stage)

Select
    Smoking_Status, 
    AJCC_Stage, 
    COUNT(*) AS PatientCount
From CancerInfo
Group by Smoking_Status, AJCC_Stage
Order by Smoking_Status, AJCC_Stage;


--Smoking_Status vs Vital_Status

SELECT 
    Smoking_Status, 
    Vital_Status, 
    COUNT(*) AS PatientCount
FROM CancerInfo
Group by Smoking_Status, Vital_Status
Order by Smoking_Status;



-- Vital_Status vs Tumor_Lterality

SELECT 
    Vital_Status, 
    Tumor_laterality, 
    COUNT(*) AS PatientCount
FROM CancerInfo
Group by Tumor_laterality, Vital_Status
Order by Tumor_laterality;
-- NOS means NOT SPECIFIED

 --% of Outcomes per Vital_Status

With TotalPerGroup AS (
    Select Smoking_Status, Count(*) AS TotalPatients
    From CancerInfo
    Group by Smoking_Status
)
Select 
    c.Smoking_Status,
    c.Vital_Status,
    Count(*) AS PatientCount,
    ROUND(COUNT(*) * 100.0 / t.TotalPatients, 2) AS Percentage
FROM CancerInfo c
JOIN TotalPerGroup t
  ON c.Smoking_Status = t.Smoking_Status
Group by c.Smoking_Status, c.Vital_Status, t.TotalPatients
Order by c.Smoking_Status, c.Vital_Status;


--Analysis of AJCC Cancer Stage vs Local Control Outcomes

SELECT 
    ci.AJCC_Stage,
    ct.Local_Control,
    COUNT(*) AS PatientCount
FROM CancerInfo ci
JOIN CancerTreatment ct
    ON ci.Patient_ID = ct.Patient_ID
GROUP BY 
    ci.AJCC_Stage, 
    ct.Local_Control
ORDER BY 
    ci.AJCC_Stage,
    ct.Local_Control;


--Analysis of AJCC Cancer Stage vs Regional Control Outcomes

    SELECT 
    ci.AJCC_Stage,
    ct.Regional_Control,
    COUNT(*) AS PatientCount
FROM CancerInfo ci
JOIN CancerTreatment ct
    ON ci.Patient_ID = ct.Patient_ID
GROUP BY 
    ci.AJCC_Stage,  
    ct.Regional_Control
ORDER BY 
    ci.AJCC_Stage,
    ct.Regional_Control;


    --Analysis of AJCC Cancer Stage vs Local and Regional Control Outcomes

    SELECT 
    ci.AJCC_Stage,
    ct.Local_Control,
    ct.Regional_Control,
    COUNT(*) AS PatientCount
FROM CancerInfo ci
JOIN CancerTreatment ct
    ON ci.Patient_ID = ct.Patient_ID
GROUP BY 
    ci.AJCC_Stage, 
    ct.Local_Control, 
    ct.Regional_Control
ORDER BY 
    ci.AJCC_Stage,
    ct.Local_Control,
    ct.Regional_Control;


    --Analysis of AJCC Cancer Stage vs Treatment/Chemo Type vs Vital_Status

    SELECT 
    ci.AJCC_Stage,
    ci.Vital_Status,
    ct.Therapeutic_Combination,
    COUNT(*) AS PatientCount
FROM CancerInfo ci
JOIN CancerTreatment ct
    ON ci.Patient_ID = ct.Patient_ID
GROUP BY 
    ci.AJCC_Stage, 
    ci.Vital_Status,
    ct.Therapeutic_Combination
ORDER BY 
    ci.AJCC_Stage,
    ci.Vital_Status,
    ct.Therapeutic_Combination;


-- AJCC Stage and Local Control combinations where there are more than 5 patients

 Select AJCC_Stage, Local_Control, Count(*) AS CountPatients
From CancerInfo
Join CancerTreatment ON CancerInfo.Patient_ID = CancerTreatment.Patient_ID
Group by AJCC_Stage, Local_Control
Having Count(*) > 20;


-- AJCC Stage vs Vital Status

Select AJCC_Stage, vital_status, COUNT(*) AS CountPatients
From CancerInfo
Group by AJCC_Stage, vital_status;



-- AJCC Stage vs Vital Status — Only Where Each Combo Has > 3 Patients
Select AJCC_Stage, vital_status, COUNT(*) AS CountPatients
From CancerInfo
Group by AJCC_Stage, vital_status
Having COUNT(*) > 3;

-- View for Patient Count by Vital Status

GO

CREATE VIEW vw_PatientVitalStatus AS
SELECT vital_status, COUNT(*) AS PatientCount
FROM CancerInfo
GROUP BY vital_status;


SELECT * FROM vw_PatientVitalStatus;
