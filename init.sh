apt update && DEBIAN_FRONTEND=noninteractive apt install -y wget kali-linux-headless
apt-get install -y kali-desktop-kde xorg xrdp
sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini
sudo /etc/init.d/xrdp start
useradd kali
