#!/bin/bash
#counter=2
#sudo ls -l
#containerID=$(sudo docker ps -a -q)
#counter=$(($counter+1))

times=2

for i in $(seq 1 $times)
do
  if [ "$i" -eq 1 ]; then
    sudo docker run ubuntu:14.04 mkdir test$i
    sudo docker commit -m="test$i" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/test$i:$i

  else
    sudo docker run ubuntu:14.04 mkdir test$i
    imageId=$($(sudo docker images -q):0:11)
    
  fi
done


exit 0
