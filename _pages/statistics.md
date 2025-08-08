---
layout: page
title: İstatistik Otomasyon Sistemi
permalink: /statistics/
---

<div class="stats-container">
    <div class="stats-header">
        <h1>📊 İstatistik Otomasyon Sistemi</h1>
        <p>CSV dosyalarınızı yükleyin, analizleri seçin, APA formatında raporlar alın!</p>
    </div>

    <div class="stats-content">
        <!-- Veri Yükleme Bölümü -->
        <div class="upload-section">
            <h3>📁 Veri Yükleme</h3>
            <div class="file-upload-area" id="fileUploadArea">
                <input type="file" id="csvFile" accept=".csv" style="display: none;">
                <div class="upload-placeholder">
                    <span class="upload-icon">📁</span>
                    <p>CSV dosyanızı buraya sürükleyin veya tıklayın</p>
                    <button class="upload-btn" onclick="document.getElementById('csvFile').click()">Dosya Seç</button>
                </div>
            </div>
            <div id="fileInfo" style="display: none;">
                <p><strong>Yüklenen dosya:</strong> <span id="fileName"></span></p>
                <button class="btn-secondary" onclick="resetFile()">Yeni Dosya Yükle</button>
            </div>
        </div>

        <!-- Veri Önizleme -->
        <div class="preview-section" id="previewSection" style="display: none;">
            <h3>📋 Veri Önizleme</h3>
            <div class="table-container">
                <table id="dataTable" class="data-table">
                    <thead id="tableHeader"></thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>
        </div>

        <!-- Analiz Seçimi -->
        <div class="analysis-section" id="analysisSection" style="display: none;">
            <h3>🔬 Analiz Türü Seçimi</h3>
            <div class="analysis-options">
                <select id="analysisType" class="analysis-select">
                    <option value="">Analiz türünü seçin...</option>
                    <option value="descriptive">📊 Betimsel İstatistikler</option>
                    <option value="ttest">📈 T-test (Bağımsız/Eşleştirilmiş)</option>
                    <option value="anova">📊 ANOVA (Tek yönlü/Çok yönlü)</option>
                    <option value="correlation">🔗 Korelasyon Analizi</option>
                    <option value="partial_correlation">🔗 Partial Korelasyon</option>
                    <option value="regression">📈 Regresyon Analizi</option>
                </select>
            </div>

            <!-- Değişken Seçimi -->
            <div class="variable-selection" id="variableSelection" style="display: none;">
                <h4>📝 Değişken Seçimi</h4>
                <div class="variable-grid">
                    <div class="variable-group">
                        <label>Bağımlı Değişken:</label>
                        <select id="dependentVar" class="variable-select"></select>
                    </div>
                    <div class="variable-group">
                        <label>Bağımsız Değişken:</label>
                        <select id="independentVar" class="variable-select"></select>
                    </div>
                    <div class="variable-group" id="controlVarGroup" style="display: none;">
                        <label>Kontrol Değişkeni:</label>
                        <select id="controlVar" class="variable-select"></select>
                    </div>
                </div>
                <button class="run-analysis-btn" onclick="runAnalysis()">🚀 Analizi Çalıştır</button>
            </div>
        </div>

        <!-- Sonuçlar -->
        <div class="results-section" id="resultsSection" style="display: none;">
            <h3>📊 Analiz Sonuçları</h3>
            <div class="results-content">
                <div class="results-text" id="resultsText"></div>
                <div class="results-plot" id="resultsPlot"></div>
            </div>
            
            <!-- İndirme Butonları -->
            <div class="download-section">
                <h4>📄 Rapor İndirme</h4>
                <div class="download-buttons">
                    <button class="download-btn" onclick="downloadReport('docx')">📄 Word Raporu İndir</button>
                    <button class="download-btn" onclick="downloadReport('pdf')">📄 PDF Raporu İndir</button>
                    <button class="download-btn" onclick="downloadPlot()">📊 Grafik İndir</button>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.stats-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.stats-header {
    text-align: center;
    margin-bottom: 40px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px;
    border-radius: 15px;
}

.stats-header h1 {
    font-size: 2.5rem;
    margin-bottom: 15px;
}

.stats-header p {
    font-size: 1.2rem;
    opacity: 0.9;
}

