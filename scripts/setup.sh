#!/bin/bash

echo "🚀 Starte Build & Container..."
docker compose up -d --build

echo "🧼 Bereinige npm Cache-Permissions im Container..."
docker compose exec app mkdir -p /app/.npm
docker compose exec app chown -R 1000:33 /app/.npm

echo "🧰 Erstelle und repariere Laravel Cache-Verzeichnisse..."
docker compose exec app mkdir -p \
    storage/framework/cache \
    storage/framework/sessions \
    storage/framework/views \
    storage/logs

docker compose exec app chmod -R 775 storage bootstrap/cache
docker compose exec app chown -R 1000:33 storage bootstrap/cache

echo "📦 Installiere PHP-Abhängigkeiten (composer)..."
docker compose exec app composer install --no-dev --optimize-autoloader

echo "📦 Installiere JS-Abhängigkeiten (npm)..."
docker compose exec app npm install

echo "🛠 Baue Frontend Assets mit Vite..."
docker compose exec app npm run build || {
  echo "❌ Build fehlgeschlagen! Bitte überprüfe JS-Abhängigkeiten oder Vite-Konfiguration."
  exit 1
}

docker compose exec app test -f public/build/manifest.json || {
  echo "❌ Vite-Manifest fehlt! Build hat scheinbar nicht richtig funktioniert."
  exit 1
}

echo "🔑 Generiere App Key..."
docker compose exec app php artisan key:generate --force

echo "🔥 Wärm Statamic Cache vor..."
docker compose exec app php artisan statamic:stache:warm

echo "✅ Setup abgeschlossen! 🎉 Du kannst jetzt http://localhost:8081 im Browser öffnen."