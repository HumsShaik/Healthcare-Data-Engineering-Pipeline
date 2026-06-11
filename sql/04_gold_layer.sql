-- create Gold Table

USE HealthcareDW;
GO

CREATE TABLE gold.readmission_summary (
    age NVARCHAR(50),
    gender NVARCHAR(50),
    race NVARCHAR(50),
    total_encounters INT,
    avg_time_in_hospital DECIMAL(10,2),
    avg_num_medications DECIMAL(10,2),
    readmitted_count INT,
    readmission_rate DECIMAL(10,2)
);
GO

-- Load Gold Table

INSERT INTO gold.readmission_summary
SELECT
    age,
    gender,
    race,
    COUNT(*) AS total_encounters,
    AVG(CAST(time_in_hospital AS FLOAT)) AS avg_time_in_hospital,
    AVG(CAST(num_medications AS FLOAT)) AS avg_num_medications,
    SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_count,
    CAST(
        100.0 * SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS readmission_rate
FROM silver.diabetic_clean
GROUP BY
    age,
    gender,
    race;
GO

-- Verify

SELECT TOP 20 *
FROM gold.readmission_summary
ORDER BY readmission_rate DESC;

