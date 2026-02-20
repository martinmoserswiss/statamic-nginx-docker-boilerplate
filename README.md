# Statamic nginx docker boilerplate 🐳

A production-ready and developer-friendly boilerplate for running [Statamic CMS](https://statamic.com) inside Docker using Nginx and PHP 8.5.

This setup includes:

- 🐳 Docker Compose-based environment
- ⚙️ PHP 8.5 with all required extensions (Statamic 6 ready)
- 🌐 Nginx as web server
- 📦 Composer for PHP dependencies
- 🧩 Node.js with npm for asset compilation (Vite)
- 🧹 Preconfigured permissions & Laravel cache handling

## Prerequisite

You need a unix VM with root access, where the following tools are installed:
- `Docker` and `Docker Compose`
- `Nginx`
- An editor like `vim`

## ⚒️ Installation

### 1. Clone this repo
```bash
git clone git@github.com:martinmoserswiss/statamic-nginx-docker-boilerplate.git project-name
```

### 2. Navigate to the project directory

```bash
cd project-name
```

### 3. Clone existing Statamic project

```bash
git clone git@github.com:your-user/your-project.git app
```

### 4. Prepare Docker environment

Open `docker-compose.yml` file.

1. Adjust container_name of the statamic service
1. Adjust container_name of the web server
1. Adjust port 8080

### 5. Prepare Domain

1. Login to your Hoster where you can manage your domain zone file.
1. Create A records for both the root domain and the “www” subdomain. For example:
- my-project.com → A record pointing to your server’s IP
- www.my-project.com → A record pointing to the same IP

### 6. Prepare Reverse Proxy

1. Copy the `SAMPLE_my-project.com` to the host nginx config folder `sudo cp SAMPLE_my-project.com /etc/nginx/sites-available/`
1. Rename the file to the name of your root domain like `sudo mv SAMPLE_my-project.com my-project.com`
1. Adjust the server name to `server_name SAMPLE_my-project.com www.SAMPLE_my-project.com;` inside the file, with `sudo vim SAMPLE_my-project.com`
1. Adjust the port of `proxy_pass` to the port which was defined in docker-compose.
1. Activate the domain:
```bash
sudo ln -s /etc/nginx/sites-available/my-project.com /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

### 7. Create SSL-Certs with Certbot

1. `sudo certbot --nginx -d www.my-project.com -d my-project.com`

### 6. Prepare Statamic

1. Navigate back to your statamic project inside your folder: `cd ~/project-name/app`
1. Create a copy of the .env file: `cp .env.example .env`
1. Edit the .env file: `vim .env`
1. Adjust `APP_NAME` --> name it without special caracters like `MyProject`
1. Adjust `APP_URL` --> https://my-project.com
1. If needed adjust `STATAMIC_LICENSE_KEY` or `STATAMIC_PRO_ENABLED`

### 7. Build and start the container

1. Navigate to the project folder where docker-compose.yml is saved.
1. Build the container `docker compose build`
1. Start the container `docker compose up -d`
1. You see your container when running `docker ps -a`

### 8. Install statamic

1. Connect to your container with bash: `docker exec -it my-project bash`
1. Install statamic `composer install`
1. Run `php artisan key:generate` so that the app key can be generated
1. Download npm dependencies `npm install`
1. Build your npm project `npm run build`

## 🚀 Usage

### Start application

```bash
cd app
npm run dev
```

## ⚒️ Maintainance

### Stop containers

`docker compose down`

### Start containers

`docker compose up -d`

### Clear Statamic environment

```bash
cd app
php artisan view:clear      
php artisan config:clear
php artisan cache:clear
```
