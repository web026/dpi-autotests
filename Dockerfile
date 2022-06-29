FROM ubuntu:20.04
MAINTAINER Sergey 'shakhbazov@protei.ru'

RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

RUN \
apt-get update && \
apt-get install -y tzdata && \
apt-get install -qy python3-pip  && \
apt-get install -y git && \
apt-get install -qy mc && DEBIAN_FRONTEND=noninteractive
ADD ./add_hosts.sh /root/
RUN chmod +x /root/add_hosts.sh  && \
    exec /root/add_hosts.sh  && \
    cat /etc/hosts
RUN mkdir -p /home/support/git && \
    cd /home/support/git && \
    git clone https://git.protei.ru/dpi-qa/dpi-autotests
RUN mkdir -p /home/support/RobotFramework/protei-dpi-autotest && \
    cp -r /home/support/git/dpi-autotests/protei-dpi-autotest /home/support/RobotFramework/
RUN pip3 config set --user global.index-url https://repo.protei.ru/repository/qa-pypi-proxied/simple && \
    pip3 install -r /home/support/RobotFramework/protei-dpi-autotest/requirements.txt && \
    pip3 install markupsafe==2.0.1

RUN export STAND=stand_4
WORKDIR /home/protei/dpi-autotest
