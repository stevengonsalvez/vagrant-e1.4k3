#! /bin/bash
# if needed downlaod and place kibana 3.1.2.tar in the files location and use from there

wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.2.tar.gz
#or
# place the tar under files folder - you can also refer to the other repo under steven gonsalvez

mkdir /usr/share/elasticsearch/plugins/kibana/
tar xzf kibana-3.1.2.tar.gz -C /usr/share/elasticsearch/plugins/kibana/
mv /usr/share/elasticsearch/plugins/kibana/kibana* /usr/share/elasticsearch/plugins/kibana/_site

service elasticsearch restart


