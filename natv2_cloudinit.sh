#!/bin/bash
sudo su
echo net.ipv4.ip_forward = 1 >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf 
systemctl mask iptables
systemctl stop iptables

#firewall-cmd --permanent --zone=public --add-port=443/tcp 
#firewall-cmd --permanent --zone=public --add-masquerade 
#firewall-cmd --permanent --zone=public --add-forward-port=port=443:proto=tcp:toport=443:toaddr=1.2.3.4
#firewall-cmd --reload

firewall-offline-cmd --zone=public --add-port=443/tcp 
firewall-offline-cmd --zone=public --add-masquerade 
firewall-offline-cmd --zone=public --add-forward-port=port=443:proto=tcp:toport=443:toaddr=1.2.3.4
systemctl restart firewalld

#firewall-cmd --permanent --zone=testing --add-rich-rule='rule family=ipv4 source address=192.168.1.0/24 masquerade'
#firewall-cmd --permanent --zone=testing --add-rich-rule='rule family=ipv4 source address=192.168.1.0/24 forward-port port=22 protocol=tcp to-port=2222 to-addr=10.0.0.10'
