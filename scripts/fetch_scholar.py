import requests
import os
import json

SCHOLAR_ID = "M3pcI0EAAAAJ"
API_KEY = os.getenv("SERPAPI_KEY")

if not API_KEY:
    raise ValueError("SERPAPI_KEY not set.")

url = "https://serpapi.com/search"
params = {
    "engine": "google_scholar_author",
    "author_id": SCHOLAR_ID,
    "api_key": API_KEY
}

response = requests.get(url, params=params)
if response.status_code != 200:
    raise RuntimeError(f"SerpAPI request failed: {response.status_code}")

data = response.json()

# Sadece gerekli alanları seç
publications = []
for pub in data.get("articles", []):
    publications.append({
        "title": pub.get("title", "No title"),
        "year": pub.get("year", ""),
        "link": pub.get("link", "")
    })

# _data/publications.json olarak kaydet
output_path = "_data/publications.json"
os.makedirs(os.path.dirname(output_path), exist_ok=True)
with open(output_path, "w", encoding="utf-8") as f:
    json.dump(publications, f, ensure_ascii=False, indent=2)

print(f"{len(publications)} yayın kaydedildi: {output_path}")
