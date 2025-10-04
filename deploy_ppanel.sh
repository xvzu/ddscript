#!/bin/bash
# Perfect Panel 纯部署脚本 (Debian 13, Docker 自行安装)
# 不安装 Docker/Caddy，适合已有环境

set -e

echo "==============================="
echo "Perfect Panel 部署开始"
echo "==============================="

# 管理员邮箱
read -p "请输入管理员邮箱 (默认 admin@ppanel.dev): " ADMIN_EMAIL
ADMIN_EMAIL=${ADMIN_EMAIL:-admin@ppanel.dev}

# Redis 密码
read -p "请输入 Redis 密码 (默认 redispass): " REDIS_PASS
REDIS_PASS=${REDIS_PASS:-redispass}

# 数据库信息
DB_NAME="ppanel"
DB_USER="ppanel"
DB_PASS="ppanelpass"
DB_ROOT_PASS="rootpassword"

# 域名配置
API_DOMAIN="api.zuzhanghu.com"
ADMIN_DOMAIN="admin.zuzhanghu.com"
USER_DOMAIN="user.zuzhanghu.com"

# 创建 PPanel 目录
PPANEL_DIR="/opt/ppanel"
mkdir -p "$PPANEL_DIR"
cd "$PPANEL_DIR"

# 创建 docker-compose.yml
cat > docker-compose.yml <<EOF
services:
  ppanel-db:
    image: mysql:8.0
    container_name: ppanel-db
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: $DB_ROOT_PASS
      MYSQL_DATABASE: $DB_NAME
      MYSQL_USER: $DB_USER
      MYSQL_PASSWORD: $DB_PASS
    volumes:
      - ppanel-db-data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin" ,"ping", "-h", "localhost"]
      interval: 30s
      timeout: 10s
      retries: 5

  ppanel-cache:
    image: redis:7
    container_name: ppanel-cache
    restart: unless-stopped
    environment:
      REDIS_PASSWORD: $REDIS_PASS
    volumes:
      - ppanel-redis-data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "-a", "$REDIS_PASS", "ping"]
      interval: 30s
      timeout: 10s
      retries: 5

  ppanel-server:
    image: ppanel/ppanel-server:latest
    container_name: ppanel-server
    restart: unless-stopped
    environment:
      ADMIN_EMAIL: $ADMIN_EMAIL
      DB_HOST: ppanel-db
      DB_USER: $DB_USER
      DB_PASS: $DB_PASS
      REDIS_HOST: ppanel-cache
      REDIS_PASSWORD: $REDIS_PASS
    ports:
      - "8080:8080"
    depends_on:
      - ppanel-db
      - ppanel-cache

  ppanel-admin-web:
    image: ppanel/ppanel-admin-web:latest
    container_name: ppanel-admin-web
    restart: unless-stopped
    environment:
      VITE_API_BASE_URL: https://$API_DOMAIN
    ports:
      - "3001:3000"
    depends_on:
      - ppanel-server

  ppanel-user-web:
    image: ppanel/ppanel-user-web:latest
    container_name: ppanel-user-web
    restart: unless-stopped
    environment:
      VITE_API_BASE_URL: https://$API_DOMAIN
    ports:
      - "3002:3000"
    depends_on:
      - ppanel-server

volumes:
  ppanel-db-data:
  ppanel-redis-data:
EOF

echo "docker-compose.yml 已生成"

# 拉取镜像
echo "拉取 PPanel 镜像..."
docker compose pull

# 启动容器
echo "启动 PPanel 容器..."
docker compose up -d

echo "==============================="
echo "部署完成！"
echo "管理端: https://$ADMIN_DOMAIN:3001"
echo "用户端: https://$USER_DOMAIN:3002"
echo "服务端 API: https://$API_DOMAIN:8080"
echo "==============================="
echo ""
echo "数据库信息:"
echo "  主机: $DB_HOST"
echo "  数据库名: $DB_NAME"
echo "  用户名: $DB_USER"
echo "  密码: $DB_PASS"
echo ""
echo "Redis 信息:"
echo "  主机: $DB_HOST"
echo "  端口: 6379"
echo "  密码: $REDIS_PASS"
