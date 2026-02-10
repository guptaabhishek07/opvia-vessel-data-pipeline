import streamlit as st
import pandas as pd
import snowflake.connector

st.title("Vessel Intelligence Dashboard")



# --- Snowflake connection ---
conn = snowflake.connector.connect(
    user="ABHISHEK",
    password="Abhi@224474358899",
    account="RBBYSAU-MK44558",
    warehouse="COMPUTE_WH",
    database="VESSEL_DB",
    schema="PUBLIC"
)

st.subheader("Executive KPIs")

kpi_query = """
SELECT
    COUNT(DISTINCT vessel_id) AS total_vessels
FROM FCT_VESSEL_METRICS
"""

kpi_df = pd.read_sql(kpi_query, conn)

col1, col2 = st.columns(2)

with col1:
    st.metric("Total Active Vessels", int(kpi_df.iloc[0,0]))

fresh_query = "SELECT * FROM ANALYTICS.data_freshness_monitor"
fresh_df = pd.read_sql(fresh_query, conn)

with col2:
    st.metric("Last Data Update", str(fresh_df["LAST_UPDATE"][0]))


st.subheader("Fleet Company Concentration")

query_company = """
SELECT company, vessel_count
FROM ANALYTICS.fleet_company_concentration
LIMIT 10
"""

df_company = pd.read_sql(query_company, conn)
st.bar_chart(df_company.set_index("COMPANY"))


st.subheader("Vessel Age Distribution")

query_age = """
SELECT vessel_age, vessels
FROM ANALYTICS.vessel_age_distribution
"""

df_age = pd.read_sql(query_age, conn)
st.bar_chart(df_age.set_index("VESSEL_AGE"))


st.subheader("Fleet Growth Over Time")

query_growth = """
SELECT scrape_date, active_vessels
FROM ANALYTICS.fleet_growth_daily
"""

df_growth = pd.read_sql(query_growth, conn)
st.line_chart(df_growth.set_index("SCRAPE_DATE"))

st.subheader("Fleet Age Distribution")

query_type = """
SELECT type, vessel_count
FROM ANALYTICS.fleet_type_distribution
"""

df_type = pd.read_sql(query_type, conn)
st.bar_chart(df_type.set_index("TYPE"))
