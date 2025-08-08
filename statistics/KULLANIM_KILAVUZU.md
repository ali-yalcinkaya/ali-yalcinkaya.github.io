# 📊 İstatistik Otomasyon Sistemi - Kullanım Kılavuzu

## 🎯 Sistem Hakkında

Bu sistem, GitHub Pages üzerinde çalışan interaktif bir istatistik analiz aracıdır. CSV dosyalarınızı yükleyerek çeşitli istatistiksel analizler gerçekleştirebilir ve sonuçları görselleştirebilirsiniz.

## 🚀 Hızlı Başlangıç

### 1. Veri Hazırlama
- Verilerinizi CSV formatında hazırlayın
- İlk satır sütun başlıklarını içermelidir
- Sayısal değişkenler için sayısal değerler kullanın
- Kategorik değişkenler için metin değerleri kullanabilirsiniz

### 2. Dosya Yükleme
- "Dosya Seç" butonuna tıklayın veya dosyayı sürükleyip bırakın
- Sistem otomatik olarak CSV dosyanızı okuyacak ve önizleme gösterecektir

### 3. Analiz Seçimi
- Analiz türünü dropdown menüden seçin
- Bağımlı ve bağımsız değişkenleri belirleyin
- "Analizi Çalıştır" butonuna tıklayın

## 📋 Desteklenen Analizler

### 📊 Betimsel İstatistikler
- **Amaç:** Veri setinin genel özelliklerini özetleme
- **Çıktılar:** Ortalama, standart sapma, minimum, maksimum
- **Kullanım:** Tek değişken seçin

### 📈 T-test Analizi
- **Amaç:** İki grup arasında ortalama farkı test etme
- **Türler:** Bağımsız t-test, eşleştirilmiş t-test
- **Çıktılar:** t-değeri, p-değeri, etki büyüklüğü
- **Kullanım:** Bağımlı değişken (sürekli), bağımsız değişken (kategorik)

### 📊 ANOVA Analizi
- **Amaç:** İkiden fazla grup arasında ortalama farkı test etme
- **Türler:** Tek yönlü ANOVA, çok yönlü ANOVA
- **Çıktılar:** F-değeri, p-değeri, eta-kare
- **Kullanım:** Bağımlı değişken (sürekli), bağımsız değişken (kategorik)

### 🔗 Korelasyon Analizi
- **Amaç:** İki değişken arasındaki ilişkiyi ölçme
- **Türler:** Pearson korelasyonu, Spearman korelasyonu
- **Çıktılar:** Korelasyon katsayısı, p-değeri
- **Kullanım:** İki sürekli değişken seçin

### 🔗 Partial Korelasyon
- **Amaç:** Üçüncü değişkenin etkisini kontrol ederek korelasyon
- **Çıktılar:** Partial korelasyon katsayısı, p-değeri
- **Kullanım:** İki ana değişken + bir kontrol değişkeni

### 📈 Regresyon Analizi
- **Amaç:** Değişkenler arasındaki tahmin ilişkisini modelleme
- **Türler:** Basit regresyon, çoklu regresyon
- **Çıktılar:** R-kare, F-değeri, beta katsayıları
- **Kullanım:** Bağımlı değişken + bir veya daha fazla bağımsız değişken

## 📊 Veri Formatı Örnekleri

### Örnek 1: Grup Karşılaştırması
```csv
ID,Grup,Performans
1,Kontrol,85
2,Kontrol,82
3,Deney,92
4,Deney,95
```

### Örnek 2: Korelasyon Analizi
```csv
ID,Yas,Anksiyete
1,25,45
2,28,38
3,22,42
4,30,35
```

### Örnek 3: Çoklu Değişken
```csv
ID,Grup,Yas,Cinsiyet,Anksiyete,Depresyon,IQ,Performans
1,Kontrol,25,K,45,32,110,85
2,Deney,24,E,52,45,115,92
```

