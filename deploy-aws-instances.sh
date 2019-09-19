#!/bin/bash

./venv-ansible-playbook --vault-password-file private/aws_keys.yml -i inventory/ec2.py playbook.yaml

