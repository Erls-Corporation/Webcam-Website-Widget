#!/bin/bash

path=/home/webcam

number=$(ls $path/upload/newwebcam* | wc -l)
X=900

if [ $number -gt $X ]
then
  cd $path/logs
  nohup $path/image_patos.sh &
fi


number2=$(ls $path/upload/moledo* | wc -l)
X2=900

if [ $number2 -gt $X2 ]
then
  cd $path/logs
  nohup $path/image_moledo.sh &
fi


find $path/httpdocs/patos* -type f -mmin +30 -exec rm {} \;  2> /dev/null
find $path/httpdocs/moledo* -type f -mmin +30 -exec rm {} \;  2> /dev/null
