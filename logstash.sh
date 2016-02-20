
sudo rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
 
sudo bash -c 'cat >/etc/yum.repos.d/logstash.repo << EOL
[logstash-2.2]
name=logstash repository for 2.2 packages
baseurl=http://packages.elasticsearch.org/logstash/2.2/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1
EOL
'