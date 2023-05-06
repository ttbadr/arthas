#!/bin/bash
unset -v _JAVA_OPTIONS
fileName=arthas-bin.tgz
url1="https://github.com/ttbadr/arthas/releases/download/3.6.7/$fileName"
url2="http://10.116.53.198/scripts/repo/$fileName"

if [ ! -d /tmp/arthas ]; then
    mkdir /tmp/arthas && cd /tmp/arthas
    echo 'downloading arthas...'
    if command -v curl &>/dev/null; then
        curl -I -m 3 -o /dev/null -s http://10.116.53.198
        if [ $? -gt 0 ];then
            curl -L $url1 -o $fileName
        else
            curl -L $url2 -o $fileName
        fi
    else
        wget -T 3 --spider -S "http://10.116.53.198" &>/dev/null
        if [ $? -gt 0 ];then
            wget $url1 -O $fileName
        else
            wget $url2 -O $fileName
        fi
    fi
    tar -xf $fileName
    rm -f $fileName
else
    cd /tmp/arthas
fi
java -jar arthas-boot.jar
