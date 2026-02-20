server {
    server_name my-project.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;

        client_max_body_size 64M;

        # Uncomment this, if you want restrict the access with a predefined basic auth file.
        # auth_basic "Restricted";
        # auth_basic_user_file /etc/nginx/.htpasswd;
    }

    listen 80;
}