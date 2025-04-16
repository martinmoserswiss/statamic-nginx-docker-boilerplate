# Statamic Docker Boilerplate 🐳

Dieses Repository enthält ein vollständiges Docker-Setup für Statamic.

## 🚀 Verwendung

Option 1: Projekt als /app klonen:
```bash
git clone git@github.com:your-user/your-project.git app
```

Option 2: Statamic Projekt in app/ erstellen
```bash
composer create-project statamic/statamic app
```

3. Setup starten:
```bash
make setup
```

## 📁 Ordnerstruktur
```bash
├── app/               # Statamic-Projekt
├── docker-compose.yml
├── php/               # PHP-FPM Dockerfile
├── nginx/             # Nginx Config
├── scripts/           # setup.sh & deploy.sh
├── Makefile           # praktische Helferlein
````