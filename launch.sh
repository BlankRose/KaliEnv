docker run --name "kali" -p 3390:3390 --expose=3390 --tty --detach kalilinux/kali-rolling
docker exec "kali" /init.sh
