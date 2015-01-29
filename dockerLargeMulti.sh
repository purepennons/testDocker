#!/bin/bash
#counter=2
#sudo ls -l
#containerID=$(sudo docker ps -a -q)
#counter=$(($counter+1))

read times

for i in $(seq 1 $times)
do
  if [ "$i" -eq 1 ]; then
    sudo docker run ubuntu:14.04 mkdir test$i
    sudo docker commit -m="test$i" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/test$i:$i

  else
    prev=$(($i-1))

    sudo docker run chiahao/test$prev:$prev mkdir test$i
    #imageId=$($($(sudo docker images -q):0:11))

    if [ "$i" -eq "$times" ]; then
      sudo docker commit -m="$times" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/final$times:final
    else
      sudo docker commit -m="test$i" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/test$i:$i
    fi

  fi
done


exit 0
