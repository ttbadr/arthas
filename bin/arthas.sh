#!/bin/bash
unset -v _JAVA_OPTIONS
fileName=arthas.tgz
url1='https://github.com/ttbadr/arthas/releases/download/3.6.7/arthas.tgz'
url2='http://10.116.53.198/scripts/repo/arthas.tgz'
cd /tmp

if [ ! -d arthas ]; then
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
fi
cd arthas && java -jar arthas-boot.jar
