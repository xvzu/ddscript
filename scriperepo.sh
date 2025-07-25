#!/bin/bash

# 清屏并将光标移到屏幕顶部
clear && stty sane

# 输出脚本选项菜单
echo -e "\033[34m请输入选项: \033[0m"  # 蓝色的提示
echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
echo -e "\033[33m1 - 官方aaPanel\033[0m"  # 黄色
echo -e "\033[33m2 - 宝塔11开心版 bt.sb\033[0m"  # 黄色
echo -e "\033[33m3 - XrayR-wyx2685\033[0m"  # 黄色
echo -e "\033[33m4 - 解锁检测\033[0m"  # 黄色
echo -e "\033[33m0 - 退出\033[0m"  # 黄色
echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
read -p "请输入选项: " option

# 输入有效性检查
case "$option" in
  1|2|3|4|0)
    ;;
  *)
    echo -e "\033[31m无效的选项\033[0m"
    exit 1
    ;;
esac

case "$option" in
  1)
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

  2)
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

  3)
    # 运行安装最新版本脚本命令
    clear
    echo -e "\033[33m正在安装...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash <(curl -Ls https://raw.githubusercontent.com/wyx2685/XrayR-release/master/install.sh)
    ;;
    
  4)
    clear
    echo -e "\033[33m正在安装...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash <(curl -Ls Check.Place) -y
    ;;
    
  0)
    # 退出脚本
    clear
    echo -e "\033[33m退出脚本。\033[0m"  # 黄色
    exit 0
    ;;
esac
