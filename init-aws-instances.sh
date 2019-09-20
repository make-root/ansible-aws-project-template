#!/bin/bash

./venv-ansible-playbook --ask-vault-pass private/aws_keys.yml init-aws-instances.yml
