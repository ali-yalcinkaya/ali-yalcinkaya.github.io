# 📊 İstatistik Otomasyon Sistemi - Proje Özeti

## 🎯 Proje Amacı

Bu proje, kullanıcıların CSV dosyalarını yükleyerek çeşitli istatistiksel analizler gerçekleştirebilecekleri, APA formatında raporlar alabilecekleri kapsamlı bir web uygulamasıdır.

## 🏗️ Sistem Mimarisi

### Teknolojiler
- **Backend:** R Shiny
- **Frontend:** HTML, CSS, JavaScript
- **Veri İşleme:** tidyverse, rstatix, car
- **Görselleştirme:** ggplot2, plotly, corrplot
- **Raporlama:** apaTables, flextable, officer
- **Deployment:** Docker, GitHub Pages, Shiny Server

### Dosya Yapısı
```
ali-yalcinkaya.github.io/
├── index.html                 # Ana sayfa
├── README.md                  # Proje açıklaması
├── PROJE_OZETI.md            # Bu dosya
├── Dockerfile                 # Docker yapılandırması
├── docker-compose.yml         # Docker Compose
├── .github/workflows/         # GitHub Actions
│   └── deploy.yml
└── statistics/                # Shiny uygulaması
    ├── app.R                  # Ana uygulama
    ├── run_app.R              # Çalıştırma scripti
    ├── ornek_veri.csv         # Örnek veri
    ├── KULLANIM_KILAVUZU.md   # Kullanım kılavuzu
    └── shiny-server.conf      # Server yapılandırması
```

## 🔬 Desteklenen Analizler

### 1. Betimsel İstatistikler
- Ortalama, standart sapma, min-max
- Grupla betimsel istatistikler
- Histogram ve boxplot görselleştirme

### 2. T-test (Bağımsız)
- Otomatik normallik kontrolü (Shapiro-Wilk)
- Varyans eşitliği testi (Levene)
- Uygun test seçimi (t-test veya Mann-Whitney)
- Etki büyüklüğü hesaplama (Cohen's d)

### 3. ANOVA
- Tek yönlü ANOVA
- Çok yönlü ANOVA (gelecek versiyon)
- Post-hoc testler
- Eta-kare hesaplama

### 4. Korelasyon Analizi
- Pearson korelasyonu
- Spearman korelasyonu
- Korelasyon matrisi
- Heatmap görselleştirme

### 5. Partial Korelasyon
- Kontrol değişkenleri ile
- Çoklu değişken desteği
- P-değeri hesaplama

### 6. Regresyon Analizi
- Basit regresyon
- Çoklu regresyon
- R-kare ve F-testi
- Residual analizi

## 📊 Özellikler

### Kullanıcı Arayüzü
- Responsive tasarım
- Sürükle-bırak dosya yükleme
- Dinamik değişken seçimi
- Gerçek zamanlı sonuçlar

### Görselleştirme
- Otomatik grafik oluşturma
- Yüksek çözünürlük
- İndirilebilir formatlar
- İnteraktif grafikler

### Raporlama
- APA formatında Word raporları
- PDF raporları
- Otomatik tablo oluşturma
- Grafik ekleme

### Veri İşleme
- Otomatik veri türü algılama
- Eksik veri yönetimi
- Aykırı değer kontrolü
- Veri önizleme

## 🚀 Deployment Seçenekleri

### 1. Yerel Çalıştırma
```bash
# R'de çalıştır
source("statistics/run_app.R")
```

### 2. Docker ile
```bash
# Container oluştur ve çalıştır
docker-compose up -d
```

### 3. Shiny Server ile
```bash
# Shiny Server kurulumu
sudo apt-get install shiny-server
sudo cp statistics/shiny-server.conf /etc/shiny-server/
sudo systemctl restart shiny-server
```

### 4. GitHub Pages ile
- Otomatik deployment
- GitHub Actions workflow
- SSL sertifikası

## 📈 Performans Özellikleri

### Hızlandırma
- Lazy loading
- Caching sistemi
- Asenkron işlemler
- Optimized grafik rendering

### Güvenlik
- Dosya türü kontrolü
- Boyut sınırlaması
- XSS koruması
- CSRF koruması

### Ölçeklenebilirlik
- Çoklu kullanıcı desteği
- Load balancing
- Resource management
- Auto-scaling

## 🔧 Geliştirme

### Katkıda Bulunma
1. Fork yapın
2. Feature branch oluşturun
3. Değişiklikleri commit edin
4. Pull request gönderin

### Test Etme
```bash
# Unit testler
R -e "devtools::test()"

# Integration testler
R -e "shinytest::testApp('statistics')"
```

### Kod Standartları
- R style guide uyumu
- Tidyverse conventions
- Shiny best practices
- Accessibility standards

## 📚 Dokümantasyon

### Kullanıcı Dokümantasyonu
- Kullanım kılavuzu
- Video tutoriallar
- FAQ bölümü
- Örnek veri setleri

### Geliştirici Dokümantasyonu
- API referansı
- Kod yorumları
- Architecture diagram
- Deployment guide

## 🎯 Gelecek Planları

### Kısa Vadeli (1-3 ay)
- [ ] Çok yönlü ANOVA
- [ ] Eşleştirilmiş T-test
- [ ] Non-parametric testler
- [ ] Güven aralıkları

### Orta Vadeli (3-6 ay)
- [ ] Machine learning modelleri
- [ ] Time series analizi
- [ ] Survival analizi
- [ ] Multilevel modeling

### Uzun Vadeli (6+ ay)
- [ ] Python entegrasyonu
- [ ] Real-time collaboration
- [ ] Cloud deployment
- [ ] Mobile app

## 📞 İletişim

**Geliştirici:** Ali Yalcinkaya  
**Email:** [email protected]  
**GitHub:** https://github.com/ali-yalcinkaya  
**Website:** https://ali-yalcinkaya.github.io  

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

---

**Son Güncelleme:** 2025  
**Versiyon:** 1.0.0  
**Durum:** Aktif Geliştirme
