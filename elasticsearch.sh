#! /bin/bash
# place the package elasticsearch-1.4.4.rpm or whatever is the latest version in the ./files folder or you can do a wget and alter the script to dynamically download as well.
# Also download the latest java version - preverabbly do a apt-get for openjdk 1.7 - Refer to the graylog2 install in the other repository



# Set variables
FILES=Vagrant/files

# Java is already installed from provisioning.sh - if  you have a custom version of java , place it in files and use it from here
# Install java 7
#if [ "$1" == "64" ]; then
#       jre="jre-7u75-linux-x64.tar.gz"
#else
#       jre="jre-7u75-linux-i586.tar.gz"
#fi

#tar -C /usr/local -zxf ${FILES}/${jre}
#ln -snf /usr/local/jre1.7.0_75 /usr/local/java

# Check wether elasticsearch is already installed
# Download elasticsearch rpm
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.noarch.rpm
# Install elasticsearch from provided .deb package
yum install -y elasticsearch-1.4.4.noarch.rpm

        # To install from file comment the above line and uncomment the one below
        # rpm -ivh Vagrant/files/elasticsearch-1.4.4.noarch.rpm

        # Add elasticsearch to startupscripts and start it
        #update-rc.d elasticsearch defaults 95 10

        chkconfig --add elasticsearch
        service elasticsearch start

        echo "Waiting for elasticsearch to startup ..."
        until curl -s --connect-timeout 1 localhost:9200; do
                echo "."
                sleep 1
        done

        # Import sample data
        echo "Importing sample data ..."
        curl -s -XPUT 'localhost:9200/_snapshot/sampledata/' -d '{
                "type": "fs",
                "settings": {
                        "location": "/vagrant/sampledata/",
                        "compress": true
                }
        }'
        curl -s -XPOST 'localhost:9200/_snapshot/sampledata/v1/_restore'
        echo "Finished importing sample data!"



# http basic auth plugin
mkdir /usr/share/elasticsearch/plugins/http-basic
wget https://github.com/Asquera/elasticsearch-http-basic/releases/download/v1.4.0/elasticsearch-http-basic-1.4.0.jar
mv elasticsearch-http-basic-1.4.0.jar /usr/share/elasticsearch/plugins/http-basic

#add configuration details to elasticsearch.yml - if you need , edit the file manually later
mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.original.yml
mv elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

service elasticsearch restart




