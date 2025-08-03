from scholarly import scholarly
import json
import os

# Google Scholar kullanıcı ID
SCHOLAR_ID = "M3pcI0EAAAAJ"  # Senin ID

# Yayınları çek
author = scholarly.search_author_id(SCHOLAR_ID)
author = scholarly.fill(author, sections=["publications"])

publications = []
for pub in author["publications"]:
    title = pub["bib"]["title"]
    year = pub["bib"].get("pub_year", "N/A")
    venue = pub["bib"].get("venue", "")
    link = f"https://scholar.google.com/citations?view_op=view_citation&hl=en&user={SCHOLAR_ID}&citation_for_view={pub['author_pub_id']}"

    publications.append({
        "title": title,
        "year": year,
        "venue": venue,
        "link": link
    })

# _data klasörüne kaydet
os.makedirs("_data", exist_ok=True)
with open("_data/publications.json", "w", encoding="utf-8") as f:
    json.dump(publications, f, ensure_ascii=False, indent=2)

print(f"{len(publications)} publication(s) saved to _data/publications.json")
