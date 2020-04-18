#!/bin/bash

# function area

downGost(){
	`reset`
	echo -e "\033[33m你选择了下载Gost\n\033[0m\033[31m注意哦，本操作需要有wget，没有的话提示成功也是失败的哦\n\033[0m"

	echo -e "\033[33m0.我是amd64的VPS，选这个下载\n\033[0m"
	echo -e "\033[33m1.我是arm v7的设备，如树莓派，选此下载\n\033[0m"
	echo -e "\033[33m2.现在退出还来得及！\n\033[0m"

	echo -e "\033[33m撒，你的选择！[0-2]：\c\033[0m"	

	read chss

	if [ $chss = "0" ]
	then	
		`wget https://github.com/ginuerzh/gost/releases/download/v2.11.0/gost-linux-amd64-2.11.0.gz`
		`gunzip gost-linux-amd64-2.11.0.gz`
		`mv gost-linux-amd64-2.11.0 gost`
		`chmod +x gost`
		echo "\033[33mgost 2.11.0 amd64 下载成功，且已经解压、赋权，改名为 gost，脚本退出\033[0m"
	elif [ $chss = "1" ]
	then
		`wget https://github.com/ginuerzh/gost/releases/download/v2.11.0/gost-linux-armv7-2.11.0.gz`
		`gunzip gost-linux-armv7-2.11.0.gz`
		`mv gost-linux-armv7-2.11.0 gost`
		`chmod +x gost`
		echo "\033[33mgost 2.11.0 armv7 下载成功，且已经解压、赋权，改名为 gost，脚本退出\033[0m"
	elif [ $chss = "2" ]
	then
		exit 1
	else
		echo "输入错误，脚本退出"
		exit 1
	fi
}

setServer(){

	tunnelType="ws"
	tunnelPort="12345"
	serviceAddr="127.0.0.1"
	servicePort="1234"
	
	`reset`
	
	echo -e "\033[33m你选择了配置Gost服务端\n\n现在请选择想要部署的隧道（暂时仅TCP）\033[0m"

	echo -e "\033[33m0.ws (WebSocket)\n\033[0m"
	echo -e "\033[33m1.wss (Secured WebSocket)\n\033[0m"
	echo -e "\033[33m2.tls\n\033[0m"
	echo -e "\033[33m3.h2 (http2)\n\033[0m"
	echo -e "\033[33m4.ssh\n\033[0m"
	echo -e "\033[33m5.现在退出还来得及！\n\033[0m"

	echo -e "\033[33m撒，你的选择！[0-5]：\c\033[0m"	

	read chss

	if [ $chss = "0" ]
	then
		tunnelType="ws"
	elif [ $chss = "1" ]
	then
		tunnelType="wss"
	elif [ $chss = "2" ]
	then
		tunnelType="tls"
	elif [ $chss = "3" ]
	then
		tunnelType="h2"
	elif [ $chss = "4" ]
	then
		tunnelType="ssh"
	elif [ $chss = "5" ]
	then
		echo "脚本退出"
		exit 1
	fi
	
	echo -e "\033[33m\n现在请输入隧道的服务端口[8000-65535]：\c\033[0m"
	read tunnelPort
	
	echo -e "\033[33m\n现在请输入你要转发到的服务的地址\n例如你有一个ss运行在本地，那么填127.0.0.1：\c\033[0m"
	read serviceAddr
	
	echo -e "\033[33m\n现在请输入你要转发到的服务的端口\n例如你有一个ss运行在1234端口，那么填1234：\c\033[0m"
	read servicePort
	
	echo -e "\033[33m\nこれで全ての条件はクリアされた!!\n所有的条件都集齐了！\n请确认：\n隧道类型：${tunnelType}\n隧道端口：${tunnelPort}\n服务地址：${serviceAddr}\n服务端口：${servicePort}\n\033[0m"
	
	echo -e "\033[33m是否确认？（否定将退出脚本）[Y/N]：\c\033[0m"
	
	read YorN
	
	if [ $YorN = "Y" ]
	then
		echo -e "\033[33m\n确认了！\n\033[0m"
		
		cmd="nohup ./gost -L "${tunnelType}"://:"${tunnelPort}"/"${serviceAddr}":"${servicePort}" &"
		echo -e "$cmd\n"
		eval $cmd
		
		echo -e "\033[33m\n后台执行成功！\n\033[0m"
	else
		echo "\033[33m脚本退出\033[0m"
		exit 1
	fi
	
	echo -e "\n\033[33m是否加入开机自启动？\n\033[31m（只保证CentOS7有效，且此行为会使得开机自启动文件完全重置，请小心决定）\n\033[33m[Y/N]：\033[0m\c"
	
	read YYNN
	
	if [ $YYNN = "Y" ]
	then
		echo -e "\033[33m\n加入开机自启动!\n\033[0m"
		`rm -f /etc/rc.d/rc.local`
		echo "${cmd}" > /etc/rc.d/rc.local
		`chmod +x /etc/rc.d/rc.local`
	else
		echo -e "\033[33m \nヾ(￣▽￣)Bye~Bye~\n \033[0m"
	fi
}

