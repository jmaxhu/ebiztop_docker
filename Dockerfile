FROM ubuntu:16.04

MAINTAINER James Maxwell <james.maxwell.hu@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Change apt sources
# ADD sources.list.xenial /etc/apt/sources.list

# Install packages
ADD provision.sh /provision.sh
ADD serve.sh /serve.sh
ADD startup.sh /startup.sh
ADD phantomjs-2.1.1-linux-x86_64.tar.bz2 /
ADD simsun.ttc /usr/share/fonts/

ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN chmod +x /*.sh

RUN ./provision.sh

EXPOSE 80
CMD ["/usr/bin/supervisord"]
