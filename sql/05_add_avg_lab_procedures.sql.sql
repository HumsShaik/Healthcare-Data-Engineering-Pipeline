-- Add Column

USE HealthcareDW;
GO

ALTER TABLE gold.readmission_summary
ADD avg_lab_procedures DECIMAL(10,2);
GO

-- Populate Column

UPDATE g
SET avg_lab_procedures = x.avg_lab_procedures
FROM gold.readmission_summary g
JOIN (
    SELECT
        age,
        gender,
        race,
        CAST(
            AVG(CAST(num_lab_procedures AS FLOAT))
            AS DECIMAL(10,2)
        ) AS avg_lab_procedures
    FROM silver.diabetic_clean
    GROUP BY
        age,
        gender,
        race
) x
ON g.age = x.age
AND g.gender = x.gender
AND ISNULL(g.race, 'Unknown')
    = ISNULL(x.race, 'Unknown');
GO

-- Verify

SELECT TOP 20 *
FROM gold.readmission_summary;

