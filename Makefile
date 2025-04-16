.PHONY: setup deploy restart clean logs \
	composer-install npm-install vite-build \
	clear-cache statamic-warmup fix-permissions git-pull

### 💡 Standard-Befehle

setup:
	@echo "🛠 Starte Setup-Prozess..."
	./scripts/setup.sh

deploy:
	@echo "🚀 Starte Deployment-Prozess..."
	./scripts/deploy.sh

restart:
	@echo "♻️  Starte Container neu..."
	docker compose down
	docker compose up -d

clean:
	@echo "🧹 Container und Volumes löschen..."
	docker compose down -v

logs:
	@echo "📄 Zeige Logs..."
	docker compose logs -f

### 🔧 Einzelne Schritte separat aufrufbar

composer-install:
	docker compose exec app composer install --no-dev --optimize-autoloader

npm-install:
	docker compose exec app npm install

vite-build:
	docker compose exec app npm run build

clear-cache:
	docker compose exec app php artisan cache:clear
	docker compose exec app php artisan config:clear
	docker compose exec app php artisan view:clear
	docker compose exec app php artisan statamic:stache:clear

statamic-warmup:
	docker compose exec app php artisan statamic:stache:warm

fix-permissions:
	docker compose exec app chown -R 1000:33 storage bootstrap/cache
	docker compose exec app chmod -R 775 storage bootstrap/cache

git-pull:
	cd app && git pull origin main

### ✅ Alle zusammengefasst als optionaler "hard-deploy"

hard-deploy: git-pull composer-install npm-install vite-build clear-cache statamic-warmup fix-permissions
	@echo "🚀 Hard-Deploy abgeschlossen!"