# eBizTop 系统部署指南

## 概述

eBizTop基于php和mysql开发，使用了php的laravel框架。部署的服务器必须运行在linux上。为了方便部署，把eBizTop运行环境打包成docker镜像，发布到运行linux的系统上，理论上也可以安装到支持docker的win10等系统上。

## 环境准备

我们部署的操作系统使用 **Ubuntu server 16.04 LTS 64位**， 下载地址为：[Ubuntu 16.04](http://releases.ubuntu.com/16.04.1/ubuntu-16.04.1-server-amd64.iso), 首先按正常方式先安装操作系统，最好能够连外网。

OS安装好后，需要通过USB把，docker 程序本身，docker-compose 配置文件，ebiztop 的 docker 镜像和 ebiztop 程序本身等文件复制到新装的 Ubuntu 系统上。复制后操作步骤如下：

### 安装 docker

把 docker 文件复制到 /usr/bin 目录。

```shell
sudo cp docker/* /usr/bin
```

#### 开启 dockerd 服务

TODO：使用 scripts 目录下的服务脚本，安装 dockerd 为服务。

简单开启 dockerd，注意配置选项，比如内存等。

```shell
sudo dockerd &
```

### 准备 docker 镜像

dockerd 开启后，就可以还原 eBizTop 的 docker 镜像了(ebiztop_docker.tar)。 **注意：docker 操作必须在 root 下操作**。

```shell
docker load < ebiztop_docker.tar
```

检查 docker-compose.yaml 文件，调整相关配置项。主要是数据卷的配置，**数据卷的映射必须使用绝对路径**。使用如下命令开启镜像。其中要检查下端口映射，如果是正式发布，最好映射的端口一致，比如："80:80"，这样便于访问。

```shell
docker-compose up
```

### 登录到 docker 容器

使用如下命令登录到新开启的 docker 容器， 该命令必须在 **root** 下执行。

```shell
docker exec -it maxwell_web_1 /bin/bash
```

其中的 maxwell_web_1 是刚开启的 docker 容器的名称。 可以通过 **docker ps**  查看。

### mysql 数据库设置

docker 镜像已经安装和配置好了数据库服务，在 docker-compose 启动时会自动挂载 db 目录到 mysql 的数据文件目录（/var/lib/mysql），这样就实现了数据的持久保存。

初始数据的处理有两种方式：

1. 事先准备好 ebiztop 的数据，包括初始表结构，及某个学校的数据。 制作过程中需要注意使用相同的版本，避免不同版本生成的 db 文件不兼容。
2. 用脚本初始化。sql 目录下有一个 **dump_school.sh** 的脚本，该脚本用来根据学校导致该学校的相关数据，生成类似 school_27.sql 这样的文件。具体执行命令如下（登录到docker容器执行）：

```shell
cd /www/eBizTop/web

php artisan migrate
php artisan db:seed

mysql -u homestead -p ebiztop < school_27.sql
```

访问系统前可以考虑执行一些清理操作。

```shell
php artisan clear-compiled
php artisan route:clear
....
```

### 截图功能

TODO
