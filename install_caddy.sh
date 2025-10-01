#!/bin/bash

# -------------------------------
# Caddy 安装脚本 (Debian)
# -------------------------------

set -e  # 遇到错误立即退出

echo "更新 apt 包索引..."
sudo apt update

echo "安装必要工具..."
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https gnupg curl

echo "添加 Caddy 官方仓库 GPG 密钥..."
curl -fsSL https://dl.cloudsmith.io/public/caddy/stable/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/caddy-archive-keyring.gpg

echo "添加 Caddy 仓库..."
echo "deb [signed-by=/usr/share/keyrings/caddy-archive-keyring.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/debian/ any-version main" | sudo tee /etc/apt/sources.list.d/caddy-stable.list

echo "更新 apt 包索引..."
sudo apt update

echo "安装 Caddy..."
sudo apt install -y caddy

echo "启动 Caddy 服务..."
sudo systemctl start caddy

echo "设置 Caddy 开机自启..."
sudo systemctl enable caddy

echo "检查 Caddy 版本..."
caddy version

echo "检查 Caddy 服务状态..."
sudo systemctl status caddy

echo "Caddy 安装完成并已启动，服务设置为开机自启！"
