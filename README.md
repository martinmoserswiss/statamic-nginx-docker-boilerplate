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

### Clone this repo
```bash
git clone git@github.com:martinmoserswiss/statamic-nginx-docker-boilerplate.git ProjectName
cd ProjectName
rm -rf app
```

### Install Statamic project

**Option 1: Clone existing**
```bash
git clone git@github.com:your-user/your-project.git app
```

**Option 2: Create new**
```bash
composer create-project statamic/statamic app
```

### Prepare Docker environment

1. Adjust container_name to your project name
1. Adjust port 8081 to the needes of your environment. Or leave as it is.

Open `docker-compose.yml`

```bash
services:
  app:
    build:
      context: ./php
    container_name: statamic_app_projectname
    volumes:
      - ./app:/app
    working_dir: /app
    user: "1000:33"
    networks:
      - statamic_net

  web:
    image: nginx:stable-alpine
    container_name: statamic_web_projectname
    ports:
      - "8081:80"
    volumes:
      - ./app:/app
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - app
    networks:
      - statamic_net

networks:
  statamic_net:
    driver: bridge
```

### Prepare Webserver

Set fastcgi_param HTTPS to `on` or `off`.

```bash
server {
    listen 80;
    server_name localhost;
    root /app/public;

    index index.php index.html;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_param HTTPS off;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```

### Prepare Statamic

Adjust port of your application

```bash
APP_URL=http://localhost:8081
```

5. Create setup:
```bash
docker compose down
docker compose up -d --build
make setup
```