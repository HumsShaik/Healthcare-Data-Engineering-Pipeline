USE HealthcareDW;
GO
-- create Silver table

CREATE TABLE silver.diabetic_clean (
    encounter_id INT,
    patient_nbr INT,
    race NVARCHAR(50),
    gender NVARCHAR(50),
    age NVARCHAR(50),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_emergency INT,
    number_inpatient INT,
    number_diagnoses INT,
    readmitted NVARCHAR(50)
);
GO

-- Load Silver Table

INSERT INTO silver.diabetic_clean
SELECT
    encounter_id,
    patient_nbr,
    NULLIF(race, '?') AS race,
    gender,
    age,
    admission_type_id,
    discharge_disposition_id,
    admission_source_id,
    time_in_hospital,
    num_lab_procedures,
    num_procedures,
    num_medications,
    number_outpatient,
    number_emergency,
    number_inpatient,
    number_diagnoses,
    readmitted
FROM bronze.diabetic_data;
GO

-- Verify

SELECT COUNT(*) AS total_rows
FROM silver.diabetic_clean;

