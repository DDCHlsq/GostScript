# Gost Script

本脚本帮助你快速构建Gost安全隧道，保证数据安全有效传输。

## 更新说明

`v2.0`中去掉繁琐设置，默认使用WebSocket隧道，入口只支持TCP。同时，去掉开机自启动选项，增加配置本地Shadowsocks服务选项，增加查看正在运行的Gost命令选项。

**要注意，所有通过本脚本配置的服务都是一次性的，重启之后需要再度运行**。

这一更新主要原因是，大多数想使用脚本的人，都想快速简单的开始。

如果你不是这一类人，可以去阅读Gost官方文档。

## 使用说明

**本脚本适用于绝大多数主流Linux系统，对应平台为AMD64**。

使用脚本之前需要有`wget`，没有的话先安装

```bash
yum -y install wget
```

```shell
apt-get install wget
```

然后输入以下命令一键下载、赋权、运行

```shell
wget https://github.com/DDCHlsq/GostScript/releases/download/2.0/gost.sh && chmod +x gost.sh && ./gost.sh
```

运行之后按照引导来即可。

**客户端运行在中转机器（见图解），服务端运行在最终服务提供机。**

## 图解说明

本脚本构建的隧道可以用以下表示：

![Gost拓扑](http://cos.nju.world:9000/public-pictures/GithubPics/Gost拓扑.jpg)

隧道在这里的作用就是，让**最左侧**的终端都能安全的接入**最右侧**的**最终服务**。