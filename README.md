# eBizTop ϵͳ����ָ��

## ����

eBizTop����php��mysql������ʹ����php��laravel��ܡ�����ķ���������������linux�ϡ�Ϊ�˷��㲿�𣬰�eBizTop���л��������docker���񣬷���������linux��ϵͳ�ϣ�������Ҳ���԰�װ��֧��docker��win10��ϵͳ�ϡ�

## ����׼��

���ǲ���Ĳ���ϵͳʹ�� **Ubuntu server 16.04 LTS 64λ**�� ���ص�ַΪ��[Ubuntu 16.04](http://releases.ubuntu.com/16.04.1/ubuntu-16.04.1-server-amd64.iso), ���Ȱ�������ʽ�Ȱ�װ����ϵͳ������ܹ���������

OS��װ�ú���Ҫͨ��USB�ѣ�docker ������docker-compose �����ļ���ebiztop �� docker ����� ebiztop ��������ļ����Ƶ���װ�� Ubuntu ϵͳ�ϡ����ƺ�����������£�

### ��װ docker

�� docker �ļ����Ƶ� /usr/bin Ŀ¼��

```shell
sudo cp docker/* /usr/bin
```
TODO��ʹ�� scripts Ŀ¼�µķ���ű�����װ dockerd Ϊ����

�򵥿��� dockerd��ע������ѡ������ڴ�ȡ�

```shell
sudo dockerd &
```

### ׼�� docker ����

dockerd �����󣬾Ϳ��Ի�ԭ eBizTop �� docker ������(ebiztop.tar)�� **ע�⣺docker ���������� root �²���**��

```shell
docker load < ebiztop.tar
```

��� docker-compose.yaml �ļ�����������������Ҫ�����ݾ�����á�ʹ���������������
����Ҫ����¶˿�ӳ�䣬�������ʽ���������ӳ��Ķ˿�һ�£����磺"80:80"���������ڷ��ʡ�

```shell
docker-compose up
```

### mysql ��������

docker �����Ѿ���װ�����ú������ݿ������ docker-compose ����ʱ���Զ����� db Ŀ¼�� mysql �������ļ�Ŀ¼��/var/lib/mysql����������ʵ�������ݵĳ־ñ��档

**ϵͳ��Ҫʵ�ָ���ѧУ�������ݵĹ���**
