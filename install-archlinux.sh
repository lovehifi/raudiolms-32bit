#!/bin/sh
echo "Install Lib"
rm -f /var/lib/pacman/sync/*
pacman -Syy --noconfirm
pacman -S --noconfirm perl
pacman -S --noconfirm perl-io-socket-ssl
pacman -S --noconfirm perl-net-ssleay
pacman -S --noconfirm perl-uri
pacman -S --noconfirm faad2
pacman -S --noconfirm libmad
pacman -S --noconfirm mpg123
pacman -S --noconfirm flac libvorbis

if [ -d "/opt/logitechmediaserver-git" ]; then
    echo "Stopping Logitech Media Server"
    systemctl stop logitechmediaserver-git.service
fi

if [ -d "/opt/sq-git" ]; then
    echo "Stopping Squeezelite"
    systemctl stop sq.service
fi

if [ -d "/root/logitechmediaserver*" ]; then
rm /root/logitechmediaserver*
fi

if [ -d "/root/sq32*" ]; then
rm /root/sq32*
fi

echo "Add user"
getent group logitechms &>/dev/null || groupadd -r logitechms >/dev/null
getent passwd logitechms &>/dev/null || useradd -r -g logitechms -d /opt/logitechmediaserver-git -c 'Logitech Media Server' -s /bin/false logitechms >/dev/null
mkdir -p /opt/logitechmediaserver-git/{cache,Logs,prefs{,/plugin},Plugins}
touch /opt/logitechmediaserver-git/Logs/slimserver.log
chown -R logitechms:logitechms /opt/logitechmediaserver-git
echo 'logitechms ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers


echo "Download LMS"
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/logitechmediaserver-32.pkg.tar.xz


echo "Install LMS"
pacman -U --noconfirm logitechmediaserver-32.pkg.tar.xz
systemctl daemon-reload
systemctl enable logitechmediaserver-git.service
systemctl restart logitechmediaserver-git.service

echo "Do you want to download and install Squeezelite? (Yes/No)"
read answer_sq
if [ "$answer_sq" = "Yes" ]; then
echo "Download Squeezelite and Install"
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/sq32.tgz
tar -xzf sq32.tgz --overwrite -C /opt/

echo "Creating systemd unit /etc/systemd/system/sq.service"
echo "[Unit]
Description=SQ Player
After=local-fs.target remote-fs.target nss-lookup.target network.target

[Service]
Type=simple
WorkingDirectory=/opt/sq
ExecStart=/opt/sq/squeezelite32 -o default -n SQ32-rAudio -s 127.0.0.1
Restart=always

[Install]
WantedBy=multi-user.target" > /opt/sq/sq.service || { echo "Creating systemd unit /opt/sq/sq.service failed"; exit 1; }
ln -fs /opt/sq/sq.service /etc/systemd/system/sq.service

chmod -R 755 /etc/systemd/system/sq.service
systemctl daemon-reload
systemctl enable sq.service
systemctl restart sq.service
echo "Finished"
systemctl status sq.service
	
fi

echo "Finished"
#systemctl stop logitechmediaserver-git.service
systemctl status logitechmediaserver-git.service

#echo "755"
#sudo chmod -R 755
# wget -O - https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/install-archlinux.sh | sh
