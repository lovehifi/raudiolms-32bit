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

echo "Add user"
getent group logitechms &>/dev/null || groupadd -r logitechms >/dev/null
getent passwd logitechms &>/dev/null || useradd -r -g logitechms -d /opt/logitechmediaserver-git -c 'Logitech Media Server' -s /bin/false logitechms >/dev/null
mkdir -p /opt/logitechmediaserver-git/{cache,Logs,prefs{,/plugin},Plugins}
touch /opt/logitechmediaserver-git/Logs/slimserver.log
chown -R logitechms:logitechms /opt/logitechmediaserver-git
echo 'logitechms ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers

echo "Download LMS"
cd ~
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/logitechmediaserver-32.pkg.tar.xz


echo "Install LMS"
pacman -U --noconfirm logitechmediaserver-32.pkg.tar.xz
systemctl daemon-reload
systemctl enable logitechmediaserver-git.service
systemctl restart logitechmediaserver-git.service

echo "Download Plugins and Install Plugin"
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/material-menu.tgz
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/plugin-data.tgz
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/plugin-data.yaml.tgz
wget https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/plugin-prefs.tgz
tar -xzf material-menu.tgz --overwrite -C /opt/logitechmediaserver-git/prefs/
tar -xzf plugin-data.yaml.tgz --overwrite -C /opt/logitechmediaserver-git/cache/
tar -xzf plugin-prefs.tgz --overwrite -C /opt/logitechmediaserver-git/prefs/
tar -xzf plugin-data.tgz --overwrite -C /opt/logitechmediaserver-git/cache/InstalledPlugins/Plugins/

echo "Finished"
#systemctl stop logitechmediaserver-git.service
systemctl status logitechmediaserver-git.service

#echo "755"
#sudo chmod -R 755
# wget -O - https://raw.githubusercontent.com/lovehifi/raudiolms-32bit/main/install-archlinux.sh | sh
