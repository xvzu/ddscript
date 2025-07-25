#!/bin/bash

# 清屏并将光标移到屏幕顶部
clear && stty sane

# 输出脚本选项菜单
echo -e "\033[34m请输入选项 (01/02/03/04/00): \033[0m"  # 蓝色的提示

echo -e "\033[33m01 - 官方 aaPanel\033[0m"  # 黄色
echo -e "\033[33m02 - 宝塔11开心版 bt.sb\033[0m"  # 黄色
echo -e "\033[33m03 - XrayR-wyx2685\033[0m"  # 黄色
echo -e "\033[33m04 - 解锁检测\033[0m"  # 黄色
echo -e "\033[33m00 - 退出\033[0m"  # 黄色

read -p "请选择要执行的操作: " option

# 输入有效性检查
case "$option" in
  01|02|03|04|00)
    ;;
  *)
    echo -e "\033[31m无效的选项，请选择 01, 02, 03, 04 或 00。\033[0m"
    exit 1
    ;;
esac

case "$option" in
  01)
    # 运行 aaPanel 安装命令
    clear
    echo -e "\033[33m正在安装...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh
    if [ $? -eq 0 ]; then
        echo "下载成功，开始安装..."
        echo "y" | bash install.sh forum && rm -f install.sh
    else
        echo "下载失败，退出脚本"
        exit 1
    fi
    ;;

  02)
    # 运行安装最新版本脚本命令
    clear
    echo -e "\033[33m正在安装...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    curl -sSO http://io.bt.sb/install/install_latest.sh
    if [ $? -eq 0 ]; then
        bash install_latest.sh
    else
        echo "下载失败，退出脚本"
        exit 1
    fi
    ;;

  03)
    # 运行安装最新版本脚本命令
    clear
    echo -e "\033[33m正在安装...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash <(curl -Ls https://raw.githubusercontent.com/wyx2685/XrayR-release/master/install.sh)
    ;;
    
  04)
    clear
    echo -e "\033[33m正在安装...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash <(curl -Ls https://example.com/Check.Place) -y  # 替换为有效的 URL
    ;;
    
  00)
    # 退出脚本
    clear
    echo -e "\033[33m退出脚本。\033[0m"  # 黄色
    exit 0
    ;;
esac
