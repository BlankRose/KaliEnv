#!/bin/bash
# ############################################################################ #
#          .-.                                                                 #
#    __   /   \   __                                                           #
#   (  `'.\   /.'`  )  kali.sh                                                 #
#    '-._.(;;;)._.-'                                                           #
#    .-'  ,`"`,  '-.                                                           #
#   (__.-'/   \'-.__)  By: Rosie (https://github.com/BlankRose)                #
#       //\   /        Last Updated: February 09, 2024 [05:57 pm]              #
#      ||  '-'                                                                 #
# ############################################################################ #

# LOAD USED ENVIRONEMENTS
# And replace with defaults if non-existant
# ############################

names=(KALI_TAG  KALI_NAME  KALI_PORT  KALI_USER  KALI_PASS  KALI_ENV)
value=(kalienv   kali       5500       kali       kali       i3      )

for i in "${!names[@]}"; do
	if [ -z "${!names[$i]}" ]; then
		export ${names[$i]}=${value[$i]}
	fi
done

# DISPLAY HELP
# Wether explicitly asked or not, or invalid commands
# ############################

cmd_help() {
	echo "=== Kali Utility Script ==="
	echo ""
	echo "s | start    : Start KaliLinux"
	echo "r | reset    : Reset container to latest image changes"
	echo "e | stop     : Stop any running containers"
	echo "c | clear    : Clear instances"
	echo "h | help     : Displays this"
	exit 0
}

# CREATE KALI DESKTOP ENVIRONEMENT
# Or resumes if one already exists
# ############################

cmd_start() {
	if [ $(docker ps -af name=$KALI_NAME -f status=running | wc -l) -ge 2 ]; then
		echo "An instance is already running!"
	else
		if [ $(docker ps -af name=$KALI_NAME | wc -l) -ge 2 ]; then
			if [ ! -z "$KALI_ATTACH" ]; then opt=-a; fi
			echo "Resuming session.."
			docker start $opt $KALI_NAME
		else
			set -e
			if [ $(docker images -f reference=$KALI_TAG | wc -l) -lt 2 ]; then
				docker build -t=$KALI_TAG \
					--build-arg="env=$KALI_ENV" \
					--build-arg="pkg=$KALI_INSTALL" \
					--build-arg="user=$KALI_USER" \
					--build-arg="pass=$KALI_PASS" \
					"$(dirname "$0")"
			fi

			if [ -z "$KALI_ATTACH" ]; then opt=-d; fi
			if [ ! -z "$KALI_VOLUMES" ]; then
				for i in $(echo "$KALI_VOLUMES" | tr "," "\n"); do
					opt="$opt -v $i"
				done
			fi

			echo "Creating new session.."
			docker run $opt -p=$KALI_PORT:3389 --name=$KALI_NAME $KALI_TAG
		fi
	fi
}

# STOPS DESKTOP ENVIRONEMENT
# Or does nothing if none does exists yet
# ############################

cmd_stop() {
	if [ $(docker ps -af name=$KALI_NAME -f status=running | wc -l) -ge 2 ]; then
		echo "Stopping session.."
		docker stop $KALI_NAME -t=3 >/dev/null
	else
		echo "No KaliLinux instances found!"
	fi
}

# REMOVE INSTANCE
# Or does nothing if there's no instance yet
# ############################

cmd_clear() {
	cmd_stop
	echo "Removing instances.."
	docker rm $KALI_NAME >/dev/null
	docker rmi $KALI_TAG > /dev/null
}

# READ ARGUMENT
# And execute the corresponding functions
# ############################

if [ $# -eq 0 ]; then
	cmd_help
	exit 0
fi

while [[ $# -gt 0 ]]
do
	case "$1" in
	h|help|'')
		cmd_help;;
	s|start)
		cmd_start;;
	r|reset)
		cmd_clear
		cmd_start;;
	e|stop)
		cmd_stop;;
	c|clear)
		cmd_clear;;
	*)
		echo "Unknown command: $1"
		cmd_help
		exit 1;;
	esac
	shift
done
