USE DATABASE VESSEL_DB;
CREATE SCHEMA IF NOT EXISTS ANALYTICS;
USE SCHEMA ANALYTICS;

USE DATABASE VESSEL_DB;
USE SCHEMA ANALYTICS;

CREATE OR REPLACE VIEW fleet_company_concentration AS
SELECT
    entity_name AS company,
    COUNT(*) AS vessel_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_share
FROM VESSEL_DB.PUBLIC.DIM_VESSELS
GROUP BY entity_name
ORDER BY vessel_count DESC;

CREATE OR REPLACE VIEW vessel_age_distribution AS
SELECT
    YEAR(CURRENT_DATE) - TRY_TO_NUMBER(type) AS vessel_age,
    COUNT(*) AS vessels
FROM VESSEL_DB.PUBLIC.DIM_VESSELS
WHERE TRY_TO_NUMBER(type) IS NOT NULL
GROUP BY vessel_age
ORDER BY vessel_age;

CREATE OR REPLACE VIEW company_activity_daily AS
SELECT
    d.entity_name AS vessel_name,
    DATE(f.scraped_at) AS activity_date,
    COUNT(*) AS activity
FROM VESSEL_DB.PUBLIC.FCT_VESSEL_METRICS f
JOIN VESSEL_DB.PUBLIC.DIM_VESSELS d
    ON f.vessel_id = d.vessel_id
GROUP BY vessel_name, activity_date;

CREATE OR REPLACE VIEW fleet_growth_daily AS
SELECT
    DATE(scraped_at) AS scrape_date,
    COUNT(DISTINCT vessel_id) AS active_vessels
FROM VESSEL_DB.PUBLIC.FCT_VESSEL_METRICS
GROUP BY scrape_date
ORDER BY scrape_date;


CREATE OR REPLACE VIEW fleet_type_distribution AS
SELECT
    type,
    COUNT(*) AS vessel_count
FROM VESSEL_DB.PUBLIC.DIM_VESSELS
GROUP BY type
ORDER BY vessel_count DESC;


CREATE OR REPLACE VIEW data_freshness_monitor AS
SELECT
    MAX(scraped_at) AS last_update,
    COUNT(*) AS total_records
FROM VESSEL_DB.PUBLIC.FCT_VESSEL_METRICS;




