FROM ubuntu:16.04
MAINTAINER James Maxwell <james.maxwell.hu@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Change apt sources
ADD sources.list.xenial /etc/apt/sources.list

# Install packages
ADD provision.sh /provision.sh
ADD serve.sh /serve.sh
ADD startup.sh /startup.sh

ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN chmod +x /*.sh

RUN ./provision.sh

EXPOSE 80 22 35729 9876
CMD ["/bin/bash", "/startup.sh"]
