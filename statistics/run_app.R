# 📊 İstatistik Otomasyon Sistemi - Çalıştırma Scripti
# Ali Yalcinkaya - https://ali-yalcinkaya.github.io/statistics/

# Gerekli paketleri kontrol et ve yükle
required_packages <- c(
  "shiny", "tidyverse", "rstatix", "car", "emmeans",
  "apaTables", "ppcor", "officer", "flextable", "papaja",
  "DT", "shinyjs", "shinyWidgets", "plotly", "corrplot"
)

# Eksik paketleri yükle
missing_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(missing_packages) > 0) {
  cat("📦 Eksik paketler yükleniyor...\n")
  install.packages(missing_packages)
  cat("✅ Paketler yüklendi!\n")
}

# Kütüphaneleri yükle
cat("📚 Kütüphaneler yükleniyor...\n")
lapply(required_packages, library, character.only = TRUE)
cat("✅ Kütüphaneler yüklendi!\n")

# Shiny uygulamasını çalıştır
cat("🚀 İstatistik Otomasyon Sistemi başlatılıyor...\n")
cat("📱 Tarayıcınızda http://localhost:3838 adresini açın\n")
cat("⏹️ Durdurmak için Ctrl+C tuşlayın\n\n")

# Uygulamayı çalıştır
shiny::runApp(port = 3838, launch.browser = FALSE)
