#!/bin/bash

read times

instr="mkdir "

for i in $(seq 1 $times)
do

    instr="$instr test$i"

done

echo $instr

sudo docker run ubuntu:14.04 $instr
sudo docker commit -m="testsingle$times" -a="Chiahao Lin" $(sudo docker ps -l -q) chiahao/singletest$times:$final$times
