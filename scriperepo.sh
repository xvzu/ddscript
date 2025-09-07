#!/bin/bash


clear && stty sane  # 清屏并将光标移到屏幕顶部

# 输出脚本选项菜单👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
echo -e "\033[34m👋  请输入选项：\033[0m"  # 蓝色的提示
echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
echo -e "\033[33m 1 👉  官方aaPanel\033[0m"  # 黄色
echo -e "\033[33m 2 👉  宝塔11开心版 bt.sb\033[0m"  # 黄色
echo -e "\033[33m 3 👉  XrayR-wyx2685\033[0m"  # 黄色
echo -e "\033[33m 4 👉  解锁检测\033[0m"  # 黄色
echo -e "\033[33m 5 👉  Docker安装\033[0m"  # 黄色
echo -e "\033[33m 6 👉  Docker+PS\033[0m"  # 黄色
echo -e "\033[33m 7 👉  挂机2+3+5+1\033[0m"  # 黄色
echo -e "\033[33m 8 👉  重启1+挂机4\033[0m"  # 黄色
echo -e "\033[33m 9 👉  开启BBR\033[0m"  # 黄色
echo -e "\033[33m10 👉  DD为Debian13-密钥\033[0m"  # 黄色
echo -e "\033[33m11 👉  DD为Debian12-密钥\033[0m"  # 黄色
echo -e "\033[33m12 👉  C大 baota.la 宝塔\033[0m"  # 黄色
echo -e "\033[33m13 👉  C大 baota.la 宝塔云安全监控\033[0m"  # 黄色
echo -e "\033[33m14 👉  清理+退出root\033[0m"  # 黄色
echo -e "\033[33m15 👉  安装wyx2685 V2board后端\033[0m"  # 黄色
echo -e "\033[33m16 👉  安装warp\033[0m"  # 黄色
echo -e "\033[33m17 👉  重启xrayr+日志\033[0m"  # 黄色
echo -e "\033[33m18 👉  DD为AlmaLinux 8-密钥\033[0m"  # 黄色
echo -e "\033[33m19 👉  AlmaLinux安装依赖\033[0m"  # 黄色
echo -e "\033[33m20 👉  安装1Panel\033[0m"  # 黄色

echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
echo -e "\033[33m0  👉  退出 👋\033[0m"  # 黄色
echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
read -p "请输入选项: " option

case "$option" in  # 输入有效性检查
  1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|0)
    ;;
  *)
    echo -e "\033[31m无效选项\033[0m"
    exit 1
    ;;
