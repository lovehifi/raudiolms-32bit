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
After installing LMS and SQ, if you want to stop LMS and only use SQ, run the following command:
>
> systemctl stop logitechmediaserver-git.service
>
> systemctl disable logitechmediaserver-git.service
>
---------------------


### To play DSD via I2S DAC:

1./ Active the DSDPlayer plugin on LMS.
>
2./ Setting File Types on LMS: DFF and DSF formats, select Disable - Not set to Native.
>
3./ Check the sound card number, run this command: 
>
> cat /proc/asound/cards
>
Sample: 
**0** [audioinjectorpi]: audioinjector-p - audioinjector-pi-soundcard

>
4./ If the card in use is number 0. Edit and assign 0 to -o hw:0 as follows:
>
> nano /opt/sq/sq.service
>
Sample:
ExecStart=/opt/sq/squeezelite32 -o **hw:0** -n SQ32-rAudio -s 127.0.0.1 -m 00:00:00:00:00:00
>

>
Restart:
>
> systemctl daemon-reload && systemctl restart sq.service
>
> systemctl status sq.service
>
Another solution helps you change the card number automatically, which is better for you if you frequently switch DACs (e.g., switching from I2S to USB).
> wget -O - https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/update | sh

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
