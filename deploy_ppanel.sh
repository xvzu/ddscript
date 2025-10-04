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

# 创建 PPanel 目录
PPANEL_DIR="/opt/ppanel"
mkdir -p "$PPANEL_DIR"
cd "$PPANEL_DIR"

# 创建 docker-compose.yml
cat > docker-compose.yml <<EOF
version: "3.8"
services:
  ppanel-db:
    image: mysql:8.0
    container_name: ppanel-db
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: ppanel
      MYSQL_USER: ppanel
      MYSQL_PASSWORD: ppanelpass
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
    volumes:
      - ppanel-redis-data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 30s
      timeout: 10s
      retries: 5

  ppanel-server:
    image: ppanel/ppanel-server:latest
    container_name: ppanel-server
    restart: unless-stopped
    environment:
      ADMIN_EMAIL: ${ADMIN_EMAIL}
      DB_HOST: ppanel-db
      DB_USER: ppanel
      DB_PASS: ppanelpass
      REDIS_HOST: ppanel-cache
    ports:
      - "8080:8080"
    depends_on:
      - ppanel-db
      - ppanel-cache

  ppanel-admin-web:
    image: ppanel/ppanel-admin-web:latest
    container_name: ppanel-admin-web
    restart: unless-stopped
    ports:
      - "3001:3000"
    depends_on:
      - ppanel-server

  ppanel-user-web:
    image: ppanel/ppanel-user-web:latest
    container_name: ppanel-user-web
    restart: unless-stopped
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
echo "管理端: http://<你的IP或域名>:3001"
echo "用户端: http://<你的IP或域名>:3002"
echo "服务端 API: http://<你的IP或域名>:8080"
echo "==============================="
