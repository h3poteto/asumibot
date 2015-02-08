#!/usr/bin/sh
while true
do
    sleep 10
    isAlive=`ps -ef | grep "userstream" | grep "asumistream" | grep -v grep | wc -l`
    if [ $isAlive -lt 1 ]; then
        #死んでる
        cd /home/akira/projects/asumibot/
        nohup sh ./script/userstream.sh > log/stream.log 2> log/stream_err.log < /dev/null &
    fi
done
