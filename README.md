# Gost Script
本脚本帮助你快速构建Gost安全隧道，保证数据安全有效传输。

## 使用说明

本脚本**最适用于CentOS7**，当然其他系统也都可以用。

使用脚本之前需要有`wget`，没有的话先安装

```bash
yum -y install wget
```

```shell
apt-get install wget
```

然后输入以下命令一键下载、赋权、运行

```shell
wget https://github.com/DDCHlsq/GostScript/releases/download/1.0/gost.sh && chmod +x gost.sh && ./gost.sh
```

运行之后按照引导来即可。

**客户端运行在中转机器（见图解），服务端运行在最终服务提供机。**

## 图解说明

本脚本构建的隧道可以用以下表示：

![Gost拓扑](http://cos.nju.world:9000/public-pictures/GithubPics/Gost拓扑.jpg)

隧道在这里的作用就是，让**最左侧**的终端都能安全的接入**最右侧**的**最终服务**。
