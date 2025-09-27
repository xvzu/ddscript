#!/bin/bash
# PowerWhois 部署脚本（仅负责系统依赖、PowerWhois 配置和 Docker 启动）
# Docker 和 Caddy 请自行安装和配置

set -e

# ===================== 交互式输入配置 =====================
read -p "请输入你的域名 (例如 1.zuuav.com): " DOMAIN
read -p "请输入 PowerWhois 后台用户名: " ADMIN_USER
read -s -p "请输入 PowerWhois 后台密码: " ADMIN_PASS
echo
# ==========================================================

echo "==== 更新系统并安装基础依赖 ===="
sudo apt update && sudo apt upgrade -y
sudo apt install -y git lsb-release curl wget

# ===================== 克隆 PowerWhois =====================
echo "==== 克隆 PowerWhois 项目 ===="
cd /opt
if [ ! -d "PowerWhois" ]; then
    sudo git clone https://github.com/WenLiCG/PowerWhois.git
else
    echo "PowerWhois 目录已存在，跳过克隆"
fi
cd PowerWhois/deploy

# ===================== 配置后端账户 =====================
echo "==== 配置 PowerWhois 后端账户 ===="
sudo cp backend/config.yaml backend/config.yaml.bak  # 备份原配置
sudo sed -i "s/AuthUsername:.*/AuthUsername: \"$ADMIN_USER\"/" backend/config.yaml
sudo sed -i "s/AuthPassword:.*/AuthPassword: \"$ADMIN_PASS\"/" backend/config.yaml

# ===================== 启动 PowerWhois =====================
echo "==== 启动 PowerWhois ===="
sudo docker compose up -d

echo "==== 部署完成 ===="
echo "请确保 Caddy 已配置反代 127.0.0.1:8080 并正确使用域名 $DOMAIN"
echo "后台账号: $ADMIN_USER"
echo "后台密码: $ADMIN_PASS"
echo "访问地址: http://$DOMAIN （或 https://$DOMAIN，如果 Caddy 已配置 HTTPS）"
