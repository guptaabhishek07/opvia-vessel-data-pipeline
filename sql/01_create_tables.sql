CREATE OR REPLACE TABLE raw_vessels (
    entity_name STRING,
    type STRING,
    dimensions STRING,
    source_url STRING,
    scraped_at TIMESTAMP_TZ
);

CREATE OR REPLACE TABLE vessels_clean (
    vessel_id INTEGER AUTOINCREMENT,
    entity_name STRING,
    type STRING,
    length FLOAT,
    width FLOAT,
    source_url STRING,
    scraped_at TIMESTAMP_TZ
);
