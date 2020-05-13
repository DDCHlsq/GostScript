#!/bin/bash

# function area

downGost(){
	yum -y install wget
	apt-get install wget -y
	wget https://github.com/ginuerzh/gost/releases/download/v2.11.0/gost-linux-amd64-2.11.0.gz
	gunzip gost-linux-amd64-2.11.0.gz
	mv gost-linux-amd64-2.11.0 gost
	chmod +x gost
	mv gost /usr/bin/
	echo -e "\033[33mGost安装已完成。直接输入命令"gost"来确定。\033[0m"
}

setServer(){

	tunnelType="ws"
	tunnelPort="12345"
	serviceAddr="127.0.0.1"
	servicePort="1234"

	reset

	echo -e "\033[33m你选择了配置Gost服务端\n\n\033[0m"

	echo -e "\033[33m\n现在请输入隧道的服务端口[0-65535]：\c\033[0m"
	read tunnelPort

	echo -e "\033[33m\n现在请输入你要转发到的服务的地址\n例如你有一个ss运行在本地，那么填127.0.0.1：\c\033[0m"
	read serviceAddr

	echo -e "\033[33m\n现在请输入你要转发到的服务的端口\n例如你有一个ss运行在1234端口，那么填1234：\c\033[0m"
	read servicePort

	echo -e "\033[33m\n所有的条件都集齐了！\n请确认：\n隧道类型：${tunnelType}\n隧道端口：${tunnelPort}\n服务地址：${serviceAddr}\n服务端口：${servicePort}\n\033[0m"

	echo -e "\033[33m是否确认？（否定将退出脚本）[y/n]：\c\033[0m"

	read YorN

	if [ $YorN = "y" ]
	then
		echo -e "\033[33m\n确认了！\n\033[0m"

		cmd="nohup gost -L "${tunnelType}"://:"${tunnelPort}"/"${serviceAddr}":"${servicePort}" &"
		echo -e "$cmd\n"
		eval $cmd

		echo -e "\033[33m\n后台执行成功！\n\033[0m"
	else
		echo "\033[33m脚本退出\033[0m"
		exit 1
	fi

	echo -e "\033[33m \nヾ(￣▽￣)Bye~Bye~\n \033[0m"
}

setClient(){
	tunnelAddr="127.0.0.1"
	tunnelType="ws"
	tunnelPort="8000"
	tcpPort="9999"

	reset

	echo -e "\033[33m你选择了配置Gost服务端\n\n现在请输入服务端的IP地址：\033[0m\c"

	read tunnelAddr

	echo -e "\033[33m\n现在请输入服务端隧道的工作端口：\033[0m\c"

	read tunnelPort

	echo -e "\033[33m\n现在请输入本地TCP监听端口：\033[0m\c"

	read tcpPort

	echo -e "\033[33m\n请确认：\n服务端地址：${tunnelAddr}\n隧道端口：${tunnelPort}\n隧道类型：${tunnelType}\n本地TCP监听端口：${tcpPort}\n\033[0m"

	echo -e "\033[33m是否确认？（否定将退出脚本）[y/n]：\c\033[0m"

	read YorN

	if [ $YorN = "y" ]
	then
		echo -e "\033[33m\n确认了！\n\033[0m"

		cmd="nohup gost -L tcp://:"${tcpPort}" -F forward+"${tunnelType}"://"${tunnelAddr}":"${servicePort}" &"
		echo -e "$cmd\n"
		eval $cmd

		echo -e "\033[33m\n后台执行成功！\n\033[0m"
	else
		echo -e "\033[33m脚本退出\033[0m"
		exit 1
	fi

	echo -e "\033[33m \nヾ(￣▽￣)Bye~Bye~\n\033[0m"
}

# function area end

reset

echo -e "\033[32m--------------------------------------------------------------\033[0m"

echo -e "\033[33m欢迎使用DDCH的GOST脚本\033[0m"
echo -e "\033[33m本脚本旨在为大家快速部署安全隧道,请勿违反当地法律\033[0m"
echo -e "\033[33m联系作者：iamddch@gmail.com\033[0m"

echo -e "\033[32m--------------------------------------------------------------\033[0m"


echo -e "\033[32m请选择今天要做的事\n\033[0m"

echo -e "\033[33m0.安装Gost（从Github，中国大陆访问会慢）\n\033[0m"
echo -e "\033[33m1.配置 隧道 服务端\n\033[0m"
echo -e "\033[33m2.配置 隧道 客户端\n\033[0m"
echo -e "\033[33m3.查看正在运行的Gost进程\n\033[0m"
echo -e "\033[33m4.配置本机Shadowsocks\n\033[0m"
echo -e "\033[33m5.退出脚本\n\033[0m"

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
	ps -aux | grep "gost -"
elif [ $chs = "4" ]
then
	reset
	ssPort="54321"
	ssCipher="aes-128-cfb"
	ssPass="111222"
	echo -e "\033[33m配置Shadowsocks\n\nShadowSocks运行端口：\033[0m\c"
	read ssPort
	echo -e "\033[33m\n注意，这里要自己输入，而不是用选项，如果输错了无法正常运行。例如输入aes-128-cfb\nShadowSocks加密方法：\033[0m\c"
	read ssCipher
	echo -e "\033[33m\nShadowSocks密码：\033[0m\c"
	read ssPass
	commd="gost -L ss://"${ssCipher}":"${ssPass}"@:"${ssPort}" &"
	eval ${commd}
	echo -e "\033[33m运行成功！\033[0m\c"
elif [ $chs = "5" ]
then
	exit 1
else
	echo "错误输入，脚本结束"
fi
