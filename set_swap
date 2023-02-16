#!/usr/bin/env bash

Green="\033[32m"
Font="\033[0m"
Red="\033[31m" 

#root权限
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "${Red}Error:This script must be run as root!${Font}"
        exit 1
    fi
}

#检测ovz
ovz_no(){
    if [[ -d "/proc/vz" ]]; then
        echo -e "${Red}Your VPS is based on OpenVZ，not supported!${Font}"
        exit 1
    fi
}

add_swap(){
echo -e "${Green}请输入需要添加的swap，建议为内存的2倍！${Font}"
read -p "请输入swap数值:" swapsize

#检查是否存在swapfile
grep -q "swapfile" /etc/fstab

#如果不存在将为其创建swap
if [ $? -ne 0 ]; then
	echo -e "${Green}swapfile未发现，正在为其创建swapfile${Font}"
	fallocate -l ${swapsize}M /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo '/swapfile none swap defaults 0 0' >> /etc/fstab
         echo -e "${Green}swap create SUCCESS!, info：${Font}"
         cat /proc/swaps
         cat /proc/meminfo | grep Swap
else
	echo -e "${Red}swapfile already exist, swap setting failed,Please execute the delete swap in the script first！${Font}"
fi
}

del_swap(){
#检查是否存在swapfile
grep -q "swapfile" /etc/fstab

#如果存在就将其移除
if [ $? -eq 0 ]; then
	echo -e "${Green}swapfile found and in the process of removing it...${Font}"
	sed -i '/swapfile/d' /etc/fstab
	echo "3" > /proc/sys/vm/drop_caches
	swapoff -a
	rm -f /swapfile
    echo -e "${Green}swap deled！${Font}"
else
	echo -e "${Red}swapfile not found ，swap del failed！${Font}"
fi
}

#开始菜单
main(){
root_need
ovz_no
clear
echo -e "———————————————————————————————————————"
echo -e "${Green}Linux VPS swap set script${Font}"
echo -e "${Green}1、set swap${Font}"
echo -e "${Green}2、del swap${Font}"
echo -e "———————————————————————————————————————"
read -p "Please input [1-2]:" num
case "$num" in
    1)
    add_swap
    ;;
    2)
    del_swap
    ;;
    *)
    clear
    echo -e "${Green}Input incorrect [1-2]${Font}"
    sleep 2s
    main
    ;;
    esac
}
main
