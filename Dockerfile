# ############################################################################ #
#          .-.                                                                 #
#    __   /   \   __                                                           #
#   (  `'.\   /.'`  )  Dockerfile                                              #
#    '-._.(;;;)._.-'                                                           #
#    .-'  ,`"`,  '-.                                                           #
#   (__.-'/   \'-.__)  By: Rosie (https://github.com/BlankRose)                #
#       //\   /        Last Updated: February 09, 2024 [02:03 pm]              #
#      ||  '-'                                                                 #
# ############################################################################ #

FROM kalilinux/kali-rolling

# INSTALL BASE ENVIRONEMENT
RUN apt-get update;\
	apt-get install -y kali-desktop-i3 xrdp;

# CREATE BASE USER
ARG user
ARG pass
RUN adduser $user;\
	echo "$user:$pass" | chpasswd;\
	usermod -aG sudo $user;

# ASSIGN STARTING POINT
CMD [ "bash", "-c", "/etc/init.d/xrdp stop; /etc/init.d/xrdp start && sleep inf" ]
