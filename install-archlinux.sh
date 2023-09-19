#!/bin/sh

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
getent group logitechms &>/dev/null || groupadd -r logitechms >/dev/null
getent passwd logitechms &>/dev/null || useradd -r -g logitechms -d /opt/logitechmediaserver-git -c 'Logitech Media Server' -s /bin/false logitechms >/dev/null
mkdir -p /opt/logitechmediaserver-git/{cache,Logs,prefs{,/plugin},Plugins}
touch /opt/logitechmediaserver-git/Logs/slimserver.log
chown -R logitechms:logitechms /opt/logitechmediaserver-git
echo 'logitechms ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/logitechmediaserver-32.pkg.tar.xz
#wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/sq.tgz
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/material-menu.tgz
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/plugin-data.tgz
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/plugin-data.yaml.tgz
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/plugin-prefs.tgz
pacman -U --noconfirm logitechmediaserver-32.pkg.tar.xz


tar -xzf material-menu.tgz --overwrite -C /opt/logitechmediaserver-git/prefs/
tar -xzf plugin-data.yaml.tgz --overwrite -C /opt/logitechmediaserver-git/cache/
tar -xzf plugin-prefs.tgz --overwrite -C /opt/logitechmediaserver-git/prefs/
tar -xzf plugin-data.tgz --overwrite -C /opt/logitechmediaserver-git/cache/InstalledPlugins/Plugins/
systemctl daemon-reload
#systemctl stop logitechmediaserver-git.service
systemctl enable logitechmediaserver-git.service
systemctl restart logitechmediaserver-git.service
systemctl status logitechmediaserver-git.service



#echo "755"
#sudo chmod -R 755


# echo "Creating systemd unit /etc/systemd/system/sq.service"
# echo "[Unit]
# Description=SQ Player
# After=local-fs.target remote-fs.target nss-lookup.target network.target

# [Service]
# Type=simple
# WorkingDirectory=/opt/logitechmediaserver-git/sq
# ExecStart=/opt/logitechmediaserver-git/sq/squeezelite32 -o default -n SQ32-rAudio -s 127.0.0.1
# Restart=always

# [Install]
# WantedBy=multi-user.target" > /opt/logitechmediaserver-git/sq/sq.service || { echo "Creating systemd unit /opt/logitechmediaserver-git/sq/sq.service failed"; exit 1; }
# sudo ln -fs /opt/logitechmediaserver-git/sq/sq.service /etc/systemd/system/sq.service

# chmod -R 755 /etc/systemd/system/sq.service
# systemctl daemon-reload
# systemctl enable sq.service
# systemctl restart sq.service
# systemctl status sq.service


# wget -O - https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/install-archlinux.sh | sh
