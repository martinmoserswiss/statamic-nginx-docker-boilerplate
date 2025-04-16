# Statamic nginx docker boilerplate 🐳

A production-ready and developer-friendly boilerplate for running [Statamic CMS](https://statamic.com) inside Docker using Nginx and PHP 8.2.

This setup includes:

- 🐳 Docker Compose-based environment
- ⚙️ PHP 8.2 with all required extensions
- 🌐 Nginx as web server
- 📦 Composer for PHP dependencies
- 🧩 Node.js with npm for asset compilation (Vite)
- 🛠 Scripts for setup and deployment
- 🧹 Preconfigured permissions & Laravel cache handling

## 🚀 Usage

Option 1: Clone existing statamic project as /app :
```bash
git clone git@github.com:your-user/your-project.git app
```

Option 2: Create new statamic project in app/:
```bash
composer create-project statamic/statamic app
```

3. Create setup:
```bash
make setup
```

## 📁 Folder structure
```bash
├── app/               # Statamic-Projecct
├── docker-compose.yml
├── php/               # PHP-FPM Dockerfile
├── nginx/             # Nginx Config
├── scripts/           # setup.sh & deploy.sh
├── Makefile           # Usable commands
````