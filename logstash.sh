
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
sudo yum install -y logstash
sudo  chkconfig --add logstash
sudo /opt/logstash/bin/plugin install logstash-input-jdbc
sudo wget -P /tmp http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.tar.gz
sudo mkdir -p /opt/logstash/drivers
sudo tar -zxvf /tmp/mysql-connector-java*.tar.gz -C /opt/logstash/drivers
sudo chown -R logstash:logstash /opt/logstash/drivers