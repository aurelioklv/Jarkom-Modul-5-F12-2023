echo 'nameserver 192.168.122.1
' > /etc/resolv.conf

apt-get update
apt-get install -y isc-dhcp-relay

echo 'SERVERS="192.227.14.150"
INTERFACES="eth0 eth1 eth2"
OPTIONS=""' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf

service isc-dhcp-relay restart

# 7
# Stark
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.227.8.2 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.227.8.2
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.227.8.2 -j DNAT --to-destination 192.227.14.138
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.227.14.138 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.227.14.138
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.227.14.138 -j DNAT --to-destination 192.227.8.2