# Harman-kardon-ir-extender-hack
Arduino web-based control for harman/kardon receivers like hk3250 with an in control port.


hk-3250 as many other harman/kardon receivers has an in IR port for IR extenders like HE1000 that was sourced from Xantech by Harman/Kardon.It is no longer avaible, but after some studing of the schematics of the receiver i deducted that the port , a 3.5 monojack ,uses just the raw signal ,so its just:

>modulating -> cable ->receiver(demodulating)
(instead of reciving a demodulated signal)
>

Therefore we can capture the signals from the remote , which in this case uses 32 bits NEC encoding and send them through a 3.5 monojack  cable.If u wish to achive just the ir extension capabylity you could just capture the signal and reproduce it through that port, instead of that, we'll make a network/web-based control, so we can control it anywhere around the house.For this task we'll need a network enabled board, that is also able to modulate the signal ,i have chosen the old reliable esp8266 (in form of the NodeMCU prototiping board).We'll also use an IR library  exclusive for the esp8266 , the library was  built by https://github.com/markszabo you can find it in here:
https://github.com/markszabo/IRremoteESP8266 

You'll have to purchase also an ir receiver in case you have another harman/kardon so you can record the codes from your receiver's remote.To store them you can flash the library's example sketch: irRecvDumpV2.Open serial , press all buttons and copy the serial output to a text file, you will have to extract the codes and know what each of them does as long as they are nec codes, if they are not nec , u could use the raw data.

These are the codes for hk3250:

 >Standby = 0x10E03FC;
 RadioTuneUp= 0x10E21DE;
 RadioTuneDown= 0x10EA15E;
 RadioPScan= 0x10E6996;
 RadioTuner1= 0x10EE11E;
 RadioTuner2= 0x10E11EE;
 RadioTuner3= 0x10E916E;
 RadioTuner4= 0x10E51AE;
 RadioTuner5= 0x10ED12E;
 RadioTuner6= 0x10E31CE;
 RadioTuner7= 0x10EB14E;
 RadioTuner8= 0x10E718E;
 RadioTuner9= 0x10EB946;
 RadioTuner0= 0x10E7986;
 CdDisc= 0x10E0AF5;
 CdPlay= 0x10E40BF;
 CdPause = 0x10EC03F;
 CdStop= 0x10E807F;
 CdSearchLeft= 0x10EE01F;
 CdSearchRight= 0x10E609F;
 CdSkipLeft= 0x10EA05F;
 CdSkipRight= 0x10E20DF;
 Cd= 0x10E23DC;
 Tuner= 0x10EC33C;
 TapeMon= 0x10EB34C;
 TvAux= 0x10E738C;
 VCR1= 0x10E53AC;
 VCR2= 0x10ED32C;
 VolumeUp= 0x10EE31C;
 VolumeDown= 0x10E13EC;
 Display= 0x10E3BC4;
 Sleep= 0x10EDB24;
 Mute= 0x10E837C;
 >
 
 Also as i have a PI-based Spotify/Airplay player,and ive allways wanted the receiver to dinamicly change between vcr1 ( pc use) and vcr2 (pi use), i have made an script that checks if the pi is playing anything , in case it is, pi visits esp8266'sIP/vcr2 and the receiver changes to vcr2 , and when it stops pi visits esp8266'sIP/vcr1 so i can use the receiver with my pc. Check hdmiES build for energy saving 
 measures.
 
The script runs in bash ,in a loop checks if the content of text file=="closed" in case its true visits vcr1 page, in case its false means its playing something so visits vcr2 , its far from efficient and reliable but for the moment it just makes the job :). ~~i'll update any time soon with an script that makes script booteable as a service,~~ for the time being install.sh will make the booteable service , but it has to be executed as root(big error!!!, im trying to make it executable by a normal user).Mqtt was added , to control it with openhab or through any mqtt publisher, you will need in adittion a mqtt server , like mosquitto( the payload handles the commands, the pipe where you publish the payload is:

>/Remote
>

The payloads are: 

>Standby, VolumeUp,VolumeDown,VCR1,VCR2
>

~~Also i'll update with the code to use it as a HE1000.~~ 

To do list:
- [x] Install Script.
- [x] Mqtt commands support.
- [ ] Install Script (non-root support).
- [ ] ~~HE1000 emulation.~~ this is deprecated , as is easily achivable with IRremoteESP8266 library.

 
