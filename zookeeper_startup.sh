#!/bin/bash


wget https://download.java.net/java/GA/jdk10/10.0.1/fb4372174a714e6b8c52526dc134031e/10/openjdk-10.0.1_linux-x64_bin.tar.gz
sha256sum openjdk-10.0.1_linux-x64_bin.tar.gz
tar xzvf openjdk-10.0.1_linux-x64_bin.tar.gz
sudo mkdir /usr/lib/jvm
sudo mv jdk-10.0.1 /usr/lib/jvm/openjdk-10-manual-installation/
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/openjdk-10-manual-installation/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/openjdk-10-manual-installation/bin/javac 1
java -version
javac -version


cd /usr/local

wget "https://apache.mirrors.benatherton.com/zookeeper/zookeeper-3.5.5/apache-zookeeper-3.5.5.tar.gz"
tar -xvf "apache-zookeeper-3.5.5.tar.gz"



touch apache-zookeeper-3.5.5/conf/zoo.cfg

echo "tickTime=2000" >> apache-zookeeper-3.5.5/conf/zoo.cfg
echo "dataDir=/var/lib/zookeeper" >> apache-zookeeper-3.5.5/conf/zoo.cfg
echo "clientPort=2181" >> apache-zookeeper-3.5.5/conf/zoo.cfg
echo "initLimit=5" >> apache-zookeeper-3.5.5/conf/zoo.cfg
echo "syncLimit=2" >> apache-zookeeper-3.5.5/conf/zoo.cfg
 
i=1
while [ $i -le $2 ]
do
    echo "server.$i=172.16.101.$(($i+9)):2888:3888" >> apache-zookeeper-3.5.5/conf/zoo.cfg
    i=$(($i+1))
done

mkdir -p /var/lib/zookeeper

echo $(($1+1)) >> /var/lib/zookeeper/myid

apache-zookeeper-3.5.5/bin/zkServer.sh start
