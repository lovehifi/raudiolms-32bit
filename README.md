# LMS and Squeezelite (32bit) for rAudio (Arch Linux)
Pi 2 and Pi 3
------------------------
Install 
>
> wget -O - https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/install-archlinux.sh | sh
>
Configure Squeezelite option (output, name...) in /opt/sq/sq.service
>
------------------------
After installing LMS and SQ, if you want to stop LMS and only use SQ, run the following command:
>
> systemctl stop logitechmediaserver.service
>
> systemctl disable logitechmediaserver.service
>
