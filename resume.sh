docker start "kali"
docker exec "kali" /etc/init.d/xrdp stop
docker exec "kali" /etc/init.d/xrdp start
