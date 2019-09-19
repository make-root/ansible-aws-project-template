#/bin/bash
sudo apt-get update
sudo apt-get -y install python-pip python-virtualenv

./venv-ansible-playbook -i "localhost," -c local playbook.yaml --ask-become-pass
