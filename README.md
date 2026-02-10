# Vessel Data Engineering Pipeline

## Project Overview

This project implements an end-to-end **data engineering pipeline** that extracts public maritime vessel data, ingests it into Snowflake, transforms it using dbt, and prepares analytics-ready warehouse models for downstream BI and decision support.

The pipeline demonstrates production-style ingestion, transformation, and modeling practices.


## Architecture Flow

```
VesselFinder Public Website
        ↓
Python Scraper (requests + BeautifulSoup)
        ↓
raw_data.csv
        ↓
Snowflake Internal Stage
        ↓
Raw Table (raw_vessels)
        ↓
dbt Transformations
    ├── stg_vessels
    ├── dim_vessels
    └── fct_vessel_metrics
        ↓
Analytics SQL Queries
        ↓
BI / Reporting Layer
```


## Project Structure

```
opvia/
│
├── scraper/
│   └── scrape.py                # VesselFinder scraping script
│
├── sql/
│   ├── create_tables.sql        # Raw & clean table creation
│   ├── load_data.sql            # Snowflake COPY ingestion
│   └── analytics_queries.sql    # Analytical queries
│
├── vessel_dbt/                  # dbt transformation project
│
├── raw_data.csv                 # Scraped dataset
├── analysis_answers.md          # Stakeholder and architecture analysis
├── requirements.txt
└── README.md
```

## Data Extraction

* Scraped vessel listing data from public VesselFinder pages
* Implemented pagination handling to collect 100+ rows
* Included metadata fields such as source URL and scrape timestamp
* Stored structured output as CSV


## Data Ingestion (Snowflake)

* Created internal Snowflake stage for raw ingestion
* Loaded dataset into `raw_vessels` ingestion table
* Designed separate ingestion and transformation layers for warehouse modeling


## Data Transformation (dbt)

The dbt project builds a layered warehouse model:

**stg_vessels**

* Cleans raw ingestion data
* Standardizes column naming and formatting

**dim_vessels**

* Deduplicated vessel dimension table
* Generates surrogate keys for modeling

**fct_vessel_metrics**

* Fact table storing time-based vessel observations
* Linked to dimension table via surrogate key


## Analytics Layer

Analytical SQL queries enable:

* Vessel category distribution analysis
* Time-series ingestion monitoring
* Outlier vessel detection
* Operational reporting queries


## Scalability & Production Considerations

* Scraping can be scheduled using orchestration tools (Airflow / n8n)
* dbt incremental models allow large-scale ingestion
* Warehouse staging layer enables raw historical retention
* Data quality monitoring can track ingestion completeness and schema changes


## Outcome

This pipeline converts raw scraped maritime data into **analytics-ready warehouse models**, demonstrating ingestion architecture, dimensional modeling, and transformation workflows aligned with real consulting data engineering engagements.


## How to Run

### Scraper

```bash
pip install -r requirements.txt
python scraper/scrape.py
```

### Snowflake Ingestion

Run SQL scripts in Snowflake:

```
sql/create_tables.sql
sql/load_data.sql
```

### dbt Models

Run dbt project:

```
dbt run
```

# Dataset Source:
https://www.vesselfinder.com/vessels?page={page}

### Run Streamlit app
cd app
streamlit run app.py

## Deliverables

* Automated scraper
* Structured Snowflake ingestion layer
* dbt transformation models
* Analytics SQL queries
* Stakeholder analysis documentation


## Author

Abhishek Kumar

