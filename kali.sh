#!/bin/bash
# ############################################################################ #
#          .-.                                                                 #
#    __   /   \   __                                                           #
#   (  `'.\   /.'`  )  kali.sh                                                 #
#    '-._.(;;;)._.-'                                                           #
#    .-'  ,`"`,  '-.                                                           #
#   (__.-'/   \'-.__)  By: Rosie (https://github.com/BlankRose)                #
#       //\   /        Last Updated: February 09, 2024 [11:37 am]              #
#      ||  '-'                                                                 #
# ############################################################################ #

if [ $# -eq 0 ] || [ "$1" = "help" ] || [ "$1" = "h" ]
then
	echo "=== Kali Utility Script ==="
	echo ""
	echo "s | start    : Start KaliLinux"
	echo "r | reset    : Reset container to latest image changes"
	echo "e | stop     : Stop any running containers"
	echo "c | clear    : Clear instances"
	echo "h | help     : Displays this"
	exit 0
fi

tag=kali-home
name=kali
port=5500

if [ "$1" = "start" ] || [ "$1" = "s" ]
then
	set -e
	docker build -t=$tag "$(dirname "$0")"
	if [ $(docker ps -af name=$name | wc -l) -ge 2 ];
	then
		echo "Resuming session.."
		docker start $name
	else
		echo "Creating new session.."
		docker run -p=$port:3389 --name=$name $tag
	fi

elif [ "$1" = "reset" ] || [ "$1" = "r" ]
then
	bash $0 e
	docker rm $name >/dev/null
	bash $0 s

elif [ "$1" = "stop" ] || [ "$1" = "e" ]
then
	if [ $(docker ps -af name=$name | wc -l) -ge 2 ];
	then
		echo "Stopping session.."
		docker stop $name -t=3 >/dev/null
	else
		echo "No KaliLinux instances found!"
	fi

elif [ "$1" = "clear" ] || [ "$1" = "c" ]
then
	bash $0 e
	echo "Removing instances.."
	docker rm $name >/dev/null
	docker rmi $tag 

else
	echo "Unknown command: $1"
	bash $0
	exit 1
fi
