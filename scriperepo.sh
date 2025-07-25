#!/bin/bash

# 清屏并将光标移到屏幕顶部
clear && stty sane

# 输出脚本选项菜单
echo -e "\033[34m请输入选项: \033[0m"  # 蓝色的提示
echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
echo -e "\033[33m1   - 官方aaPanel\033[0m"  # 黄色
echo -e "\033[33m2   - 宝塔11开心版 bt.sb\033[0m"  # 黄色
echo -e "\033[33m3   - XrayR-wyx2685\033[0m"  # 黄色
echo -e "\033[33m4   - 解锁检测\033[0m"  # 黄色
echo -e "\033[33m5   - Docker安装\033[0m"  # 黄色
echo -e "\033[33m6   - DockerPS\033[0m"  # 黄色
echo -e "\033[33m7   - 挂机2+3+5+1\033[0m"  # 黄色
echo -e "\033[33m8   - 重启1+挂机4\033[0m"  # 黄色
echo -e "\033[33m9   - BBR\033[0m"  # 黄色
echo -e "\033[33m10  - 清理+注销所有root\033[0m"  # 黄色
echo -e "\033[33m11  - 重启\033[0m"  # 黄色
echo -e "\033[33m12  - 清理重启哪吒客户端\033[0m"  # 黄色
echo -e "\033[33m13  - 清理退出\033[0m"  # 黄色

echo -e "\033[33m0   - 退出\033[0m"  # 黄色
echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
read -p "请输入选项: " option

# 输入有效性检查
case "$option" in
  1|2|3|4|5|6|7|8|9|10|11|12|13|0)
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
    echo -e "\033[33m运行中...\033[0m"  # 黄色
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
    echo -e "\033[33m运行中...\033[0m"  # 黄色
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
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash <(curl -Ls https://raw.githubusercontent.com/wyx2685/XrayR-release/master/install.sh)
    ;;
    
  4)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash <(curl -Ls Check.Place) -y
    ;;

  5)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget -qO- https://get.docker.com/ | sh && sudo -i
    ;;

  6)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    docker version && docker compose version && docker ps -a --no-trunc
    ;;

    7)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    docker run -d --restart=always -e CID=6UKb --name psclient packetstream/psclient:latest
    docker run --name repocket -e RP_EMAIL=vxoooo@outlook.com -e RP_API_KEY=c563bf3a-ec91-4826-97dc-4c18a0bc957a -d --restart=always repocket/repocket:1.1.33
    curl -L https://raw.githubusercontent.com/spiritLHLS/earnfm-one-click-command-installation/main/earnfm.sh -o earnfm.sh && chmod +x earnfm.sh && bash earnfm.sh -m dbb030c1-2fe9-47d7-bafc-d54fbdab9ac2 && docker run -i --name tm --restart always traffmonetizer/cli_v2 start accept --token 8hqssSWZf/+782nFhpRvA3kamdBPTCbAZ2/McYhtG84=
    ;;

    8)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    docker restart tm && docker run --restart unless-stopped packetshare/packetshare -accept-tos -email=vxoooo@outlook.com -password=Hsnx99qazxcvb
    ;;

    9)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget --no-check-certificate -O /opt/bbr.sh https://github.com/teddysun/across/raw/master/bbr.sh && chmod 755 /opt/bbr.sh && /opt/bbr.sh && rm -f /opt/bbr.sh && rm -f /opt/install_bbr.log




    sysctl net.ipv4.tcp_congestion_control && sudo -i
    ;;

    10)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    rm -f ~/.bash_history && history -c && pkill -KILL -u $(who | awk '{print $1}' | sort | uniq)
    ;;

    11)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    reboot
    ;;

    12)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    systemctl daemon-reload && systemctl enable nezha-agent && systemctl restart nezha-agent && rm -f /root/nezha.sh /root/nezha_v0.sh && rm -f /root/earnfm.sh
    ;;

    13)
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    rm -f ~/.bash_history
    history -c
    logout
    ;;

  0)
    # 退出脚本
    clear
    echo -e "\033[33m退出脚本。\033[0m"  # 黄色
    exit 0
    ;;
esac
