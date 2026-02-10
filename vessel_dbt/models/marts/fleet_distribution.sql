SELECT
    type,
    COUNT(*) AS vessel_count
FROM {{ ref('stg_vessels') }}
GROUP BY type
ORDER BY vessel_count DESC
