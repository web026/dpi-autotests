#!/bin/bash
echo "192.168.0.16  repo.protei.ru" >> /etc/hosts
echo "192.168.0.131  git.protei.ru" >> /etc/hosts

#mkdir -p /home/support/git/dpi-autotests
#cd /home/support/git/dpi-autotests
#git clone https://git.protei.ru/dpi-qa/dpi-autotests
#cp -r /home/support/git/dpi-autotests/protei-dpi-autotest /home/support/RobotFramework/protei-dpi-autotest
pip3 config set --user global.index-url https://repo.protei.ru/repository/qa-pypi-proxied/simple
pip3 install -r /home/support/git/dpi-autotests/protei-dpi-autotest/requirements.txt
pip3 install markupsafe==2.0.1