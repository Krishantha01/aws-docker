server {
    listen 80;
    server_name 34.201.65.107;

location / {
  include proxy_params;
  proxy_pass http://unix:/lseg/app.sock;
    }
}
