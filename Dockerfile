FROM ubuntu:20.04
MAINTAINER Sergey 'shakhbazov@protei.ru'

ARG STAND=stand9
ARG IP=1.1.1.2
ARG BRANCH=docker

LABEL \
docker run -e STAND="stand9" --add-host=repo.protei.ru:192.168.0.16 --add-host=git.protei.ru:192.168.0.131 --network dpi_net --ip 1.1.1.2 --hostname dpi-autotest -it --rm dpi-tests-new \
docker run -e STAND="stand9" --network dpi_net --ip 1.1.1.2 --hostname dpi-autotest -it --rm dpi-tests-new-3
LABEL \
docker network create \
  --driver=bridge \
  --subnet=1.1.1.0/24 \
  --ip-range=1.1.1.0/24 \
  --gateway=1.1.1.254 \
  dpi_net

RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

RUN \
    apt-get update && \
    apt-get install -y tzdata && \
    apt-get install -qy python3-pip  && \
    apt-get install -y python2-minimal  && \
    apt-get install -y python-dev  && \
    apt-get install -y git && \
    apt-get install -y libsctp-dev && \
    apt-get install -qy mc && DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y iputils-ping &&\
    apt-get install -y net-tools

RUN apt-get install -y openssh-server &&\
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config &&\
    /etc/init.d/ssh start

RUN mkdir -p /home/support/git && \
    cd /home/support/git && \
    echo "192.168.0.16  repo.protei.ru" >> /etc/hosts   && \
    echo "192.168.0.131  git.protei.ru" >> /etc/hosts  && \
    cat /etc/hosts && \
    git clone https://git.protei.ru/dpi-qa/dpi-autotests && \
    git checkout ${BRANCH} && \
    mkdir -p /home/support/RobotFramework/protei-dpi-autotest && \
    cp -r /home/support/git/dpi-autotests/protei-dpi-autotest /home/support/RobotFramework/  && \
    pip3 config set --user global.index-url https://repo.protei.ru/repository/qa-pypi-proxied/simple && \
    pip3 install -r /home/support/git/dpi-autotests/protei-dpi-autotest/requirements.txt && \
    pip3 install markupsafe==2.0.1 && \
    pip3 install virtualenv

WORKDIR /home/support/RobotFramework/protei-dpi-autotest/
