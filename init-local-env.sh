#/bin/bash

#Install VENV dependencies 
if [  -n "$(uname -a | grep Ubuntu)" ]; then
    sudo apt-get update
	sudo apt-get -y install python-pip python-virtualenv
else
    echo 'This OS still not supported. You should install Python and VENV dependencies manually.'
fi  


#Add gitignore info
#https://github.com/github/gitignore/blob/master/Global/Ansible.gitignore
grep -qxF '*.retry' .gitignore || echo '*.retry' >> .gitignore

#https://github.com/github/gitignore/blob/master/Global/VirtualEnv.gitignore
grep -qxF '.Python' .gitignore || echo '.Python' >> .gitignore
grep -qxF '[Bb]in' .gitignore || echo '[Bb]in' >> .gitignore
grep -qxF '[Ii]nclude' .gitignore || echo '[Ii]nclude' >> .gitignore
grep -qxF '[Ll]ib' .gitignore || echo '[Ll]ib' >> .gitignore
grep -qxF '[Ll]ib64' .gitignore || echo '[Ll]ib64' >> .gitignore
grep -qxF '[Ll]ocal' .gitignore || echo '[Ll]ocal' >> .gitignore
grep -qxF '[Ss]cripts' .gitignore || echo '[Ss]cripts' >> .gitignore
grep -qxF 'pyvenv.cfg' .gitignore || echo 'pyvenv.cfg' >> .gitignore
grep -qxF '.venv' .gitignore || echo '.venv' >> .gitignore
grep -qxF 'pip-selfcheck.json' .gitignore || echo 'pip-selfcheck.json' >> .gitignore 


#Download additional dependencies 
if [  -n "$(uname -a | grep Ubuntu)" ]; then
    sudo apt-get update
    sudo apt-get -y install wget
else
    echo 'This OS still not supported. You should install additional dependencies manually.'
fi  

mkdir -p inventory

EC2PY=inventory/ec2.py
if [ -f "$EC2PY" ]; then
    echo "$EC2PY exist"
else 
    echo "$EC2PY does not exist"
    wget -P inventory/ https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py
fi


chmod 750 inventory/ec2.py
#wget -P inventory/ https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini 


mkdir -p private
touch .gitignore
#grep -qxF 'private/' .gitignore || echo 'private/' >> .gitignore
#grep -qxF 'private/*' .gitignore || echo 'private/*' >> .gitignore

#Get ansible to local .venv
./venv-ansible-playbook

grep -qxF 'private/aws_keys.yml' .gitignore || echo 'private/aws_keys.yml' >> .gitignore

AWSKEYS=private/aws_keys.yml
if [ -f "$AWSKEYS" ]; then
    echo "$AWSKEYS exist"
else 
    echo "$AWSKEYS does not exist"
    .venv/bin/ansible-vault create private/aws_keys.yml
fi




#touch private/.boto
#echo '[Credentials]' >> private/.boto
#echo 'aws_access_key_id = YOURACCESSKEY' >> private/.boto
#echo 'aws_secret_access_key = YOURSECRETKEY' >> private/.boto
#echo 'You should put aws_access_key_id and aws_secret_access_key to .boto file in private dir'
