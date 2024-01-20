docker run --name "kali" -p 3390:3390 --expose=3390 --tty --detach --interactive kalilinux/kali-rolling
docker exec "kali" apt-get update
docker exec "kali" apt-get install -y git
docker exec "kali" git clone https://github.com/coookiecoder/kali.git
docker exec "kali" bash /kali/init.sh