esac
case "$option" in


  1)  # 安装aapanel👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
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
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  2)  # 安装bt.sb脚本👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
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
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  3)  # 安装XrayR-wyx2685👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash <(curl -Ls https://raw.githubusercontent.com/wyx2685/XrayR-release/master/install.sh)
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;
    
  4)  # 解锁检测👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash <(curl -Ls Check.Place) -y
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  5)  # Docker安装👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget -qO- https://get.docker.com/ | sh && sudo -i
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  6)  # Docker+PS👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    docker version && docker compose version && docker ps -a --no-trunc
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  7)  # 挂机2+3+5+1👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    docker run -d --restart=always -e CID=6UKb --name psclient packetstream/psclient:latest
    docker run --name repocket -e RP_EMAIL=vxoooo@outlook.com -e RP_API_KEY=c563bf3a-ec91-4826-97dc-4c18a0bc957a -d --restart=always repocket/repocket:1.1.33
    curl -L https://raw.githubusercontent.com/spiritLHLS/earnfm-one-click-command-installation/main/earnfm.sh -o earnfm.sh && chmod +x earnfm.sh && bash earnfm.sh -m dbb030c1-2fe9-47d7-bafc-d54fbdab9ac2 && docker run -i --name tm --restart always traffmonetizer/cli_v2 start accept --token 8hqssSWZf/+782nFhpRvA3kamdBPTCbAZ2/McYhtG84=
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  8)  # 重启1+挂机4👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    docker restart tm && docker run --restart unless-stopped packetshare/packetshare -accept-tos -email=vxoooo@outlook.com -password=Hsnx99qazxcvb
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  9)  # 开启BBR👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget --no-check-certificate -O /opt/bbr.sh https://github.com/teddysun/across/raw/master/bbr.sh && chmod 755 /opt/bbr.sh && /opt/bbr.sh && rm -f /opt/bbr.sh && rm -f /opt/install_bbr.log

    
    sysctl net.ipv4.tcp_congestion_control && sudo -i

    
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  10)  # DD为Debian13👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh || wget -O reinstall.sh $_ && bash reinstall.sh debian 13 --ssh-port 55555 --ssh-key "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCr6sPe8m02u8+vkrFOKG1Mxrzw/D+bOCDMdrbrJwoMSyMweDaXOVgHKz9cVfHdwNXZD96u6IEgtTuIOmqv2xqCHdTSW6vIV3LkcEpH08VF+uWNMZjc8HtqnVn8S5aQtAa1BVBUZjg+9WOEZk6qDD2/JYknTOGnkC/2hG0oT/7mPrSEVMyw8lDvtI4rGl1H6QzGIp7cf14UK7JbA7wfbj+NxHnIup4HHbwDQCv6tNvIYL89mFqdDV1c+9sbBGjmqNnEvyYHU+cxxdOxoRh+jy/yBnaBCfxinUk9kyxCXEenZtv97u31kcSyOO6Txxxzxg1WDZyT3lA4QvSxCw8Kzp8INRNehz0+AQa5Nz3jVvfDEdEt3AfP6jSaxQtEK9sR7Os9GJAp3J4QDmpugWO8NdLZ7yeF/Zr/KfD4VqbDGrze5a5axPOcHaoBWG0zvpOltaU0X0xJ40lGsX5zp4+rx1LEKYDuy/WSulnzItT7zIQiHKT15yxdT3HUeBHp1Kmw0o0hANOqqucrGO9x04KsozXbL9n6eu7THBxwTpGKLNLAhi4NAn8BzWzfzYB7xmZLHl7aTzMJx/chqq1CVySYIt+oLBuqsM638L5ewpea9gXGE0P4lxkgHdJVES9gT30nFjad1Lk/KRTAaXK+ucrtDz29BXtr7yoBhRblTF725AwB/Q== root@root" && reboot
    ;;

  11)  # DD为Debian12👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh || wget -O reinstall.sh $_ && bash reinstall.sh debian 12 --ssh-port 55555 --ssh-key "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCr6sPe8m02u8+vkrFOKG1Mxrzw/D+bOCDMdrbrJwoMSyMweDaXOVgHKz9cVfHdwNXZD96u6IEgtTuIOmqv2xqCHdTSW6vIV3LkcEpH08VF+uWNMZjc8HtqnVn8S5aQtAa1BVBUZjg+9WOEZk6qDD2/JYknTOGnkC/2hG0oT/7mPrSEVMyw8lDvtI4rGl1H6QzGIp7cf14UK7JbA7wfbj+NxHnIup4HHbwDQCv6tNvIYL89mFqdDV1c+9sbBGjmqNnEvyYHU+cxxdOxoRh+jy/yBnaBCfxinUk9kyxCXEenZtv97u31kcSyOO6Txxxzxg1WDZyT3lA4QvSxCw8Kzp8INRNehz0+AQa5Nz3jVvfDEdEt3AfP6jSaxQtEK9sR7Os9GJAp3J4QDmpugWO8NdLZ7yeF/Zr/KfD4VqbDGrze5a5axPOcHaoBWG0zvpOltaU0X0xJ40lGsX5zp4+rx1LEKYDuy/WSulnzItT7zIQiHKT15yxdT3HUeBHp1Kmw0o0hANOqqucrGO9x04KsozXbL9n6eu7THBxwTpGKLNLAhi4NAn8BzWzfzYB7xmZLHl7aTzMJx/chqq1CVySYIt+oLBuqsM638L5ewpea9gXGE0P4lxkgHdJVES9gT30nFjad1Lk/KRTAaXK+ucrtDz29BXtr7yoBhRblTF725AwB/Q== root@root" && reboot
    ;;

  12)  # 无👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget -O install.sh https://baota.la/install/install_6.0.sh && bash install.sh
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  13)  # 无👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    curl -sS https://baota.la/install/install_btmonitor.sh -o /tmp/install_btmonitor.sh && bash /tmp/install_btmonitor.sh
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  14)  # 清理+退出root👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    systemctl daemon-reload && systemctl enable nezha-agent && systemctl restart nezha-agent && rm -f /root/nezha.sh /root/nezha_v0.sh || true && rm -f /root/earnfm.sh || true && rm -f ~/.wget-hsts || true && rm -f ~/.bash_history || true && history -c
    pkill -KILL -u root
    ;;

  15)  # 安装wyx2685 V2board后端👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget -N https://raw.githubusercontent.com/wyx2685/V2bX-script/master/install.sh && bash install.sh
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  16)  # 安装warp👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    wget -N https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh && bash menu.sh
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

    17)  # 重启xrayr，查看日志👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    systemctl restart XrayR
    journalctl -u XrayR -f
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

    18)  # DD为AlmaLinux 8👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh || wget -O reinstall.sh $_ && bash reinstall.sh AlmaLinux 8 --ssh-port 55555 --ssh-key "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCr6sPe8m02u8+vkrFOKG1Mxrzw/D+bOCDMdrbrJwoMSyMweDaXOVgHKz9cVfHdwNXZD96u6IEgtTuIOmqv2xqCHdTSW6vIV3LkcEpH08VF+uWNMZjc8HtqnVn8S5aQtAa1BVBUZjg+9WOEZk6qDD2/JYknTOGnkC/2hG0oT/7mPrSEVMyw8lDvtI4rGl1H6QzGIp7cf14UK7JbA7wfbj+NxHnIup4HHbwDQCv6tNvIYL89mFqdDV1c+9sbBGjmqNnEvyYHU+cxxdOxoRh+jy/yBnaBCfxinUk9kyxCXEenZtv97u31kcSyOO6Txxxzxg1WDZyT3lA4QvSxCw8Kzp8INRNehz0+AQa5Nz3jVvfDEdEt3AfP6jSaxQtEK9sR7Os9GJAp3J4QDmpugWO8NdLZ7yeF/Zr/KfD4VqbDGrze5a5axPOcHaoBWG0zvpOltaU0X0xJ40lGsX5zp4+rx1LEKYDuy/WSulnzItT7zIQiHKT15yxdT3HUeBHp1Kmw0o0hANOqqucrGO9x04KsozXbL9n6eu7THBxwTpGKLNLAhi4NAn8BzWzfzYB7xmZLHl7aTzMJx/chqq1CVySYIt+oLBuqsM638L5ewpea9gXGE0P4lxkgHdJVES9gT30nFjad1Lk/KRTAaXK+ucrtDz29BXtr7yoBhRblTF725AwB/Q== root@root" && reboot
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

    19)  # AlmaLinux安装依赖👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    sudo dnf makecache
    sudo dnf update -y
    sudo dnf install kernel kernel-core kernel-modules -y
    sudo dnf clean all
    sudo dnf install -y sudo wget curl git screen zip tar unzip vim nano socat rsync
    sudo dnf install -y sudo wget
    sudo dnf install -y sudo unzip
    curl -O https://raw.githubusercontent.com/xvzu/ddscript/main/.bashrc
    mv .bashrc ~/
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/hostname_swap1.sh)
    sudo -i
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

    20)  # 安装1Panel👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    clear
    echo -e "\033[33m运行中...\033[0m"  # 黄色
    echo -e "\033[32m------------------------\033[0m"  # 绿色分隔线
    bash -c "$(curl -sSL https://resource.fit2cloud.com/1panel/package/v2/quick_start.sh)"
    echo -e "\033[32m按任意键继续...\033[0m"  # 任意键继续
    read -n 1 -s -r
    clear
    bash <(curl -sL https://raw.githubusercontent.com/xvzu/ddscript/main/scriperepo.sh)
    ;;

  0)  # 安装👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
    # 退出脚本
    clear
    echo -e "\033[33m👋  退出脚本  👋\033[0m"  # 黄色
    exit 0
    ;;
esac
