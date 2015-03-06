#! /bin/bash
# place the package elasticsearch-1.4.4.deb or whatever is the latest version in the ./files folder or you can do a wget and alter the script to dynamically download as well.
# Also download the latest java version - preverabbly do a apt-get for openjdk 1.7 - Refer to the graylog2 install in the other repository



# Set variables
FILES=/vagrant/provisioning/files

# Install java 7
if [ "$1" == "64" ]; then
	jre="jre-7u75-linux-x64.tar.gz"
else
	jre="jre-7u75-linux-i586.tar.gz"
fi

tar -C /usr/local -zxf ${FILES}/${jre}
ln -snf /usr/local/jre1.7.0_75 /usr/local/java

# Check wether elasticsearch is already installed
dpkg-query -W elasticsearch

if [ $? -ne 0 ]; then

	# Install elasticsearch from provided .deb package
	dpkg -i ${FILES}/elasticsearch-1.4.4.deb

	# write JAVA_HOME for elasticsearch
	echo "export JAVA_HOME=/usr/local/java" >> /etc/default/elasticsearch

	# Add elasticsearch to startupscripts and start it
	update-rc.d elasticsearch defaults 95 10

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

else
	service elasticsearch start
fi