docker stop "kali"

if [ $1 = "--all" ]
then
	echo "Purging docker && image" && docker rmi "kalilinux/kali-rolling"
else
	echo "Purging docker"
fi

docker rm "kali"