.stats-content {
    background: white;
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.upload-section, .preview-section, .analysis-section, .results-section {
    margin-bottom: 30px;
    padding: 20px;
    border: 1px solid #e0e0e0;
    border-radius: 10px;
}

.upload-section h3, .preview-section h3, .analysis-section h3, .results-section h3 {
    color: #667eea;
    margin-bottom: 20px;
    font-size: 1.5rem;
}

.file-upload-area {
    border: 2px dashed #667eea;
    border-radius: 10px;
    padding: 40px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
}

.file-upload-area:hover {
    background: #f8f9fa;
    border-color: #764ba2;
}

.upload-placeholder {
    color: #666;
}

.upload-icon {
    font-size: 3rem;
    display: block;
    margin-bottom: 15px;
}

.upload-btn {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    padding: 12px 25px;
    border-radius: 25px;
    font-size: 1rem;
    cursor: pointer;
    margin-top: 15px;
    transition: all 0.3s ease;
}

.upload-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.btn-secondary {
    background: #6c757d;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 10px;
}

.table-container {
    overflow-x: auto;
    max-height: 400px;
    overflow-y: auto;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.9rem;
}

.data-table th, .data-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

.data-table th {
    background: #667eea;
    color: white;
    position: sticky;
    top: 0;
}

.analysis-select, .variable-select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 1rem;
    margin-bottom: 15px;
}

.variable-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 20px;
}

.variable-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #333;
}

.run-analysis-btn {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    color: white;
    border: none;
    padding: 15px 30px;
    border-radius: 25px;
    font-size: 1.1rem;
    cursor: pointer;
    transition: all 0.3s ease;
}

.run-analysis-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.results-content {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 20px;
}

.results-text {
    margin-bottom: 20px;
    line-height: 1.6;
}

.results-plot {
    text-align: center;
    padding: 20px;
    background: white;
    border-radius: 8px;
    border: 1px solid #e0e0e0;
}

