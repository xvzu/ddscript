#!/bin/bash

# 提示用户输入主机名
read -p "请输入主机名: " hostname

# 提示用户输入 swap 大小（单位为 GB）
read -p "请输入 swap 大小 (GB): " swap_size

# 检查 swap_size 是否为有效的数字并且大于 0
if [[ ! "$swap_size" =~ ^[0-9]+$ ]] || [[ "$swap_size" -le 0 ]]; then
  echo "错误: 请输入一个有效的 swap 大小 (大于 0 GB)。"
  exit 1
fi

# 修改主机名
echo "$hostname" > /etc/hostname
hostnamectl set-hostname "$hostname"
echo -e "\033[33m主机名已修改为: $hostname\033[0m"

# 配置交换空间
swap_size_mb=$((swap_size * 1024))  # 将 GB 转换为 MB

# 创建 swap 文件
fallocate -l ${swap_size_mb}M /swapfile

# 设置 swap 文件权限
chmod 600 /swapfile

# 设置 swap 区域
mkswap /swapfile

# 启用 swap
swapon /swapfile

# 将 swap 配置永久保存到 /etc/fstab
echo "/swapfile none swap sw 0 0" >> /etc/fstab
echo -e "\033[33m交换空间已设置为: ${swap_size}GB\033[0m"

# 删除日志文件（如果有的话）以及当前脚本文件
# 假设日志文件存储路径是 /var/log/setup.log（你可以根据实际情况调整）
log_file="/var/log/setup.log"
if [[ -f "$log_file" ]]; then
  rm -f "$log_file"
  echo -e "\033[33m日志文件已删除: $log_file\033[0m"
fi

# 删除当前脚本文件
script_file="$(basename "$0")"
if [[ -f "$script_file" ]]; then
  rm -f "$script_file"
  echo -e "\033[33m脚本文件已删除: $script_file\033[0m"
fi

# 新增部分：修改时区
# 提示用户输入时区信息
read -p "请输入时区（例如：Asia/Shanghai），如果要使用当前时区，请直接按回车: " timezone

# 如果用户输入了时区，修改时区，否则保持当前时区
if [[ -n "$timezone" ]]; then
  sudo timedatectl set-timezone "$timezone"
  echo -e "\033[33m时区已修改为: $timezone\033[0m"
else
  echo -e "\033[33m时区保持为当前时区\033[0m"
fi
