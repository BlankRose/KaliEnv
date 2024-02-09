# ############################################################################ #
#          .-.                                                                 #
#    __   /   \   __                                                           #
#   (  `'.\   /.'`  )  Dockerfile                                              #
#    '-._.(;;;)._.-'                                                           #
#    .-'  ,`"`,  '-.                                                           #
#   (__.-'/   \'-.__)  By: Rosie (https://github.com/BlankRose)                #
#       //\   /        Last Updated: February 09, 2024 [01:31 pm]              #
#      ||  '-'                                                                 #
# ############################################################################ #

FROM kalilinux/kali-rolling

# INSTALL BASE ENVIRONEMENT
RUN apt-get update;\
	apt-get install -y kali-desktop-i3 xrdp;

# CREATE BASE USER
RUN adduser kali;\
	echo 'kali:kali' | chpasswd;\
	usermod -aG sudo kali;

# ASSIGN STARTING POINT
CMD [ "bash", "-c", "/etc/init.d/xrdp stop; /etc/init.d/xrdp start && sleep inf" ]
