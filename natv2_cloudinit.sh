#!/bin/bash
sudo su
echo net.ipv4.ip_forward = 1 >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf 

systemctl mask iptables
systemctl stop iptables

firewall-offline-cmd --zone=public --add-port=443/tcp 
firewall-offline-cmd --zone=public --add-masquerade 
localip=$(hostname -I | awk '{print $1}')
firewall-offline-cmd --zone=public --add-rich-rule="rule family=ipv4 destination address='$localip' forward-port port=443 protocol=tcp to-port=443 to-addr=1.2.3.4"
systemctl restart firewalld
