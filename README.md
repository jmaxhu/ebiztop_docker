# eBizTop ϵͳ����ָ��

## ����

eBizTop����php��mysql������ʹ����php��laravel��ܡ�����ķ���������������linux�ϡ�Ϊ�˷��㲿�𣬰�eBizTop���л��������docker���񣬷���������linux��ϵͳ�ϣ�������Ҳ���԰�װ��֧��docker��win10��ϵͳ�ϡ�

## ����׼��

���ǲ���Ĳ���ϵͳʹ�� **ubuntu desktop 16.04.1 LTS 64λ**�� ���ص�ַΪ��[Ubuntu 16.04.1](http://mirrors.aliyun.com/ubuntu-releases/16.04.1/ubuntu-16.04.1-desktop-amd64.iso), ���Ȱ�������ʽ�Ȱ�װ����ϵͳ������ܹ�����������װʱ���½�һ�� **maxwell** ���û������������� docker ����ʱ���õ���Ҳ���԰�װ�ú����½�����û���

OS��װ�ú���Ҫͨ��USB�ѣ�docker ������docker-compose �����ļ���ebiztop �� docker ����� ebiztop ��������ļ����Ƶ���װ�� Ubuntu ϵͳ�ϣ�·��Ϊ�� /home/maxwell��Ȼ����������նˣ���ת�������ļ�����Ŀ¼�����ƺ�����������£�

### ��װ docker

�� docker �ļ����Ƶ� /usr/bin Ŀ¼��

```shell
sudo cp docker/* /usr/bin
```

#### ���� dockerd ����

TODO��ʹ�� scripts Ŀ¼�µķ���ű�����װ dockerd Ϊ����

�򵥿��� dockerd��ע������ѡ������ڴ�ȡ�

```shell
sudo dockerd &
```

### ׼�� docker ����

dockerd �����󣬾Ϳ��Ի�ԭ eBizTop �� docker ������(ebiztop_docker.tar)�� **ע�⣺docker ���������� root �²���**��

```shell
docker load < ebiztop_docker.tar
```

��� docker-compose.yaml �ļ�����������������Ҫ�����ݾ�����ã�**���ݾ��ӳ�����ʹ�þ���·��**��ʹ�������������������Ҫ����¶˿�ӳ�䣬�������ʽ���������ӳ��Ķ˿�һ�£����磺"80:80"���������ڷ��ʡ�

```shell
docker-compose up
```

### ��¼�� docker ����

ʹ�����������¼���¿����� docker ������ ����������� **root** ��ִ�С�

```shell
docker exec -it maxwell_web_1 /bin/bash
```

���е� maxwell_web_1 �Ǹտ����� docker ���������ơ� ����ͨ�� **docker ps**  �鿴��
��¼��������Ҫ�޸� web �����ã�������ȷ��ϵͳ���ʵ�ַ���������£�

```shell
cd /www/eBizTop/web
vim .env
```

�޸����������

```
APP_URL=http://www.ebiztop.com
```

�������ַ�޸ĳɵ�ǰ�����������ip�������� ���Ҫ��'/'��

### mysql ���ݿ�����

docker �����Ѿ���װ�����ú������ݿ������ docker-compose ����ʱ���Զ����� db Ŀ¼�� mysql �������ļ�Ŀ¼��/var/lib/mysql����������ʵ�������ݵĳ־ñ��档

��ʼ���ݵĴ��������ַ�ʽ��

1. ����׼���� ebiztop �����ݣ�������ʼ��ṹ����ĳ��ѧУ�����ݡ� ������������Ҫע��ʹ����ͬ�İ汾�����ⲻͬ�汾���ɵ� db �ļ������ݡ�
2. �ýű���ʼ����sql Ŀ¼����һ�� **dump_school.sh** �Ľű����ýű���������ѧУ���¸�ѧУ��������ݣ��������� school_27.sql �������ļ�������ִ���������£���¼��docker����ִ�У���

```shell
cd /www/eBizTop/web

php artisan migrate
php artisan db:seed

mysql -u homestead -p ebiztop < school_27.sql
```

����ϵͳǰ���Կ���ִ��һЩ���������

```shell
php artisan clear-compiled
php artisan route:clear
....
```

### ��ͼ����

��ͼ������� NodeJs����¼�����������޸������ļ�(/www/eBizTop/screenshot/config.json), �޸����е� server ��ַ�����óɵ�ǰ�������̨��������ip��������

```javascript
{
  "server": "http://www.ebiztop.com/case/"
}
````

ִ��ִ�������������ͼ����

```shell
pm2 start process.yml
```

## ����ϵͳ

������������벿������ ip ���������ɷ���ϵͳ�� ÿ��ѧУ��һ��ѧУ����Ա���˺ţ���¼�󼴿�ʹ��ϵͳ��������������ֲᡣ
