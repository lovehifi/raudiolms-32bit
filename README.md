# LMS and Squeezelite (32bit) for rAudio (Arch Linux)
Pi 2 and Pi 3
------------------------
Install 
>
> wget -O - https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/install-archlinux.sh | sh
>
Configure Squeezelite option (output, name...) in the /opt/sq/sq.service
>
LMS port: http://raudio.local:9000 (or raudio ip:9000)
> 
------------------------
To check your DAC using the squeezelite command, you can use the -l option which lists the available audio output devices. Here's the command:
>
> cat /proc/asound/cards
>
This command will list the available audio output devices, including your DAC. The output will display the names of the devices and their respective capabilities. You can then choose the appropriate device and configure it accordingly.
>
------------------------
After installing LMS and SQ, if you want to stop LMS and only use SQ, run the following command:
>
> systemctl stop logitechmediaserver-git.service
>
> systemctl disable logitechmediaserver-git.service
>
---------------------
On the contrary, if you only want to use LMS and wish to stop SQ, run the following command:
>
> systemctl stop sq.service
>
> systemctl disable sq.service
>
>
-----------------------
Another thing, if you enjoy managing your music albums through LMS and want to play them on rAudio MPD, you can achieve this by:
Installing the UPnP Bridge plugin in LMS and enabling UPnP on your rAudio setup. LMS will then have an additional option: rAudio UPnP player.


----------------------

>
>
### [Why rAudio-LMS ?](https://github.com/lovehifi/raudiolms-32bit/wiki/Why-rAudio%E2%80%90LMS%3F) 
----------------------
>
### [LMS and Squeezelite (64bit) for rAudio (Arch Linux) Pi 4](https://github.com/lovehifi/raudiolms-64bit)

----------------------


### [LMS modern-skin for LMS-rAudio](https://github.com/lovehifi/lms-modern-skin)

--------------------
### If you want to use Tidal Connect on rAudio, you can try it at this [repository](https://github.com/lovehifi/tidal-raudio).
>
https://github.com/lovehifi/tidal-raudio
>