.download-buttons {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

.download-btn {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    padding: 12px 20px;
    border-radius: 25px;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.3s ease;
}

.download-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

@media (max-width: 768px) {
    .stats-header h1 {
        font-size: 2rem;
    }
    
    .variable-grid {
        grid-template-columns: 1fr;
    }
    
    .download-buttons {
        flex-direction: column;
    }
}
</style>

<script>
let uploadedData = null;
let analysisResults = null;

// Dosya yükleme işlemleri
document.getElementById('csvFile').addEventListener('change', handleFileUpload);
document.getElementById('fileUploadArea').addEventListener('dragover', handleDragOver);
document.getElementById('fileUploadArea').addEventListener('drop', handleDrop);

function handleDragOver(e) {
    e.preventDefault();
    e.currentTarget.style.background = '#f8f9fa';
}

function handleDrop(e) {
    e.preventDefault();
    e.currentTarget.style.background = 'white';
    const files = e.dataTransfer.files;
    if (files.length > 0) {
        processFile(files[0]);
    }
}

function handleFileUpload(e) {
    const file = e.target.files[0];
    if (file) {
        processFile(file);
    }
}

function processFile(file) {
    if (file.type !== 'text/csv' && !file.name.endsWith('.csv')) {
        alert('Lütfen geçerli bir CSV dosyası seçin!');
        return;
    }

    const reader = new FileReader();
    reader.onload = function(e) {
        const csv = e.target.result;
        uploadedData = parseCSV(csv);
        
        document.getElementById('fileName').textContent = file.name;
        document.getElementById('fileInfo').style.display = 'block';
        document.getElementById('previewSection').style.display = 'block';
        document.getElementById('analysisSection').style.display = 'block';
        
        displayDataPreview(uploadedData);
        populateVariableSelects(uploadedData);
    };
    reader.readAsText(file);
}

function parseCSV(csv) {
    const lines = csv.split('\n');
    const headers = lines[0].split(',').map(h => h.trim().replace(/"/g, ''));
    const data = [];
    
    for (let i = 1; i < Math.min(lines.length, 11); i++) { // İlk 10 satır
        if (lines[i].trim()) {
            const values = lines[i].split(',').map(v => v.trim().replace(/"/g, ''));
            const row = {};
            headers.forEach((header, index) => {
                row[header] = values[index] || '';
            });
            data.push(row);
        }
    }
    
    return { headers, data };
}

function displayDataPreview(data) {
    const tableHeader = document.getElementById('tableHeader');
    const tableBody = document.getElementById('tableBody');
    
    // Header
    tableHeader.innerHTML = '';
    const headerRow = document.createElement('tr');
    data.headers.forEach(header => {
        const th = document.createElement('th');
        th.textContent = header;
        headerRow.appendChild(th);
    });
    tableHeader.appendChild(headerRow);
    
    // Body
    tableBody.innerHTML = '';
    data.data.forEach(row => {
        const tr = document.createElement('tr');
        data.headers.forEach(header => {
            const td = document.createElement('td');
            td.textContent = row[header];
            tr.appendChild(td);
        });
        tableBody.appendChild(tr);
    });
}

function populateVariableSelects(data) {
    const selects = ['dependentVar', 'independentVar', 'controlVar'];
    selects.forEach(selectId => {
        const select = document.getElementById(selectId);
        select.innerHTML = '<option value="">Seçin...</option>';
        data.headers.forEach(header => {
            const option = document.createElement('option');
            option.value = header;
            option.textContent = header;
            select.appendChild(option);
        });
    });
}

function resetFile() {
    uploadedData = null;
    document.getElementById('csvFile').value = '';
    document.getElementById('fileInfo').style.display = 'none';
    document.getElementById('previewSection').style.display = 'none';
    document.getElementById('analysisSection').style.display = 'none';
    document.getElementById('resultsSection').style.display = 'none';
}

// Analiz türü değiştiğinde
document.getElementById('analysisType').addEventListener('change', function() {
    const analysisType = this.value;
    const variableSelection = document.getElementById('variableSelection');
    const controlVarGroup = document.getElementById('controlVarGroup');
    
    if (analysisType) {
        variableSelection.style.display = 'block';
        
        // Partial correlation için kontrol değişkeni göster
        if (analysisType === 'partial_correlation') {
            controlVarGroup.style.display = 'block';
        } else {
            controlVarGroup.style.display = 'none';
        }
    } else {
        variableSelection.style.display = 'none';
    }
});

function runAnalysis() {
    const analysisType = document.getElementById('analysisType').value;
    const dependentVar = document.getElementById('dependentVar').value;
    const independentVar = document.getElementById('independentVar').value;
    
    if (!analysisType || !dependentVar || !independentVar) {
        alert('Lütfen tüm gerekli alanları doldurun!');
        return;
    }
    
    // Simüle edilmiş analiz sonuçları
    analysisResults = generateMockResults(analysisType, dependentVar, independentVar);
    displayResults(analysisResults);
}

function generateMockResults(analysisType, dependentVar, independentVar) {
    const results = {
        type: analysisType,
        dependent: dependentVar,
        independent: independentVar,
        timestamp: new Date().toLocaleString('tr-TR')
    };
    
    switch(analysisType) {
        case 'descriptive':
            results.summary = {
                mean: (Math.random() * 100).toFixed(2),
                sd: (Math.random() * 20).toFixed(2),
                min: (Math.random() * 50).toFixed(2),
                max: (Math.random() * 150 + 50).toFixed(2)
            };
            break;
        case 'ttest':
            results.summary = {
                t_value: (Math.random() * 5).toFixed(3),
                p_value: (Math.random() * 0.1).toFixed(4),
                df: Math.floor(Math.random() * 50) + 20,
                effect_size: (Math.random() * 1).toFixed(3)
            };
            break;
        case 'anova':
            results.summary = {
                f_value: (Math.random() * 10).toFixed(3),
                p_value: (Math.random() * 0.1).toFixed(4),
                df_between: Math.floor(Math.random() * 5) + 1,
                df_within: Math.floor(Math.random() * 50) + 20,
                eta_squared: (Math.random() * 0.5).toFixed(3)
            };
            break;
        case 'correlation':
            results.summary = {
                r_value: (Math.random() * 2 - 1).toFixed(3),
                p_value: (Math.random() * 0.1).toFixed(4),
                n: Math.floor(Math.random() * 100) + 50
            };
            break;
        case 'regression':
            results.summary = {
                r_squared: (Math.random() * 1).toFixed(3),
                f_value: (Math.random() * 20).toFixed(3),
                p_value: (Math.random() * 0.1).toFixed(4),
                beta: (Math.random() * 2 - 1).toFixed(3)
            };
            break;
    }
    
    return results;
}

function displayResults(results) {
    const resultsSection = document.getElementById('resultsSection');
    const resultsText = document.getElementById('resultsText');
    const resultsPlot = document.getElementById('resultsPlot');
    
    // Metin sonuçları
    let textContent = `<h4>${getAnalysisTitle(results.type)}</h4>`;
    textContent += `<p><strong>Bağımlı Değişken:</strong> ${results.dependent}</p>`;
    textContent += `<p><strong>Bağımsız Değişken:</strong> ${results.independent}</p>`;
    textContent += `<p><strong>Analiz Tarihi:</strong> ${results.timestamp}</p><br>`;
    
    // İstatistiksel sonuçlar
    textContent += '<h5>İstatistiksel Sonuçlar:</h5>';
    Object.entries(results.summary).forEach(([key, value]) => {
        const label = getStatisticLabel(key);
        textContent += `<p><strong>${label}:</strong> ${value}</p>`;
    });
    
    // Yorum
    textContent += '<br><h5>Yorum:</h5>';
    textContent += getInterpretation(results);
    
    resultsText.innerHTML = textContent;
    
    // Basit grafik (simüle edilmiş)
    resultsPlot.innerHTML = `
        <div style="width: 400px; height: 300px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                    border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; margin: 0 auto;">
            <div style="text-align: center;">
                <h4>📊 ${getAnalysisTitle(results.type)}</h4>
                <p>Grafik burada görüntülenecek</p>
                <p style="font-size: 0.9rem; opacity: 0.8;">(Gerçek uygulamada ggplot2 grafikleri gösterilir)</p>
            </div>
        </div>
    `;
    
    resultsSection.style.display = 'block';
}

function getAnalysisTitle(type) {
    const titles = {
        'descriptive': 'Betimsel İstatistikler',
        'ttest': 'T-test Analizi',
        'anova': 'ANOVA Analizi',
        'correlation': 'Korelasyon Analizi',
        'partial_correlation': 'Partial Korelasyon Analizi',
        'regression': 'Regresyon Analizi'
    };
    return titles[type] || 'İstatistiksel Analiz';
}

function getStatisticLabel(key) {
    const labels = {
        'mean': 'Ortalama',
        'sd': 'Standart Sapma',
        'min': 'Minimum',
        'max': 'Maksimum',
        't_value': 't-değeri',
        'p_value': 'p-değeri',
        'df': 'Serbestlik Derecesi',
        'effect_size': 'Etki Büyüklüğü',
        'f_value': 'F-değeri',
        'df_between': 'Gruplar Arası SD',
        'df_within': 'Gruplar İçi SD',
        'eta_squared': 'Eta-kare',
        'r_value': 'Korelasyon Katsayısı',
        'n': 'Örneklem Büyüklüğü',
        'r_squared': 'R-kare',
        'beta': 'Beta Katsayısı'
    };
    return labels[key] || key;
}

function getInterpretation(results) {
    const p = results.summary.p_value;
    let interpretation = '';
    
    if (p < 0.001) {
        interpretation = 'Sonuçlar istatistiksel olarak çok anlamlıdır (p < 0.001).';
    } else if (p < 0.01) {
        interpretation = 'Sonuçlar istatistiksel olarak çok anlamlıdır (p < 0.01).';
    } else if (p < 0.05) {
        interpretation = 'Sonuçlar istatistiksel olarak anlamlıdır (p < 0.05).';
    } else {
        interpretation = 'Sonuçlar istatistiksel olarak anlamlı değildir (p > 0.05).';
    }
    
    return interpretation;
}

function downloadReport(format) {
    if (!analysisResults) {
        alert('Önce bir analiz çalıştırın!');
        return;
    }
    
    // Simüle edilmiş indirme
    const content = generateReportContent(analysisResults, format);
    const blob = new Blob([content], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `istatistik_raporu_${new Date().toISOString().split('T')[0]}.${format}`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    
    alert(`${format.toUpperCase()} raporu indiriliyor...`);
}

function downloadPlot() {
    if (!analysisResults) {
        alert('Önce bir analiz çalıştırın!');
        return;
    }
    
    alert('Grafik PNG formatında indiriliyor...');
}

function generateReportContent(results, format) {
    let content = `İSTATİSTİK RAPORU\n`;
    content += `==================\n\n`;
    content += `Analiz Türü: ${getAnalysisTitle(results.type)}\n`;
    content += `Bağımlı Değişken: ${results.dependent}\n`;
    content += `Bağımsız Değişken: ${results.independent}\n`;
    content += `Tarih: ${results.timestamp}\n\n`;
    
    content += `SONUÇLAR:\n`;
    Object.entries(results.summary).forEach(([key, value]) => {
        const label = getStatisticLabel(key);
        content += `${label}: ${value}\n`;
    });
    
    content += `\nYORUM:\n${getInterpretation(results)}\n`;
    
    return content;
}
</script>
