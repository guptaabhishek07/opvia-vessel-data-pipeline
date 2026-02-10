SELECT
    d.entity_name,
    COUNT(*) AS observations
FROM fct_vessel_metrics f
JOIN dim_vessels d
    ON f.vessel_id = d.vessel_id
GROUP BY d.entity_name
ORDER BY observations DESC
LIMIT 10;


SELECT
    DATE(scraped_at) AS scrape_date,
    COUNT(*) AS records_count
FROM fct_vessel_metrics
GROUP BY scrape_date
ORDER BY scrape_date;


SELECT *
FROM fct_vessel_metrics
WHERE TRY_TO_NUMBER(SPLIT_PART(dimensions,'/',1)) > 400;


SELECT
    type,
    COUNT(*) AS vessel_count
FROM dim_vessels
GROUP BY type
ORDER BY vessel_count DESC;

SELECT
    d.entity_name,
    f.scraped_at
FROM fct_vessel_metrics f
JOIN dim_vessels d
    ON f.vessel_id = d.vessel_id
ORDER BY f.scraped_at DESC
LIMIT 20;
