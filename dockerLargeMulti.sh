#!/bin/bash

read times

limit=3

dockerBatchCreate() {
  local baseImage=$1
  local from=$2
  local end=$3

  # local end=$(($from+$num-1))

  # local end=$(($num-$from+1))

  for i in $(seq $from $end)
  do
    if [ "$i" -eq "$from" ]; then
      sudo docker run $baseImage mkdir test$i

      wait

      sudo docker commit -m="test$i" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/test$i:$i

      wait

    else
      prev=$(($i-1))

      sudo docker run chiahao/test$prev:$prev mkdir test$i

      # sleep 1s

      wait

      if [ "$i" -eq "$end" ]; then
        sudo docker commit -m="$end" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/final$end:final
      else
        sudo docker commit -m="test$i" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/test$i:$i
      fi

      wait

    fi

  done

  # local imageIds="$(sudo docker images -q)"
  # local imageId="$(($imageIds | sed -n 1p))"
  # echo -e "$imageId\r"

  # local arrayId=($imageId)
  # echo "${arrayId[0]}"

}

if [ "$times" -lt "$(($limit+1))" ]; then
  dockerBatchCreate "ubuntu:14.04" "1" "$times"


else

  for ((k=1; k<="$times"; k=k+$limit)); do


    if [ "$k" -eq "1" ]; then

      dockerBatchCreate "ubuntu:14.04" "1" "$limit"

      wait

    else

      parEnd=""

      if [ "$(($k+$limit))" -le "$times" ]; then
        parEnd=$(($k+$limit))
      else
        parEnd=$times
      fi


      prevImageId="$(sudo docker images -q | sed -n 1p)"

      wait

      echo "k: $k end: $parEnd id: $prevImageId"

      dockerBatchCreate "$prevImageId" "$k" "$parEnd"

      wait

    fi

  done

fi


exit 0
