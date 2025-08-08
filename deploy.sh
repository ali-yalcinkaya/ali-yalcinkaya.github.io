#!/bin/bash
# deploy.sh

echo "🚀 İstatistik Otomasyon Sistemi - Hybrid Deployment"

# Environment variables
export COMPOSE_PROJECT_NAME=ali-yalcinkaya
export SHINY_PORT=3838
export NGINX_PORT=80

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker first."
    exit 1
fi

# Stop existing containers
print_status "Stopping existing containers..."
docker-compose down

# Build and start containers
print_status "Building and starting containers..."
docker-compose up -d --build

# Wait for containers to be ready
print_status "Waiting for containers to be ready..."
sleep 15

# Health check
print_status "Performing health checks..."

# Check Shiny app
if curl -f http://localhost:$SHINY_PORT/statistics/ > /dev/null 2>&1; then
    print_status "✅ Shiny application is running!"
    print_status "�� Shiny URL: http://localhost:$SHINY_PORT/statistics/"
else
    print_warning "⚠️  Shiny application health check failed"
fi

# Check Nginx
if curl -f http://localhost:$NGINX_PORT/health > /dev/null 2>&1; then
    print_status "✅ Nginx proxy is running!"
    print_status "�� Proxy URL: http://localhost:$NGINX_PORT/"
else
    print_warning "⚠️  Nginx health check failed"
fi

# Check Prometheus
if curl -f http://localhost:9090/-/healthy > /dev/null 2>&1; then
    print_status "✅ Prometheus monitoring is running!"
    print_status "📊 Monitoring URL: http://localhost:9090/"
else
    print_warning "⚠️  Prometheus health check failed"
fi

# Check Grafana
if curl -f http://localhost:3000/api/health > /dev/null 2>&1; then
    print_status "✅ Grafana dashboard is running!"
    print_status "📈 Dashboard URL: http://localhost:3000/"
    print_status "🔑 Default credentials: admin/admin"
else
    print_warning "⚠️  Grafana health check failed"
fi

# Show container status
print_status "Container status:"
docker-compose ps

# Show logs
print_status "Recent logs:"
docker-compose logs --tail=20

print_status "🎉 Hybrid deployment completed!"
print_status ""
print_status "📋 Access URLs:"
print_status "   • GitHub Pages: https://ali-yalcinkaya.github.io/"
print_status "   • Shiny App: http://localhost:$SHINY_PORT/statistics/"
print_status "   • Nginx Proxy: http://localhost:$NGINX_PORT/"
print_status "   • Monitoring: http://localhost:9090/"
print_status "   • Dashboard: http://localhost:3000/"
print_status ""
print_status "🔧 Management commands:"
print_status "   • View logs: docker-compose logs -f"
print_status "   • Stop: docker-compose down"
print_status "   • Restart: docker-compose restart"
print_status "   • Update: docker-compose pull && docker-compose up -d"