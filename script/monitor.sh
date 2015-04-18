#!/usr/bin/sh
echo $$ > tmp/pids/monitor.pid
while true
do
    sleep 10
    isAlive=`ps -ef | grep "asumistream" | grep -v grep | wc -l`
    if [ $isAlive -lt 1 ]; then
        #死んでる
        nohup sh ./script/userstream.sh > log/stream.log 2> log/stream_err.log < /dev/null &
    fi
done
