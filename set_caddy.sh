#!/bin/bash

# -------------------------------
# 交互式 Caddy 配置生成脚本（自动处理端口）
# -------------------------------

set -e

CADDYFILE="/etc/caddy/Caddyfile"
LOG_DIR="/var/log/caddy"

# 1. 输入域名
echo "请输入你的域名（例如 x.com）："
read DOMAIN

# 2. 选择网站类型
echo "请选择网站类型："
echo "1) 静态文件目录"
echo "2) 反向代理到本机端口/服务"
read -p "请输入 1 或 2: " SITE_TYPE

CONFIG_BLOCK=""

if [ "$SITE_TYPE" == "1" ]; then
    # 静态文件模式
    read -p "请输入静态文件目录（例如 /root/x）： " SITE_ROOT
    CONFIG_BLOCK="$DOMAIN {
    root * $SITE_ROOT
    file_server
    encode gzip

    log {
        output file $LOG_DIR/${DOMAIN}.access.log {
            roll_size 10mb
            roll_keep 5
            roll_keep_for 720h
        }
    }
}"
elif [ "$SITE_TYPE" == "2" ]; then
    # 反代模式
    read -p "请输入要反代的本机端口或地址（例如 3000 或 localhost:3000 或 http://localhost:3000）： " TARGET

    # 如果只输入数字，自动补全成 http://127.0.0.1:端口
    if [[ "$TARGET" =~ ^[0-9]+$ ]]; then
        TARGET="http://127.0.0.1:$TARGET"
    elif [[ "$TARGET" =~ ^[0-9]+$ ]]; then
        TARGET="http://127.0.0.1:$TARGET"
    fi

    CONFIG_BLOCK="$DOMAIN {
    reverse_proxy $TARGET

    log {
        output file $LOG_DIR/${DOMAIN}.access.log {
            roll_size 10mb
            roll_keep 5
            roll_keep_for 720h
        }
    }
}"
else
    echo "输入无效，请输入 1 或 2"
    exit 1
fi

# 3. 创建日志目录
sudo mkdir -p "$LOG_DIR"

# 4. 追加配置到 Caddyfile
echo "将配置写入 $CADDYFILE ..."
sudo bash -c "echo -e '\n$CONFIG_BLOCK' >> $CADDYFILE"

# 5. 重载 Caddy
echo "重载 Caddy 配置..."
sudo systemctl reload caddy

echo "配置完成！你可以访问 http://$DOMAIN"
