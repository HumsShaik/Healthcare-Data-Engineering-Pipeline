USE HealthcareDW;
GO

-- Move imported tables into Bronze Layer

ALTER SCHEMA bronze
TRANSFER dbo.diabetic_data;
GO

ALTER SCHEMA bronze
TRANSFER dbo.IDS_mapping;
GO

-- Verify

SELECT
    s.name AS schema_name,
    t.name AS table_name
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
ORDER BY s.name, t.name;