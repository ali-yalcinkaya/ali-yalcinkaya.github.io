# 📊 İstatistik Otomasyon Sistemi - Kullanım Kılavuzu

## 🚀 Başlangıç

### Sistem Gereksinimleri
- R (4.0 veya üzeri)
- RStudio (önerilen)
- İnternet bağlantısı (paket yükleme için)

### Kurulum
1. R'yi açın
2. `run_app.R` dosyasını çalıştırın
3. Tarayıcınızda `http://localhost:3838` adresini açın

## 📁 Veri Yükleme

### Desteklenen Formatlar
- CSV dosyaları (.csv)
- Metin dosyaları (.txt)

### Veri Hazırlama
- İlk satır sütun başlıkları olmalı
- Sayısal değişkenler sayısal değerler içermeli
- Kategorik değişkenler metin olabilir
- Eksik veriler boş bırakılabilir

### Örnek Veri Formatı
```csv
ID,Grup,Yas,Anksiyete,Depresyon
1,Kontrol,25,45,32
2,Tedavi,28,55,48
3,Kontrol,22,42,35
```

## 🔬 Analiz Türleri

### 1. Betimsel İstatistikler
**Amaç:** Değişkenlerin temel özelliklerini özetleme

**Çıktılar:**
- N (gözlem sayısı)
- Ortalama
- Standart sapma
- Minimum değer
- Maksimum değer

**Seçenekler:**
- Tüm sayısal değişkenler
- Seçilen değişkenler
- Grupla betimsel istatistikler

### 2. T-test (Bağımsız)
**Amaç:** İki grup arasında ortalama farkı test etme

**Otomatik Kontroller:**
- Shapiro-Wilk normallik testi
- Levene varyans eşitliği testi
- Uygun test seçimi (t-test veya Mann-Whitney)

**Çıktılar:**
- Test türü
- t-değeri
- Serbestlik derecesi
- p-değeri
- Etki büyüklüğü (Cohen's d)

### 3. ANOVA (Tek Yönlü)
**Amaç:** İkiden fazla grup arasında ortalama farkı test etme

**Çıktılar:**
- F-değeri
- Serbestlik derecesi
- p-değeri
- Eta-kare (etki büyüklüğü)

### 4. Korelasyon Analizi
**Türler:**
- Pearson korelasyonu (normal dağılım için)
- Spearman korelasyonu (sıralı veriler için)

**Çıktılar:**
- Korelasyon katsayısı (r)
- p-değeri
- Korelasyon matrisi (çoklu değişken)

### 5. Partial Korelasyon
**Amaç:** Kontrol değişkenlerinin etkisini çıkararak korelasyon hesaplama

**Gereksinimler:**
- Ana değişkenler (en az 2)
- Kontrol değişkenleri

### 6. Regresyon Analizi
**Türler:**
- Basit regresyon (1 bağımsız değişken)
- Çoklu regresyon (birden fazla bağımsız değişken)

**Çıktılar:**
- Regresyon katsayıları
- R-kare değeri
- F-testi
- Standart hatalar
- p-değerleri

## 📈 Görselleştirme

### Otomatik Grafikler
- **Histogram:** Tek değişken dağılımı
- **Boxplot:** Grup karşılaştırmaları
- **Scatter Plot:** Korelasyon ve regresyon
- **Heatmap:** Korelasyon matrisi

### Grafik Özellikleri
- Yüksek çözünürlük
- İndirilebilir format (.png)
- Responsive tasarım

## 📄 Rapor Çıktıları

### Word Raporu (.docx)
- APA formatında tablolar
- Otomatik başlık ve tarih
- Profesyonel görünüm

### PDF Raporu (.pdf)
- Yazdırılabilir format
- Grafik ve tablo içerikli

### Grafik İndirme
- Yüksek çözünürlük (.png)
- Özelleştirilebilir boyutlar

## 🎯 Kullanım Adımları

### 1. Veri Yükleme
1. "Dosya Seç" butonuna tıklayın
2. CSV dosyanızı seçin
3. Veri önizlemesini kontrol edin

### 2. Analiz Seçimi
1. "Analiz Türü" menüsünden seçim yapın
2. Gerekli değişkenleri seçin
3. "Analizi Çalıştır" butonuna tıklayın

### 3. Sonuçları İnceleme
1. İstatistiksel sonuçları okuyun
2. Grafikleri inceleyin
3. Gerekirse raporları indirin

## ⚠️ Önemli Notlar

### Veri Kalitesi
- Eksik veriler otomatik olarak işlenir
- Aykırı değerler grafiklerde görünür
- Normallik varsayımları kontrol edilir

### İstatistiksel Güç
- Küçük örneklemler için uyarılar
- Etki büyüklüğü hesaplamaları
- Güven aralıkları (mümkün olduğunda)

### Yorumlama
- p < 0.05 istatistiksel anlamlılık
- Etki büyüklüğü pratik önem
- Grafikler görsel doğrulama

## 🔧 Sorun Giderme

### Yaygın Hatalar
1. **Dosya yüklenemiyor:** Format kontrol edin
2. **Analiz çalışmıyor:** Değişken türlerini kontrol edin
3. **Grafik görünmüyor:** Tarayıcıyı yenileyin

### Performans
- Büyük dosyalar için bekleme süresi
- Grafik oluşturma zamanı
- Rapor indirme süresi

## 📞 Destek

Sorunlarınız için:
- GitHub Issues kullanın
- Dokümantasyonu kontrol edin
- Örnek veri dosyasını test edin

---

**Geliştirici:** Ali Yalcinkaya  
**Versiyon:** 1.0  
**Tarih:** 2025