setClient(){
	tunnelAddr="127.0.0.1"
	tunnelType="ws"
	tunnelPort="8000"
	tcpPort="9999"
	
	`reset`
	
	echo -e "\033[33m你选择了配置Gost服务端\n\n现在请输入服务端的IP地址：\033[0m\c"
	
	read tunnelAddr
	
	echo -e "\033[33m\n现在请输入服务端隧道的工作端口：\033[0m\c"
	
	read tunnelPort
	
	echo -e "\033[33m\n现在请输入服务端隧道的类型：\033[0m\n"

	echo -e "\033[33m0.ws (WebSocket)\n\033[0m"
	echo -e "\033[33m1.wss (Secured WebSocket)\n\033[0m"
	echo -e "\033[33m2.tls\n\033[0m"
	echo -e "\033[33m3.h2 (http2)\n\033[0m"
	echo -e "\033[33m4.ssh\n\033[0m"

	echo -e "\033[33m撒，你的选择！[0-4]：\c\033[0m"
	
	read chss
	
	if [ $chss = "0" ]
	then
		tunnelType="ws"
	elif [ $chss = "1" ]
	then
		tunnelType="wss"
	elif [ $chss = "2" ]
	then
		tunnelType="tls"
	elif [ $chss = "3" ]
	then
		tunnelType="h2"
	elif [ $chss = "4" ]
	then
		tunnelType="ssh"
	else
		echo "输入错误，脚本退出"
		exit 1
	fi
	
	echo -e "\033[33m\n现在请输入本地TCP监听端口：\033[0m\c"
	
	read tcpPort
	
	echo -e "\033[33m\nこれで全ての条件はクリアされた!!\n所有的条件都集齐了！\n请确认：\n服务端地址：${tunnelAddr}\n隧道端口：${tunnelPort}\n隧道类型：${tunnelType}\n本地TCP监听端口：${tcpPort}\n\033[0m"
	
	echo -e "\033[33m是否确认？（否定将退出脚本）[Y/N]：\c\033[0m"
	
	read YorN
	
	if [ $YorN = "Y" ]
	then
		echo -e "\033[33m\n确认了！\n\033[0m"
		
		cmd="nohup ./gost -L tcp://:"${tcpPort}" -F forward+"${tunnelType}"://"${tunnelAddr}":"${servicePort}" &"
		echo -e "$cmd\n"
		eval $cmd
		
		echo -e "\033[33m\n后台执行成功！\n\033[0m"
	else
		echo -e "\033[33m脚本退出\033[0m"
		exit 1
	fi
	
	echo -e "\n\033[33m是否加入开机自启动？\n\033[31m（只保证CentOS7有效，且此行为会使得开机自启动文件完全重置，请小心决定）\n\033[33m[Y/N]：\033[0m\c"
	
	read YYNN
	
	if [ $YYNN = "Y" ]
	then
		echo -e "\033[33m\n加入开机自启动!\n\033[0m"
		`rm -f /etc/rc.d/rc.local`
		echo "${cmd}" > /etc/rc.d/rc.local
		`chmod +x /etc/rc.d/rc.local`
	else
		echo -e "\033[33m \nヾ(￣▽￣)Bye~Bye~\n\033[0m"
	fi
}

# function area end

`reset`

echo -e "\033[32m--------------------------------------------------------------\033[0m"

echo -e "\033[33m欢迎使用DDCH的GOST脚本\033[0m"
echo -e "\033[33m本脚本旨在为大家快速部署安全隧道,请勿用于违法行为\033[0m"
echo -e "\033[33m联系作者：iamddch@gmail.com\033[0m"
echo -e "\033[33m骚扰者一律拉黑\033[0m"

echo -e "\033[32m--------------------------------------------------------------\033[0m"


echo -e "\033[32m请选择今天要做的事\n\033[0m"

echo -e "\033[33m0.下载并解压gost文件在本目录下（如果本目录没有gost请先执行！）\n\033[0m"
echo -e "\033[33m1.配置 服务端\n\033[0m"
echo -e "\033[33m2.配置 客户端\n\033[0m"
echo -e "\033[33m3.退出脚本\n\033[0m"

echo -e "\033[33m我要选择[0-3]：\033[0m\c"
read chs


if [ $chs = "0" ]
then
	downGost
elif [ $chs = "1" ]
then
	setServer
elif [ $chs = "2" ]
then
	setClient
elif [ $chs = "3" ]
then
	exit 1
else
	echo "错误输入，脚本结束"
fi
