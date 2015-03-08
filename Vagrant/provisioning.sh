yum install -y java-1.7.0-openjdk.x86_64
yum install -y mlocate
yum install -y telnet
yum install -y screen
yum install -y vim
yum install -y git


git clone -b pull18  https://github.com/stevengonsalvez/kibana-authentication-proxy.git
git clone https://github.com/stevengonsalvez/vagrant-e1.4k3.git

#sed -i -e 's|#adminpass=|adminpass='$password'|' ./vagrant-e1.4k3/elasticsearch.sh
#sed -i -e 's|echo -n "Enter a password to use for elasticsearch basic auth - the user is admin# "|#echo -n "Enter a password to use for the admin account to login to the vagrant-e1.4k3 webUI: "|' ./vagrant-e1.4k3/elasticsearch.sh
#sed -i -e 's|read adminpass|#read adminpass|' ./vagrant-e1.4k3/elasticsearch.sh
#sed -i -e 's|pause 'Press [Enter] key to continue...'|#pause 'Press [Enter] key to continue...'|' ./vagrant-e1.4k3/elasticsearch.sh
chmod +x ./vagrant-e1.4k3/elasticsearch.sh
./vagrant-e1.4k3/elasticsearch.sh

chmod +x ./vagrant-e1.4k3/kibana3.sh
./vagrant-e1.4k3/kibana3.sh

#rm -rf ./vagrant-e1.4k3
