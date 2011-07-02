#!/bin/bash

path=/home/webcam

cd $path/logs
nohup $path/image_patos.sh &
nohup $path/image_moledo.sh &

find $path/httpdocs/patos* -type f -mmin +30 -exec rm {} \;  2> /dev/null
find $path/httpdocs/moledo* -type f -mmin +30 -exec rm {} \;  2> /dev/null
