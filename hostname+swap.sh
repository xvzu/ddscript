#!/bin/bash

# 默认值
hostname="hlocalhost"
swap_size="0G"

# 解析命令行参数
while [[ $# -gt 0 ]]; do
  case $1 in
    --hostname)
      hostname="$2"
      shift 2
      ;;
    --Swap)
      swap_size="$2"
      shift 2
      ;;
    *)
      echo "未知参数: $1"
      exit 1
      ;;
  esac
done

# 修改主机名
echo "$hostname" > /etc/hostname
hostnamectl set-hostname "$hostname"
echo "主机名已修改为: $hostname"

# 修改交换空间
fallocate -l $swap_size /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab
echo "交换空间已设置为: $swap_size"
