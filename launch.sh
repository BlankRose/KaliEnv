docker run --name "kali" -p 3390:3390 --expose=3390 --tty --detach kalilinux/kali-rolling
docker exec "kali" apt-get update
docker exec "kali" apt-get install -y wget
docker exec "kali" wget https://github.com/coookiecoder/kali.git
docker exec "kali" /kali/init.sh
