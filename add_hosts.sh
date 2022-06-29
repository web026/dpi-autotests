#!/bin/bash
echo "192.168.0.16  repo.protei.ru" >> /etc/hosts
echo "192.168.0.131  git.protei.ru" >> /etc/hosts
pip3 install -r ./protei-dpi-autotest/requirements.txt
pip3 install markupsafe==2.0.1
