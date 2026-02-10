COPY INTO raw_vessels
FROM @your_stage/raw_data.csv
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1);
