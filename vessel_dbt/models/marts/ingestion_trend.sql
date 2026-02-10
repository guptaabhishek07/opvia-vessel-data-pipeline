SELECT
    DATE(scraped_at) AS ingestion_date,
    COUNT(*) AS records_added
FROM {{ ref('stg_vessels') }}
GROUP BY 1
ORDER BY 1
