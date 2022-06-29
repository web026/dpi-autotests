FROM ubuntu:20.04
MAINTAINER Sergey 'shakhbazov@protei.ru'

RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

RUN \
apt-get update && \
apt-get install -y tzdata && \
apt-get install -qy python3-pip  && \
apt-get install -y git && \
apt-get install -qy mc && DEBIAN_FRONTEND=noninteractive

WORKDIR /home/protei/dpi-autotest

COPY dpi-autotest .
ADD ./add_hosts.sh /root/
RUN pip3 config set --user global.index-url https://repo.protei.ru/repository/qa-pypi-proxied/simple

RUN chmod +x /root/add_hosts.sh
RUN exec /root/add_hosts.sh

#RUN pip3 install -r ./protei-dpi-autotest/requirements.txt
#RUN pip3 install markupsafe==2.0.1
