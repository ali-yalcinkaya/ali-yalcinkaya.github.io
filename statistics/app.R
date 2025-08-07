# 📊 İstatistik Otomasyon Sistemi - Shiny Uygulaması
# Ali Yalcinkaya - https://ali-yalcinkaya.github.io/statistics/

# Gerekli paketleri yükle ve kütüphaneleri aç
required_packages <- c(
  "shiny", "tidyverse", "rstatix", "car", "emmeans",
  "apaTables", "ppcor", "officer", "flextable", "papaja",
  "DT", "shinyjs", "shinyWidgets", "plotly", "corrplot"
)

# Eksik paketleri yükle
missing_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(missing_packages) > 0) {
  install.packages(missing_packages)
}

# Kütüphaneleri yükle
lapply(required_packages, library, character.only = TRUE)

# UI tanımı
ui <- fluidPage(
  useShinyjs(),
  
  # CSS stilleri
  tags$head(
    tags$style(HTML("
      .main-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 10px;
        text-align: center;
      }
      .analysis-card {
        background: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 15px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      }
      .result-box {
        background: #f8f9fa;
        border-left: 4px solid #007bff;
        padding: 15px;
        margin: 10px 0;
        border-radius: 5px;
      }
      .download-btn {
        background: #28a745;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 5px;
        margin: 5px;
      }
      .download-btn:hover {
        background: #218838;
      }
    "))
  ),
  
  # Ana başlık
  div(class = "main-header",
      h1("📊 İstatistik Otomasyon Sistemi"),
      h4("CSV dosyalarınızı yükleyin, analizleri seçin, APA formatında raporlar alın")
  ),
  
  # Ana içerik
  fluidRow(
    # Sol panel - Veri yükleme ve analiz seçimi
    column(4,
           div(class = "analysis-card",
               h3("📁 Veri Yükleme"),
               fileInput("csv_file", "CSV dosyası seçin:",
                        accept = c(".csv", ".txt"),
                        buttonLabel = "Dosya Seç",
                        placeholder = "Dosya seçilmedi"),
               
               conditionalPanel(
                 condition = "input.csv_file != null",
                 hr(),
                 h4("📋 Veri Önizleme"),
                 DT::dataTableOutput("data_preview")
               )
           ),
           
           div(class = "analysis-card",
               h3("🔬 Analiz Türü"),
               selectInput("analysis_type", "Analiz seçin:",
                          choices = c(
                            "Betimsel İstatistikler" = "descriptive",
                            "T-test (Bağımsız)" = "ttest_independent",
                            "T-test (Eşleştirilmiş)" = "ttest_paired",
                            "ANOVA (Tek yönlü)" = "anova_oneway",
                            "ANOVA (Çok yönlü)" = "anova_twoway",
                            "Korelasyon (Pearson)" = "correlation_pearson",
                            "Korelasyon (Spearman)" = "correlation_spearman",
                            "Partial Korelasyon" = "partial_correlation",
                            "Basit Regresyon" = "regression_simple",
                            "Çoklu Regresyon" = "regression_multiple"
                          ),
                          selected = "descriptive")
           )
    ),
    
    # Orta panel - Değişken seçimi
    column(4,
           div(class = "analysis-card",
               h3("🎯 Değişken Seçimi"),
               conditionalPanel(
                 condition = "input.csv_file != null",
                 
                 # Bağımlı değişken seçimi
                 conditionalPanel(
                   condition = "input.analysis_type != 'descriptive' && input.analysis_type != 'correlation_pearson' && input.analysis_type != 'correlation_spearman' && input.analysis_type != 'partial_correlation'",
                   selectInput("dependent_var", "Bağımlı değişken:",
                              choices = NULL)
                 ),
                 
                 # Bağımsız değişken seçimi
                 conditionalPanel(
                   condition = "input.analysis_type == 'ttest_independent' || input.analysis_type == 'anova_oneway' || input.analysis_type == 'anova_twoway'",
                   selectInput("independent_var", "Bağımsız değişken (grup):",
                              choices = NULL)
                 ),
                 
                 # İkinci bağımsız değişken (ANOVA için)
                 conditionalPanel(
                   condition = "input.analysis_type == 'anova_twoway'",
                   selectInput("independent_var2", "İkinci bağımsız değişken:",
                              choices = NULL)
                 ),
                 
                 # Korelasyon değişkenleri
                 conditionalPanel(
                   condition = "input.analysis_type == 'correlation_pearson' || input.analysis_type == 'correlation_spearman'",
                   selectizeInput("correlation_vars", "Korelasyon değişkenleri (en az 2 seçin):",
                                 choices = NULL, multiple = TRUE)
                 ),
                 
                 # Partial korelasyon değişkenleri
                 conditionalPanel(
                   condition = "input.analysis_type == 'partial_correlation'",
                   selectizeInput("partial_vars", "Ana değişkenler (en az 2 seçin):",
                                 choices = NULL, multiple = TRUE),
                   selectizeInput("control_vars", "Kontrol değişkenleri:",
                                 choices = NULL, multiple = TRUE)
                 ),
                 
                 # Regresyon değişkenleri
                 conditionalPanel(
                   condition = "input.analysis_type == 'regression_simple'",
                   selectInput("regression_x", "Bağımsız değişken (X):",
                              choices = NULL)
                 ),
                 
                 conditionalPanel(
                   condition = "input.analysis_type == 'regression_multiple'",
                   selectizeInput("regression_x_multiple", "Bağımsız değişkenler (X):",
                                 choices = NULL, multiple = TRUE)
                 ),
                 
                 # Betimsel istatistik değişkenleri
                 conditionalPanel(
                   condition = "input.analysis_type == 'descriptive'",
                   selectizeInput("descriptive_vars", "Analiz edilecek değişkenler:",
                                 choices = NULL, multiple = TRUE),
                   checkboxInput("group_by_var", "Grupla betimsel istatistikler", FALSE),
                   conditionalPanel(
                     condition = "input.group_by_var == true",
                     selectInput("group_var", "Grup değişkeni:",
                                choices = NULL)
                   )
                 ),
                 
                 # Analiz butonu
                 actionButton("run_analysis", "🚀 Analizi Çalıştır",
                            class = "btn btn-primary btn-lg btn-block",
                            style = "background: #007bff; color: white; margin-top: 20px;")
               )
           )
    ),
    
    # Sağ panel - Sonuçlar
    column(4,
           div(class = "analysis-card",
               h3("📊 Sonuçlar"),
               conditionalPanel(
                 condition = "input.run_analysis > 0",
                 
                 # Sonuç tablosu
                 div(class = "result-box",
                     h4("📋 İstatistiksel Sonuçlar"),
                     verbatimTextOutput("analysis_results")
                 ),
                 
                 # Grafik
                 div(class = "result-box",
                     h4("📈 Görselleştirme"),
                     plotOutput("analysis_plot", height = "300px")
                 ),
                 
                 # İndirme butonları
                 div(class = "result-box",
                     h4("💾 İndirme Seçenekleri"),
                     downloadButton("download_docx", "📄 Word Raporu (.docx)",
                                   class = "download-btn"),
                     downloadButton("download_pdf", "📑 PDF Raporu (.pdf)",
                                   class = "download-btn"),
                     downloadButton("download_plot", "🖼️ Grafik (.png)",
                                   class = "download-btn")
                 )
               )
           )
    )
  )
)

# Server fonksiyonu
server <- function(input, output, session) {
  
  # Veri yükleme
  data <- reactive({
    req(input$csv_file)
    tryCatch({
      df <- read.csv(input$csv_file$datapath, header = TRUE, stringsAsFactors = FALSE)
      # Sayısal değişkenleri otomatik olarak dönüştür
      numeric_cols <- sapply(df, function(x) {
        if(is.character(x)) {
          !any(is.na(suppressWarnings(as.numeric(x))))
        } else {
          is.numeric(x)
        }
      })
      df[numeric_cols] <- lapply(df[numeric_cols], as.numeric)
      df
    }, error = function(e) {
      showNotification("Dosya yüklenirken hata oluştu!", type = "error")
      NULL
    })
  })
  
  # Veri önizleme
  output$data_preview <- DT::renderDataTable({
    req(data())
    DT::datatable(head(data(), 10),
                  options = list(pageLength = 5, scrollX = TRUE),
                  caption = "Veri Önizleme (İlk 10 satır)")
  })
  
  # Değişken seçeneklerini güncelle
  observe({
    req(data())
    vars <- names(data())
    numeric_vars <- names(data())[sapply(data(), is.numeric)]
    categorical_vars <- names(data())[sapply(data(), function(x) is.character(x) || is.factor(x))]
    
    # Bağımlı değişken seçenekleri
    updateSelectInput(session, "dependent_var", choices = numeric_vars)
    
    # Bağımsız değişken seçenekleri
    updateSelectInput(session, "independent_var", choices = vars)
    updateSelectInput(session, "independent_var2", choices = vars)
    
    # Korelasyon değişkenleri
    updateSelectizeInput(session, "correlation_vars", choices = numeric_vars)
    updateSelectizeInput(session, "partial_vars", choices = numeric_vars)
    updateSelectizeInput(session, "control_vars", choices = numeric_vars)
    
    # Regresyon değişkenleri
    updateSelectInput(session, "regression_x", choices = numeric_vars)
    updateSelectizeInput(session, "regression_x_multiple", choices = numeric_vars)
    
    # Betimsel istatistik değişkenleri
    updateSelectizeInput(session, "descriptive_vars", choices = numeric_vars, selected = numeric_vars)
    updateSelectInput(session, "group_var", choices = categorical_vars)
  })
  
  # Analiz sonuçları
  analysis_results <- reactive({
    req(input$run_analysis, data())
    
    tryCatch({
      df <- data()
      
      switch(input$analysis_type,
             
             # Betimsel İstatistikler
             "descriptive" = {
               if(input$group_by_var && !is.null(input$group_var)) {
                 # Gruplu betimsel istatistikler
                 desc_stats <- df %>%
                   group_by(!!sym(input$group_var)) %>%
                   summarise(across(all_of(input$descriptive_vars), list(
                     n = ~sum(!is.na(.)),
                     mean = ~mean(., na.rm = TRUE),
                     sd = ~sd(., na.rm = TRUE),
                     min = ~min(., na.rm = TRUE),
                     max = ~max(., na.rm = TRUE)
                   )), .groups = "drop") %>%
                   pivot_longer(cols = -all_of(input$group_var),
                               names_to = c("variable", "stat"),
                               names_pattern = "(.*)_(.*)") %>%
                   pivot_wider(names_from = stat, values_from = value)
                 
                 list(type = "descriptive_grouped", data = desc_stats)
               } else {
                 # Genel betimsel istatistikler
                 desc_stats <- df %>%
                   summarise(across(all_of(input$descriptive_vars), list(
                     n = ~sum(!is.na(.)),
                     mean = ~mean(., na.rm = TRUE),
                     sd = ~sd(., na.rm = TRUE),
                     min = ~min(., na.rm = TRUE),
                     max = ~max(., na.rm = TRUE)
                   ))) %>%
                   pivot_longer(everything(),
                               names_to = c("variable", "stat"),
                               names_pattern = "(.*)_(.*)") %>%
                   pivot_wider(names_from = stat, values_from = value)
                 
                 list(type = "descriptive", data = desc_stats)
               }
             },
             
             # T-test (Bağımsız)
             "ttest_independent" = {
               # Normallik testi
               groups <- unique(df[[input$independent_var]])
               g1_data <- df[[input$dependent_var]][df[[input$independent_var]] == groups[1]]
               g2_data <- df[[input$dependent_var]][df[[input$independent_var]] == groups[2]]
               
               shapiro1 <- shapiro.test(g1_data)
               shapiro2 <- shapiro.test(g2_data)
               levene <- car::leveneTest(df[[input$dependent_var]] ~ df[[input$independent_var]])
               
               # Uygun test seçimi
               if(shapiro1$p.value > 0.05 && shapiro2$p.value > 0.05) {
                 if(levene$`Pr(>F)`[1] > 0.05) {
                   test_result <- t.test(df[[input$dependent_var]] ~ df[[input$independent_var]], var.equal = TRUE)
                   test_type <- "Equal variance t-test"
                 } else {
                   test_result <- t.test(df[[input$dependent_var]] ~ df[[input$independent_var]], var.equal = FALSE)
                   test_type <- "Welch's t-test"
                 }
               } else {
                 test_result <- wilcox.test(df[[input$dependent_var]] ~ df[[input$independent_var]])
                 test_type <- "Mann-Whitney U test"
               }
               
               list(type = "ttest", 
                    test_result = test_result,
                    test_type = test_type,
                    normality = list(shapiro1 = shapiro1, shapiro2 = shapiro2, levene = levene))
             },
             
             # ANOVA
             "anova_oneway" = {
               anova_result <- anova_test(df, dv = !!sym(input$dependent_var), between = !!sym(input$independent_var))
               list(type = "anova", data = anova_result)
             },
             
             # Korelasyon
             "correlation_pearson" = {
               cor_vars <- input$correlation_vars
               if(length(cor_vars) >= 2) {
                 cor_data <- df[complete.cases(df[cor_vars]), cor_vars]
                 cor_matrix <- cor(cor_data, method = "pearson")
                 cor_test <- cor.test(cor_data[[1]], cor_data[[2]], method = "pearson")
                 list(type = "correlation", matrix = cor_matrix, test = cor_test, method = "pearson")
               }
             },
             
             "correlation_spearman" = {
               cor_vars <- input$correlation_vars
               if(length(cor_vars) >= 2) {
                 cor_data <- df[complete.cases(df[cor_vars]), cor_vars]
                 cor_matrix <- cor(cor_data, method = "spearman")
                 cor_test <- cor.test(cor_data[[1]], cor_data[[2]], method = "spearman")
                 list(type = "correlation", matrix = cor_matrix, test = cor_test, method = "spearman")
               }
             },
             
             # Partial Korelasyon
             "partial_correlation" = {
               partial_vars <- input$partial_vars
               control_vars <- input$control_vars
               if(length(partial_vars) >= 2) {
                 all_vars <- c(partial_vars, control_vars)
                 pcor_data <- df[complete.cases(df[all_vars]), all_vars]
                 pcor_result <- ppcor::pcor(pcor_data, method = "pearson")
                 list(type = "partial_correlation", 
                      estimate = pcor_result$estimate[partial_vars, partial_vars],
                      p_value = pcor_result$p.value[partial_vars, partial_vars])
               }
             },
             
             # Basit Regresyon
             "regression_simple" = {
               lm_result <- lm(as.formula(paste(input$dependent_var, "~", input$regression_x)), data = df)
               list(type = "regression", model = lm_result)
             },
             
             # Çoklu Regresyon
             "regression_multiple" = {
               formula_str <- paste(input$dependent_var, "~", paste(input$regression_x_multiple, collapse = "+"))
               lm_result <- lm(as.formula(formula_str), data = df)
               list(type = "regression", model = lm_result)
             }
      )
    }, error = function(e) {
      showNotification(paste("Analiz hatası:", e$message), type = "error")
      NULL
    })
  })
  
  # Sonuçları göster
  output$analysis_results <- renderPrint({
    req(analysis_results())
    results <- analysis_results()
    
    switch(results$type,
           "descriptive" = {
             cat("📊 BETİMSEL İSTATİSTİKLER\n")
             cat("=", 50, "\n")
             print(results$data)
           },
           "descriptive_grouped" = {
             cat("📊 GRUPLU BETİMSEL İSTATİSTİKLER\n")
             cat("=", 50, "\n")
             print(results$data)
           },
           "ttest" = {
             cat("📊 T-TEST SONUÇLARI\n")
             cat("=", 50, "\n")
             cat("Test Türü:", results$test_type, "\n")
             cat("Normallik Testleri (Shapiro-Wilk):\n")
             cat("  Grup 1 p-değeri:", round(results$normality$shapiro1$p.value, 4), "\n")
             cat("  Grup 2 p-değeri:", round(results$normality$shapiro2$p.value, 4), "\n")
             cat("Levene Testi p-değeri:", round(results$normality$levene$`Pr(>F)`[1], 4), "\n\n")
             print(results$test_result)
           },
           "anova" = {
             cat("📊 ANOVA SONUÇLARI\n")
             cat("=", 50, "\n")
             print(results$data)
           },
           "correlation" = {
             cat("📊 KORELASYON ANALİZİ\n")
             cat("=", 50, "\n")
             cat("Yöntem:", results$method, "\n\n")
             cat("Korelasyon Matrisi:\n")
             print(round(results$matrix, 3))
             cat("\nKorelasyon Testi:\n")
             print(results$test)
           },
           "partial_correlation" = {
             cat("📊 PARTIAL KORELASYON ANALİZİ\n")
             cat("=", 50, "\n")
             cat("Korelasyon Katsayıları:\n")
             print(round(results$estimate, 3))
             cat("\nP-değerleri:\n")
             print(round(results$p_value, 4))
           },
           "regression" = {
             cat("📊 REGRESYON ANALİZİ\n")
             cat("=", 50, "\n")
             print(summary(results$model))
           }
    )
  })
  
  # Grafik oluştur
  output$analysis_plot <- renderPlot({
    req(analysis_results(), data())
    results <- analysis_results()
    df <- data()
    
    switch(results$type,
           "descriptive" = {
             # Histogram
             if(length(input$descriptive_vars) == 1) {
               ggplot(df, aes_string(x = input$descriptive_vars[1])) +
                 geom_histogram(fill = "steelblue", alpha = 0.7, bins = 30) +
                 labs(title = paste("Histogram:", input$descriptive_vars[1]),
                      x = input$descriptive_vars[1], y = "Frekans") +
                 theme_minimal()
             } else {
               # Boxplot
               df_long <- df %>%
                 select(all_of(input$descriptive_vars)) %>%
                 pivot_longer(everything(), names_to = "variable", values_to = "value")
               
               ggplot(df_long, aes(x = variable, y = value)) +
                 geom_boxplot(fill = "steelblue", alpha = 0.7) +
                 labs(title = "Değişken Dağılımları", x = "Değişken", y = "Değer") +
                 theme_minimal() +
                 theme(axis.text.x = element_text(angle = 45, hjust = 1))
             }
           },
           "descriptive_grouped" = {
             # Gruplu boxplot
             ggplot(df, aes_string(x = input$group_var, y = input$descriptive_vars[1], fill = input$group_var)) +
               geom_boxplot(alpha = 0.7) +
               labs(title = paste(input$descriptive_vars[1], "by", input$group_var),
                    x = input$group_var, y = input$descriptive_vars[1]) +
               theme_minimal()
           },
           "ttest" = {
             # Boxplot
             ggplot(df, aes_string(x = input$independent_var, y = input$dependent_var, fill = input$independent_var)) +
               geom_boxplot(alpha = 0.7) +
               geom_jitter(width = 0.2, alpha = 0.5) +
               labs(title = paste("T-test:", input$dependent_var, "by", input$independent_var),
                    x = input$independent_var, y = input$dependent_var) +
               theme_minimal()
           },
           "anova" = {
             # Boxplot
             ggplot(df, aes_string(x = input$independent_var, y = input$dependent_var, fill = input$independent_var)) +
               geom_boxplot(alpha = 0.7) +
               geom_jitter(width = 0.2, alpha = 0.5) +
               labs(title = paste("ANOVA:", input$dependent_var, "by", input$independent_var),
                    x = input$independent_var, y = input$dependent_var) +
               theme_minimal()
           },
           "correlation" = {
             # Scatter plot
             if(length(input$correlation_vars) == 2) {
               ggplot(df, aes_string(x = input$correlation_vars[1], y = input$correlation_vars[2])) +
                 geom_point(alpha = 0.7) +
                 geom_smooth(method = "lm", se = TRUE, color = "red") +
                 labs(title = paste("Korelasyon:", input$correlation_vars[1], "vs", input$correlation_vars[2]),
                      x = input$correlation_vars[1], y = input$correlation_vars[2]) +
                 theme_minimal()
             } else {
               # Correlation heatmap
               corrplot(results$matrix, method = "color", type = "upper", 
                       order = "hclust", tl.cex = 0.8, tl.col = "black")
             }
           },
           "partial_correlation" = {
             # Partial correlation heatmap
             corrplot(results$estimate, method = "color", type = "upper", 
                     order = "hclust", tl.cex = 0.8, tl.col = "black")
           },
           "regression" = {
             # Regression plot
             if(input$analysis_type == "regression_simple") {
               ggplot(df, aes_string(x = input$regression_x, y = input$dependent_var)) +
                 geom_point(alpha = 0.7) +
                 geom_smooth(method = "lm", se = TRUE, color = "blue") +
                 labs(title = paste("Regresyon:", input$dependent_var, "~", input$regression_x),
                      x = input$regression_x, y = input$dependent_var) +
                 theme_minimal()
             } else {
               # Residual plot for multiple regression
               plot(results$model, which = 1)
             }
           }
    )
  })
  
  # Word raporu indirme
  output$download_docx <- downloadHandler(
    filename = function() {
      paste0("istatistik_raporu_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".docx")
    },
    content = function(file) {
      req(analysis_results())
      results <- analysis_results()
      
      # Word dokümanı oluştur
      doc <- read_docx()
      
      # Başlık
      doc <- doc %>%
        body_add_par("İstatistik Analiz Raporu", style = "heading 1") %>%
        body_add_par(paste("Tarih:", format(Sys.time(), "%d/%m/%Y %H:%M")), style = "Normal") %>%
        body_add_par("", style = "Normal")
      
      # Analiz türü
      doc <- doc %>%
        body_add_par(paste("Analiz Türü:", input$analysis_type), style = "heading 2")
      
      # Sonuçları ekle
      switch(results$type,
             "descriptive" = {
               ft <- flextable(results$data) %>%
                 set_caption("Betimsel İstatistikler") %>%
                 theme_vanilla() %>%
                 autofit()
               doc <- doc %>% body_add_flextable(ft)
             },
             "ttest" = {
               doc <- doc %>%
                 body_add_par(paste("Test Türü:", results$test_type), style = "Normal") %>%
                 body_add_par(paste("t =", round(results$test_result$statistic, 3)), style = "Normal") %>%
                 body_add_par(paste("df =", round(results$test_result$parameter, 1)), style = "Normal") %>%
                 body_add_par(paste("p =", round(results$test_result$p.value, 4)), style = "Normal")
             }
      )
      
      # Kaydet
      print(doc, target = file)
    }
  )
  
  # PDF raporu indirme
  output$download_pdf <- downloadHandler(
    filename = function() {
      paste0("istatistik_raporu_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".pdf")
    },
    content = function(file) {
      # PDF oluşturma (basit versiyon)
      pdf(file, width = 10, height = 8)
      req(analysis_results())
      results <- analysis_results()
      
      # Başlık
      plot(1, 1, type = "n", axes = FALSE, xlab = "", ylab = "")
      text(1, 1, "İstatistik Analiz Raporu", cex = 2, font = 2)
      text(1, 0.8, paste("Tarih:", format(Sys.time(), "%d/%m/%Y %H:%M")), cex = 1.2)
      text(1, 0.6, paste("Analiz Türü:", input$analysis_type), cex = 1.2)
      
      # Grafik ekle
      output$analysis_plot()
      
      dev.off()
    }
  )
  
  # Grafik indirme
  output$download_plot <- downloadHandler(
    filename = function() {
      paste0("grafik_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".png")
    },
    content = function(file) {
      ggsave(file, plot = last_plot(), width = 8, height = 6, dpi = 300)
    }
  )
}

# Uygulamayı çalıştır
shinyApp(ui = ui, server = server)
