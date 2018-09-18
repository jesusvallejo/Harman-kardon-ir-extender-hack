#!/bin/bash

DIR='/proc/asound/card0/pcm0p/sub0/status'
CMD1='python3 /root/audioControl/control1.py'
CMD='python3 /root/audioControl/control.py'
cat $CMD
content=''
flag=1
inicio=`cat $DIR`

if [[ "$inicio" == "closed" ]]
                then
                echo "-----------------------------hola"
        content=$new_content
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