## 🎨 Görselleştirme Özellikleri

### 📈 Grafik Türleri
- **Boxplot:** Grup karşılaştırmaları için
- **Scatter Plot:** Korelasyon analizleri için
- **Histogram:** Dağılım analizleri için
- **Bar Chart:** Kategorik veriler için

### 📊 Grafik Özellikleri
- İnteraktif grafikler
- Zoom ve pan özellikleri
- Grafik indirme (PNG formatında)
- Özelleştirilebilir renkler ve temalar

## 📄 Rapor Çıktıları

### 📄 Word Raporu (.docx)
- APA formatında düzenlenmiş
- Tablolar ve grafikler dahil
- Metodoloji ve sonuç bölümleri
- Referans listesi

### 📄 PDF Raporu (.pdf)
- Yüksek kaliteli baskı için optimize
- Tüm grafikler ve tablolar dahil
- Akademik standartlara uygun

### 📊 Grafik İndirme
- PNG formatında yüksek çözünürlük
- Özelleştirilebilir boyutlar
- Şeffaf arka plan seçeneği

## ⚠️ Önemli Notlar

### 📋 Veri Gereksinimleri
- CSV formatında dosyalar
- UTF-8 karakter kodlaması
- Virgül ile ayrılmış değerler
- İlk satır sütun başlıkları

### 🔍 Analiz Öncesi Kontroller
- Eksik veriler otomatik tespit edilir
- Normallik kontrolü yapılır
- Varyans homojenliği test edilir
- Uygun analiz türü önerilir

### 📊 Sonuç Yorumlama
- p < 0.05 istatistiksel anlamlılık
- Etki büyüklüğü değerlendirmesi
- Güven aralıkları hesaplanır
- Post-hoc testler otomatik uygulanır

## 🛠️ Teknik Detaylar

### 💻 Kullanılan Teknolojiler
- **Frontend:** HTML5, CSS3, JavaScript
- **Veri İşleme:** Papa Parse (CSV parsing)
- **Görselleştirme:** Chart.js, D3.js
- **Raporlama:** jsPDF, docx.js

### 🔧 Sistem Gereksinimleri
- Modern web tarayıcısı (Chrome, Firefox, Safari, Edge)
- JavaScript etkin
- İnternet bağlantısı (GitHub Pages erişimi için)

### 📱 Responsive Tasarım
- Mobil cihazlarda uyumlu
- Tablet ve masaüstü optimizasyonu
- Dokunmatik ekran desteği

## 🆘 Sorun Giderme

### ❌ Yaygın Hatalar
1. **Dosya yüklenemiyor:** CSV formatını kontrol edin
2. **Analiz çalışmıyor:** Değişken türlerini kontrol edin
3. **Sonuçlar görünmüyor:** Tarayıcı konsolunu kontrol edin

### 🔧 Çözümler
- Dosya formatını kontrol edin
- Değişken seçimlerini gözden geçirin
- Tarayıcıyı yenileyin
- Farklı bir tarayıcı deneyin

## 📞 Destek

### 🆘 Yardım Alma
- Bu kılavuzu okuyun
- Örnek veri dosyalarını inceleyin
- GitHub repository'sini ziyaret edin

### 📧 İletişim
- GitHub Issues kullanın
- E-posta ile iletişime geçin
- Dokümantasyonu kontrol edin

## 🔄 Güncellemeler

### 📈 Gelecek Özellikler
- Daha fazla analiz türü
- Gelişmiş görselleştirmeler
- Otomatik rapor önerileri
- Makine öğrenmesi entegrasyonu

### 🐛 Hata Düzeltmeleri
- Düzenli güncellemeler
- Performans iyileştirmeleri
- Güvenlik güncellemeleri

---

**Not:** Bu sistem eğitim ve araştırma amaçlı geliştirilmiştir. Kritik analizler için profesyonel istatistik yazılımları kullanmanız önerilir.
