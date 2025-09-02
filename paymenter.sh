#!/bin/bash
set -e

# ========== 基本变量 ==========
DOMAIN="shop.example.com"
DB_NAME="paymenter"
DB_USER="paymenter"
DB_PASS="paymenter_pass"
INSTALL_DIR="/var/www/paymenter"

# ========== 更新系统 ==========
apt -y update
apt -y upgrade

# ========== 安装依赖 ==========
apt -y install nginx python3-certbot-nginx mariadb-server redis-server curl apt-transport-https ca-certificates lsb-release software-properties-common unzip git -y

# ========== 安装 PHP8.1 ==========
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
apt -y update
apt -y install php8.1 php8.1-common php8.1-fpm \
php8.1-mysql php8.1-cli php8.1-gd \
php8.1-mbstring php8.1-bcmath php8.1-xml \
php8.1-curl php8.1-zip

# ========== 安装 Composer ==========
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# ========== 配置数据库 ==========
mysql -uroot <<EOF
CREATE USER IF NOT EXISTS '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASS}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'127.0.0.1' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# ========== 下载 Paymenter ==========
mkdir -p ${INSTALL_DIR}
cd ${INSTALL_DIR}
curl -Lo paymenter.tar.gz https://github.com/paymenter/paymenter/releases/latest/download/paymenter.tar.gz
tar -xzvf paymenter.tar.gz
chmod -R 755 storage/* bootstrap/cache/
cp .env.example .env

# ========== 配置 Paymenter ==========
composer install --no-dev --optimize-autoloader
php artisan key:generate --force
php artisan storage:link

# 修改 .env
sed -i "s|APP_URL=.*|APP_URL=https://${DOMAIN}|" .env
sed -i "s|DB_CONNECTION=.*|DB_CONNECTION=mysql|" .env
sed -i "s|DB_HOST=.*|DB_HOST=127.0.0.1|" .env
sed -i "s|DB_PORT=.*|DB_PORT=3306|" .env
sed -i "s|DB_DATABASE=.*|DB_DATABASE=${DB_NAME}|" .env
sed -i "s|DB_USERNAME=.*|DB_USERNAME=${DB_USER}|" .env
sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=${DB_PASS}|" .env

# ========== 数据库迁移 ==========
php artisan migrate --force --seed

# ========== 权限 ==========
chown -R www-data:www-data ${INSTALL_DIR}

# ========== 定时任务 ==========
(crontab -u www-data -l 2>/dev/null; echo "* * * * * php ${INSTALL_DIR}/artisan schedule:run >> /dev/null 2>&1") | crontab -u www-data -

# ========== systemd 服务 ==========
cat >/etc/systemd/system/paymenter.service <<EOF
[Unit]
Description=Paymenter Queue Worker

[Service]
User=www-data
Group=www-data
Restart=always
ExecStart=/usr/bin/php ${INSTALL_DIR}/artisan queue:work
StartLimitInterval=180
StartLimitBurst=30
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

systemctl enable --now paymenter.service

# ========== Nginx 配置 ==========
cat >/etc/nginx/sites-available/paymenter <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name ${DOMAIN};
    root ${INSTALL_DIR}/public;

    index index.php;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }
}
EOF

ln -sf /etc/nginx/sites-available/paymenter /etc/nginx/sites-enabled/paymenter
nginx -t && systemctl reload nginx

# ========== SSL ==========
certbot --nginx -d ${DOMAIN} --non-interactive --agree-tos -m admin@${DOMAIN}

echo "=================================================="
echo "✅ Paymenter 已安装完成"
echo "👉 管理后台地址: https://${DOMAIN}"
echo "👉 数据库: ${DB_NAME} 用户: ${DB_USER} 密码: ${DB_PASS}"
echo "⚠️ 请执行: cd ${INSTALL_DIR} && php artisan p:user:create  来创建管理员账号"
echo "=================================================="
