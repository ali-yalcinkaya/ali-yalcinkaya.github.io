import requests
import os
import json

# --- AYARLAR ---
SCHOLAR_ID = "M3pcI0EAAAAJ"  # Sadece ID kısmı
API_KEY = os.getenv("SERPAPI_KEY")  # GitHub Secrets'a eklenmeli

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
response.raise_for_status()  # HTTP hatası varsa durdur

data = response.json()

# --- ÇIKTIYI KAYDET ---
output_path = "_data/publications.json"
os.makedirs(os.path.dirname(output_path), exist_ok=True)
with open(output_path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print(f"Google Scholar verisi '{output_path}' dosyasına kaydedildi.")
