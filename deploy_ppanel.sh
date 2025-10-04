#!/bin/bash
set -e

# ===============================
# Perfect Panel One-Click Deployment Script for Debian 13
# ===============================

# 默认管理员信息，可修改
ADMIN_EMAIL="admin@ppanel.dev"

# 获取服务器 IP
SERVER_IP=$(hostname -I | awk '{print $1}')

# 安装必要工具
apt-get update -y
apt-get install -y curl git

# 安装 Docker 和 docker-compose
if ! command -v docker >/dev/null 2>&1; then
  curl -fsSL https://get.docker.com | bash
fi

if ! command -v docker-compose >/dev/null 2>&1; then
  apt-get install -y docker-compose
fi

# 克隆 ppanel-script 仓库
if [ ! -d "ppanel-script" ]; then
  git clone https://github.com/perfect-panel/ppanel-script.git
fi
cd ppanel-script

# 生成管理员密码
ADMIN_PASSWORD=$(openssl rand -hex 12)

# 修改 ppanel.yaml
sed -i.bak "/^Administrator:/,/^[^ ]/ s/^  Email:.*/  Email: $ADMIN_EMAIL/" config/ppanel.yaml
sed -i "/^Administrator:/,/^[^ ]/ s/^  Password:.*/  Password: $ADMIN_PASSWORD/" config/ppanel.yaml

# 修改 compose.yaml 中 NEXT_PUBLIC_API_URL
sed -i.bak "s#NEXT_PUBLIC_API_URL: .*#NEXT_PUBLIC_API_URL: http://$SERVER_IP:8080#" compose.yaml

# 启动所有服务
docker compose up -d

# 等待 API 启动
echo "等待 PPanel API 启动..."
for i in {1..30}; do
  if curl -s http://$SERVER_IP:8080/health >/dev/null; then
    echo "API 已启动成功！"
    break
  else
    echo -n "."
    sleep 2
  fi
done

# 输出访问信息
echo "==============================="
echo "Perfect Panel 部署完成！"
echo "API（服务端）: http://$SERVER_IP:8080"
echo "Admin（管理端）: http://$SERVER_IP:3001"
echo "User（用户端）: http://$SERVER_IP:3002"
echo "默认管理员账号：$ADMIN_EMAIL"
echo "默认管理员密码：$ADMIN_PASSWORD"
echo "查看服务状态：docker compose ps"
echo "查看日志：docker compose logs -f"
echo "==============================="
