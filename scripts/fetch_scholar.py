import requests
import os
import json

# --- AYARLAR ---
SCHOLAR_ID = "M3pcI0EAAAAJ"  # Google Scholar profil ID (URL'den al)
API_KEY = os.getenv("SERPAPI_KEY")  # GitHub Secrets'tan okunur

if not API_KEY:
    raise ValueError("SERPAPI_KEY environment variable not set in GitHub Actions secrets.")

# --- SerpAPI İstek ---
url = "https://serpapi.com/search"
params = {
    "engine": "google_scholar_author",
    "author_id": SCHOLAR_ID,
    "api_key": API_KEY
}

response = requests.get(url, params=params)
if response.status_code != 200:
    raise RuntimeError(f"SerpAPI request failed with status code {response.status_code}")

data = response.json()

# --- ÇIKTIYI KAYDET ---
output_path = "_data/publications.json"
os.makedirs(os.path.dirname(output_path), exist_ok=True)
with open(output_path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print(f"Google Scholar verisi '{output_path}' dosyasına kaydedildi.")
