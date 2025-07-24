#!/bin/bash

# 清屏并将光标移到屏幕顶部
clear
stty sane

# 输出脚本选项菜单
echo "请选择要执行的操作:"
echo "01 - 安装 aaPanel"
echo "02 - 安装最新版本的安装脚本"
echo "00 - 退出"
read -p "请输入选项 (01/02/00): " option

case "$option" in
  01)
    # 运行 aaPanel 安装命令
    clear
    stty sane
    echo "正在安装 aaPanel ..."
    wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && echo "y" | bash install.sh forum && rm install.sh
    ;;
  
  02)
    # 运行安装最新版本脚本命令
    clear
    stty sane
    echo "正在安装最新版本 ..."
    curl -sSO http://io.bt.sb/install/install_latest.sh && bash install_latest.sh
    ;;
  
  00)
    # 退出脚本
    clear
    stty sane
    echo "退出脚本。"
    exit 0
    ;;
  
  *)
    # 输入无效选项
    clear
    stty sane
    echo "无效的选项，请选择 01, 02 或 00 来退出。"
    ;;
esac
