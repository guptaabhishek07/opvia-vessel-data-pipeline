import requests
from bs4 import BeautifulSoup
import pandas as pd
from datetime import datetime, UTC
import time

HEADERS = {"User-Agent": "Mozilla/5.0"}
data = []


# ---------- safe request ----------
def get_page(url):
    for _ in range(3):
        try:
            r = requests.get(url, headers=HEADERS, timeout=15)
            if r.status_code == 200:
                return r
        except Exception:
            time.sleep(3)
    return None


# ---------- scraper ----------
def scrape_vesselfinder(pages=10):

    for page in range(1, pages + 1):
        url = f"https://www.vesselfinder.com/vessels?page={page}"

        r = get_page(url)
        if r is None:
            print("Failed:", url)
            continue

        soup = BeautifulSoup(r.text, "lxml")

        rows = soup.select("tr")

        for row in rows:
            cols = row.find_all("td")
            if len(cols) < 5:
                continue

            name = cols[0].get_text(strip=True)
            vessel_type = cols[1].get_text(strip=True)
            dimensions = cols[-1].get_text(strip=True)

            if name == "":
                continue

            data.append({
                "entity_name": name,
                "type": vessel_type,
                "dimensions": dimensions,
                "source_url": url,
                "scraped_at": datetime.now(UTC)
            })

        print("Scraped page:", page)
        time.sleep(2)


# ---------- main ----------
if __name__ == "__main__":
    scrape_vesselfinder(pages=15)

    df = pd.DataFrame(data)
    df.to_csv("raw_data.csv", index=False)

    print("Saved", len(df), "rows")
