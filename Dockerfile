# Dockerfile for İstatistik Otomasyon Sistemi
# Ali Yalcinkaya - https://ali-yalcinkaya.github.io/statistics/

FROM rocker/shiny:4.2

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
    libgdal-dev \
    libproj-dev \
    libgeos-dev \
    libgsl-dev \
    libhdf5-dev \
    libnetcdf-dev \
    libudunits2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c( \
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
    ), repos='https://cran.rstudio.com/')"

# Copy application files
COPY statistics/ /srv/shiny-server/statistics/

# Copy Shiny Server configuration
COPY statistics/shiny-server.conf /etc/shiny-server/shiny-server.conf

# Expose port
EXPOSE 3838

# Start Shiny Server
CMD ["/usr/bin/shiny-server"]
