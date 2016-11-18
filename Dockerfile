FROM shincoder/homestead:php7.0

MAINTAINER James Maxwell <james.maxwell.hu@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Change apt sources
ADD sources.list.xenial /etc/apt/sources.list

# Install packages
ADD provision_upgrade.sh /provision_upgrade.sh
ADD serve.sh /serve.sh
ADD startup.sh /startup.sh

ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN chmod +x /*.sh

RUN ./provision_upgrade.sh

EXPOSE 80 22 35729 9876
CMD ["/usr/bin/supervisord"]
