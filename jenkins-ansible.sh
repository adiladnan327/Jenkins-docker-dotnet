mkdir jenkins/jenkins_home/ansible

cp centos/remote-key jenkins/jenkins_home/ansible

touch centos/remote-key jenkins/jenkins_home/ansible/hosts

chown jenkins:jenkins remote-key

ls -l /run/nologin

rm /run/nologin


