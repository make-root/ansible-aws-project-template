#!/bin/bash

./venv-ansible-playbook --ask-vault-pass private/aws_keys.yml  -i inventory/ec2.py playbook.yaml

