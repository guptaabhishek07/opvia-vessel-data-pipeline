SELECT
    d.vessel_id,
    s.scraped_at,
    s.dimensions,
    s.source_url
FROM {{ ref('stg_vessels') }} s
JOIN {{ ref('dim_vessels') }} d
    ON s.entity_name = d.entity_name
