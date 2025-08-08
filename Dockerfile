# Dockerfile for İstatistik Otomasyon Sistemi
# Ali Yalcinkaya - https://ali-yalcinkaya.github.io/statistics/

FROM rocker/shiny:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgdal-dev \
    libproj-dev \
    libgeos-dev \
    libgsl-dev \
    libhdf5-dev \
    libnetcdf-dev \
    libudunits2-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install R packages with error handling
RUN R -e "options(repos = c(CRAN = 'https://cran.rstudio.com/')); \
    install.packages(c( \
        'tidyverse', \
        'rstatix', \
        'car', \
        'emmeans', \
        'apaTables', \
        'ppcor', \
        'officer', \
        'flextable', \
        'papaja', \
        'DT', \
        'shinyjs', \
        'shinyWidgets', \
        'plotly', \
        'corrplot' \
    ), dependencies = TRUE)"

# Copy application files
COPY statistics/ /srv/shiny-server/statistics/

# Copy Shiny Server configuration
COPY statistics/shiny-server.conf /etc/shiny-server/shiny-server.conf

# Expose port
EXPOSE 3838

# Start Shiny Server
CMD ["/usr/bin/shiny-server"]
