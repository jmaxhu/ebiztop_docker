# eBizTop系统部署指南

## 概述

eBizTop基于php和mysql开发，使用了php的laravel框架。部署的服务器必须运行在linux上。为了方便部署，把eBizTop运行环境打包成docker镜像，发布到运行linux的系统上。

## 环境准备

我们部署的操作系统使用 **ubuntu desktop 16.04.1 LTS 64位**， 下载地址为：[Ubuntu 16.04.1](http://mirrors.aliyun.com/ubuntu-releases/16.04.1/ubuntu-16.04.1-desktop-amd64.iso), 首先按正常方式先安装操作系统，最好能够连外网。安装时请新建一个 **maxwell** 的用户名，后面启动 docker 容器时会用到。也可以安装好后，再新建这个用户。

OS安装好后，需要通过USB把，docker 程序本身，docker-compose 配置文件，ebiztop 的 docker 镜像和 ebiztop 程序本身等文件复制到新装的 Ubuntu 系统上，路径为， /home/maxwell。然后打开命令行终端，并转到复制文件所在目录。复制后操作步骤如下：

### 安装 docker

把 docker 文件复制到 /usr/bin 目录。

```shell
sudo cp docker/* /usr/bin
```

#### 开启 dockerd 服务

```shell
sudo dockerd &
```

### 准备 docker 镜像

dockerd 开启后，就可以还原 eBizTop 的 docker 镜像了(ebiztop_docker.tar.bz2)。 **注意：docker 操作必须在 root 下操作**。

```shell
tar xjvf ebiztop_docker.tar.bz2 # 先解压
docker load < ebiztop_web.tar
docker load < ebiztop_db.tar
```

### 准备 eBizTop 程序

确认当前目录下有以下文件和目录。 docker-compose.yml, eBizTop.tar.gz, sql, db(初次安装该目录为空)

```shell
tar xzf eBizTop.tar.gz
```

### 启动 docker

```shell
docker-compose up
```

### 登录到 docker 容器

使用如下命令登录到新开启的 docker 容器， 该命令必须在 **root** 下执行。新开一个terminal，执行以下命令，如要退出容器，执行 exit 即可。

```shell
docker exec -it ebiztop_web /bin/bash
```

其中的 ebiztop_web 是刚开启的 docker 容器的名称。 可以通过 **docker ps**  查看。
登录容器后，需要修改 web 的配置，设置正确的系统访问地址，并初始化表结构和初始数据。操作如下：

```shell
cd /www/eBizTop/web

vim .env
```

修改以下配置项：

```
APP_URL=http://www.ebiztop.com

DB_HOST=db
```
把 APP_URL 这个地址修改成当前部署服务器的ip或域名。 最后不要带'/'。把 DB_HOST 改成 db，原来的值可能是127.0.0.1。

修改完保存后，再执行如下命令初经化数据库表结构：

```shell
php artisan migrate
php artisan db:seed
php artisan clear-compiled

exit
```

### mysql 数据库设置

mysql 现在在单独的容器里运行（ebiztop_db）。数据库数据通过数据卷的方式映射到 db 目录。安装时容器会自动初始化mysql的系统相关表，所以初次安装时请**保证db目录为空**。
ebiztop的数据库在容器初始化时自动新建，但需要手工导入学校相关数据。操作如下。

```shell
docker exec -it ebiztop_db /bin/bash

cd sql

mysql -u homestead -psecret ebiztop < school_27.sql

exit
```

## 访问系统

打开浏览器，输入部署服务器的 ip 或域名即可访问系统。 每个学校有一个学校管理员的账号，登录后即可使用系统。具体详见操作手册。
