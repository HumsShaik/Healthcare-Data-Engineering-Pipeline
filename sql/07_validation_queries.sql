USE HealthcareDW;
GO

-- Bronze Count

SELECT COUNT(*) AS bronze_records
FROM bronze.diabetic_data;

-- Silver Count

SELECT COUNT(*) AS silver_records
FROM silver.diabetic_clean;

-- Gold Count

SELECT COUNT(*) AS gold_records
FROM gold.readmission_summary;

-- Missing Race Records

SELECT COUNT(*) AS missing_race_records
FROM silver.diabetic_clean
WHERE race IS NULL;

-- Overall Readmission Rate

SELECT
    SUM(readmitted_count) AS total_readmitted,
    SUM(total_encounters) AS total_encounters,
    CAST(
        100.0 * SUM(readmitted_count)
        / SUM(total_encounters)
        AS DECIMAL(10,2)
    ) AS readmission_rate
FROM gold.readmission_summary;

