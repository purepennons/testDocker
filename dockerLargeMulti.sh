#!/bin/bash

read times

limit=3

dockerBatchCreate() {
  baseImage=$1
  from=$2
  num=$3

  end=$(($from+$num))

  for i in $(seq $from $end)
  do
    if [ "$i" -eq "$from" ]; then
      sudo docker run $baseImage mkdir test$i
      sudo docker commit -m="test$i" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/test$i:$i

    else
      prev=$(($i-1))

      sudo docker run chiahao/test$prev:$prev mkdir test$i

      if [ "$i" -eq "$end" ]; then
        sudo docker commit -m="$end" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/final$end:final
      else
        sudo docker commit -m="test$i" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/test$i:$i
      fi

    fi

  done

  imageId="$(sudo docker images -q)"
  echo $imageId
  local arrayId=($imageId)
  echo "${arrayId[0]}"

}

#imageId=$(dockerBatchCreate "ubuntu:14.04" 1 times)

if [ "$times" -lt "$(($limit+1))" ]; then
  imageId=$(dockerBatchCreate "ubuntu:14.04" 1 times)

else

  #for i in $(seq 1 $times)
  for ((i=1; i<="$times"; i=i+$limit)); do

    firstImageId=""

    if [ "$i" -eq "1" ]; then

      firstImageId=$(dockerBatchCreate "ubuntu:14.04" 1 $limit)

    else
      echo "else"
    fi

  done

fi


exit 0
