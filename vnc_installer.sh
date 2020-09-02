#! /bin/bash

if [ "$UID" != "0" ] ; then
    echo "[!] use root user"
    exit 1
fi

# Step 01 # ----------------- #
apt-get -y update
apt-get -y dist-upgrade
# --------------------------- #

sleep 3
clear

# Step 02 # ------------------------ #
apt install xfce4 xfce4-goodies -y
apt install tightvncserver -y
apt install firefox terminator -y
# ---------------------------------- #

sleep 3
clear

# Step 03 # ------------------------------------------------------------------------------- #
for (( ;; )) ; do
    vncserver
    if [ "$?" = "0" ] ; then
        break
    fi
done

for (( i=1 ; i <= 10 ; i++ )) ; do
    vncserver -kill :$i &> /dev/null
done

echo 'for (( i=1 ; i <= 10 ; i++ )) ; do' > /root/vnc.kill
echo '    vncserver -kill :$i &> /dev/null' >> /root/vnc.kill
echo 'done' >> /root/vnc.kill

chmod +x /root/vnc.kill
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak

echo '#!/bin/bash' > ~/.vnc/xstartup
echo 'xrdb $HOME/.Xresources' >> ~/.vnc/xstartup
echo 'startxfce4 &' >> ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup
echo '/usr/bin/vncserver -localhost -depth 24 -geometry 1250x750' > /root/vnc.start
chmod +x /root/vnc.start
# ---------------------------------------------------------------------------------------- #

sleep 3
clear


# Step 04 # --------------------------------------------------------------------------------------------- #
echo -e "[>] --------------------------------------------------------------------------------- [<]"
echo -e "\e[92m[>] for start vnc server : bash /root/vnc.start\e[0m"
echo -e "\e[91m[>] for stop vnc server : bash /root/vnc.kill\e[0m"
echo -e "\e[93m[>] vnc start at localhost:5901 for more security\e[0m"
echo -e "\e[93m[>] connect to server using ssh tunnel\e[0m"
echo -e "\e[92m[>] ssh -L 5901:localhost:5901 root@1.2.3.4\e[0m"
echo -e "\e[93m[>] open remmina in your client [laptop or pc] and connect to localhost:5901\e[0m"
echo -e "[>] --------------------------------------------------------------------------------- [<]"
# ------------------------------------------------------------------------------------------------------- #
