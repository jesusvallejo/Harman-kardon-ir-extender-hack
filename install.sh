#!/bin/bash

echo ""
echo "My Command Line Installer"
echo ""

DESTINATION="/root/audioControl"

if ! test -d ${DESTINATION} && ! test -w ${DESTINATION}; then  #Si no existe, crea el destino
   echo el directorio no existe
   if mkdir ${DESTINATION} ; then
   echo correcto
   else
   exit 66
   fi
else
	echo el directorio existe , se procede a limpiarlo
	rm -r ${DESTINATION}
	if mkdir ${DESTINATION} ; then
    echo correcto
    else
    exit 66
    fi
	
fi

 if  test -d ${DESTINATION} && test -w ${DESTINATION};then
	echo el directorio es accesible 
	cd ${DESTINATION}
	echo ' 
	#!/bin/bash

    DIR="/proc/asound/card0/pcm0p/sub0/status"
    CMD1="wget --delete-after http://192.168.1.72/VCR1/"
    CMD="wget --delete-after http://192.168.1.72/VCR2/"



    content=""
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
	done ' > audioControl.sh
	else
	echo error
	exit 666
	fi

chmod +x audioControl.sh

cd /etc/systemd/system/

if [ ! -f audioControl.service ];then
	echo '
    
[Unit]
Description=Audio Altavoces Grandes Auto Control

[Service]
ExecStart=/bin/bash /root/audioControl/audioControl.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target

' > audioControl.service
else
	sudo rm -r audioControl.service

	echo '
    
[Unit]
Description=Audio Altavoces Grandes Auto Control

[Service]
ExecStart=/bin/bash /root/audioControl/audioControl.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target

' > audioControl.service
fi


systemctl start audioControl.service
systemctl enable audioControl.service
systemctl status audioControl.service 

systemctl daemon-reload

echo ""
echo "Installation complete."
echo ""


exit 0





