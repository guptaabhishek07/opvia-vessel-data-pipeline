SELECT
    ROW_NUMBER() OVER (ORDER BY entity_name) AS vessel_id,
    entity_name,
    type
FROM {{ ref('stg_vessels') }}
GROUP BY entity_name, type
