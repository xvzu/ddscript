#!/bin/bash

# 清屏并将光标移到屏幕顶部
clear
stty sane

# 输出脚本选项菜单
echo -e "\033[34m请输入选项: \033[0m"  # 蓝色的提示

echo -e "\033[33m01\033[0m - 安装 aaPanel"
echo -e "\033[33m02\033[0m - 安装最新版本的安装脚本"
echo -e "\033[33m00\033[0m - 退出"

read -p "\033[34m请输入要执行的操作:  \033[0" option

case "$option" in
  01)
    # 运行 aaPanel 安装命令
    clear
    stty sane
    echo -e "\033[33m正在安装 aaPanel ...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && echo "y" | bash install.sh forum && rm install.sh
    ;;

  02)
    # 运行安装最新版本脚本命令
    clear
    stty sane
    echo -e "\033[33m正在安装最新版本 ...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    curl -sSO http://io.bt.sb/install/install_latest.sh && bash install_latest.sh
    ;;

  00)
    # 退出脚本
    clear
    stty sane
    echo -e "\033[33m退出脚本。\033[0m"  # 黄色
    exit 0
    ;;

  *)
    # 输入无效选项
    clear
    stty sane
    echo -e "\033[31m无效的选项，请选择 01, 02 或 00 来退出。\033[0m"  # 红色
    ;;
esac
