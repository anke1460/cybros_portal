set :nginx_use_ssl, false
set :branch, :thape_staging
set :deploy_to, "/var/www/staging"

server 'thape_cybros', user: 'staging', roles: %w{app db web}