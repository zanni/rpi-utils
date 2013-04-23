#!/bin/bash 

apt-get -y update
apt-get -y install ntp fake-hwclock
apt-get -y install unzip
apt-get -y install wireless-tools
apt-get -y install wpasupplicant
apt-get -y install isc-dhcp-client

wget ftp://ftp.dlink.com/Wireless/dwa130_revC/Drivers/dwa130_revC_drivers_linux_006.zip
unzip -q dwa130_revC_drivers_linux_006.zip
mkdir -p /usr/local/lib/firmware/RTL8192U
cp rtl8192u_linux_2.6.0006.1031.2008/firmware/RTL8192U/* /usr/local/lib/firmware/RTL8192U

wget http://www.electrictea.co.uk/rpi/8192cu.tar.gz
tar -zxf 8192cu.tar.gz
install -p -m 644 8192cu.ko /lib/modules/3.6.11+/kernel/drivers/net/wireless/

# edit /etc/network/interfaces  
echo >>  /etc/network/interfaces
echo 'allow-hotplug wlan0' >>  /etc/network/interfaces
echo >>  /etc/network/interfaces
echo 'auto wlan0' >>  /etc/network/interfaces
echo >>  /etc/network/interfaces
echo 'iface wlan0 inet dhcp' >> /etc/network/interfaces
read -p "Please enter the Network SIDD - " SIDD
echo "wpa-ssid \"$SIDD\"" >> /etc/network/interfaces
echo
read -p "Please enter the Network PASSWORD - " PASSWORD
echo "wpa-psk \"$PASSWORD\"" >> /etc/network/interfaces
echo

# edit /etc/modprobe.d/blacklist.conf
echo 'blacklist rtl8192cu' >>  /etc/modprobe.d/blacklist.conf

# edit /etc/modules
echo add line '8192cu' >>  /etc/modules

depmod -a

ifdown eth0

echo
echo 'the ethernet network connection, eth0, has been turned off'
echo 'unplug the network cable and plug in the wifi adapter. it should automatically start.'
echo "please be patient if it doesn't start straight away."

echo
read -p "press any key to continue..." -n1 -s
echo
sleep 2

EXITSTATUS=-1

until [ ${EXITSTATUS} == 0 ]; do
  echo
  echo "Checking wifi"
  echo
  ifconfig wlan0 >temp
  grep -q "inet addr:" temp
  EXITSTATUS=$?
  if [ ${EXITSTATUS} != 0 ]
  then
    echo
    echo "waiting for the wifi to connect to the network. Checking again."
    echo
    echo "just in case are you sure the SSID and PASSWORD are correct?"
    echo
    sleep 2
  fi
  rm temp
done

rm 8192cu.*
rm dwa130_revC_drivers_linux_006.zip
rm -r rtl8192u_linux_2.6.0006.1031.2008

echo
echo "wifi is connected :) "
echo
echo "Enjoy!!"
echo

sleep 2


