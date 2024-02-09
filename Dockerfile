# ############################################################################ #
#          .-.                                                                 #
#    __   /   \   __                                                           #
#   (  `'.\   /.'`  )  Dockerfile                                              #
#    '-._.(;;;)._.-'                                                           #
#    .-'  ,`"`,  '-.                                                           #
#   (__.-'/   \'-.__)  By: Rosie (https://github.com/BlankRose)                #
#       //\   /        Last Updated: February 09, 2024 [05:54 pm]              #
#      ||  '-'                                                                 #
# ############################################################################ #

FROM kalilinux/kali-rolling

# INSTALL BASE ENVIRONEMENT
ARG env
RUN apt-get update;\
	apt-get install -y kali-desktop-$env xrdp;

# INSTALL ADDITIONAL PACKAGES
ARG pkg
RUN if [ ! -z "$pkg" ]; then\
		apt-get install -y $(echo "$pkg" | tr "," " ");\
	fi

# CREATE BASE USER
ARG user
ARG pass
RUN adduser "$user";\
	echo "$user:$pass" | chpasswd;\
	usermod -aG sudo "$user";

# ASSIGN STARTING POINT
CMD [ "bash", "-c", "/etc/init.d/xrdp stop; /etc/init.d/xrdp start && sleep inf" ]
