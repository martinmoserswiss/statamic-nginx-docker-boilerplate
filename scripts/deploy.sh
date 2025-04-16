#!/bin/bash

echo "🔄 Git Pull auf dem Host..."
cd app && git pull origin main && cd ..

echo "📦 Composer install im Container..."
docker compose exec app composer install --no-dev --optimize-autoloader

echo "⚡ npm install im Container..."
docker compose exec app npm install

echo "🛠️ Build der Frontend-Assets..."
docker compose exec app npm run build

echo "🔑 App Key generieren (falls nötig)..."
docker compose exec app php artisan key:generate --force

echo "🧹 Laravel & Statamic Cache leeren und vorbereiten..."
docker compose exec app php artisan cache:clear
docker compose exec app php artisan config:clear
docker compose exec app php artisan view:clear
docker compose exec app php artisan statamic:stache:clear
docker compose exec app php artisan statamic:stache:warm

echo "🔓 Rechte prüfen (optional)..."
docker compose exec app chown -R 1000:33 storage bootstrap/cache

echo "✅ Deployment abgeschlossen! 🚀"