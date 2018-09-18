#!/bin/bash

DIR='/proc/asound/card0/pcm0p/sub0/status'
CMD1='wget --delete-after http://192.168.1.72/VCR1/'
CMD='wget --delete-after http://192.168.1.72/VCR2/'



content=''
flag=1
inicio=`cat $DIR`


if [[ "$inicio" == "closed" ]]
        then
        $CMD1
else
	$CMD

fi


while true
do
  new_content=`cat $DIR`

  if [[ "$content" != "$new_content" ]]
  then
        if [[ "$new_content" == "closed" ]]
		then
		echo "-----------------------------hola"
        content=$new_content
        $CMD1

		elif [[ "$content" == "closed" ]]
		then
		echo "++++++++++++++++++++++++++++++hola"
        content=$new_content
        $CMD
		fi
  fi
    
    sleep 0.25
done
