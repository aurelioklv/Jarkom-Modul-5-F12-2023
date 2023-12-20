# Jarkom-Modul-5-F12-2023
##SETTING
PEMBAGIAN SUBNET 
![image](https://github.com/aurelioklv/Jarkom-Modul-5-F12-2023/assets/114126015/9a0a5b8a-716b-4fbd-8cca-113b242f7083)
PERHITUNGAN MAX SUBNET
![image](https://github.com/aurelioklv/Jarkom-Modul-5-F12-2023/assets/114126015/895e9641-83e8-454f-873a-892b3bdec543)
TREE VLSM
![image](https://github.com/aurelioklv/Jarkom-Modul-5-F12-2023/assets/114126015/581b671a-cb99-4572-aa65-502fca2662fc)
PEMBAGIAN IP
![image](https://github.com/aurelioklv/Jarkom-Modul-5-F12-2023/assets/114126015/e8f66498-0c4d-4704-a90e-eecb500e6973)
CONFIG ROUTER
```
AURA
#DHCP config for eth0
auto eth0
iface eth0 inet dhcp

#A1
auto eth1
iface eth1 inet static
	address 192.227.14.129
	netmask 255.255.255.252
#A4
auto eth2
iface eth2 inet static
	address 192.227.14.133
	netmask 255.255.255.252
HEITER
#A1
auto eth0
iface eth0 inet static
	address 192.227.14.130
	netmask 255.255.255.252
	gateway 192.227.14.129

#A2
auto eth1
iface eth1 inet static
	address 192.227.0.1
	netmask 255.255.248.0
#A3
auto eth2
iface eth2 inet static
	address 192.227.8.1
	netmask 255.255.252.0
TurkRegion
#A2
auto eth0
iface eth0 inet dhcp

Sein
#A3
auto eth0
iface eth0 inet static
	address 192.227.8.2
	netmask 255.255.252.0
	gateway 192.227.8.1
GrobeForest
#A3
auto eth0
iface eth0 inet dhcp

Frieren
#A4
auto eth0
iface eth0 inet static
	address 192.227.14.134
	netmask 255.255.255.252
	gateway 192.227.14.133
#A5
auto eth1
iface eth1 inet static
	address 192.227.14.137
	netmask 255.255.255.252
#A6
auto eth2
iface eth2 inet static
	address 192.227.14.141
	netmask 255.255.255.252
Stark
#A5
auto eth0
iface eth0 inet static
	address 192.227.14.138
	netmask 255.255.255.252
	gateway 192.227.14.137
Himmel
#A6
auto eth0
iface eth0 inet static
	address 192.227.14.142
	netmask 255.255.255.252
	gateway 192.227.14.141
#A7
auto eth1
iface eth1 inet static
	address 192.227.12.1
	netmask 255.255.254.0
#A8
auto eth2
iface eth2 inet static
	address 192.227.14.1
	netmask 255.255.255.128
LaubHills
#A7
auto eth0
iface eth0 inet dhcp

SchwerMountain
#A8
auto eth0
iface eth0 inet dhcp

Fern
#A8
auto eth0
iface eth0 inet static
	address 192.227.14.2
	netmask 255.255.255.128
	gateway 192.227.14.1
#A9
auto eth1
iface eth1 inet static
	address 192.227.14.145
	netmask 255.255.255.252
#A10
auto eth2
iface eth2 inet static
	address 192.227.14.149
	netmask 255.255.255.252
Richter
#A9
auto eth0
iface eth0 inet static
	address 192.227.14.146
	netmask 255.255.255.252
	gateway 192.227.14.145
Revolte
#A10
auto eth0
iface eth0 inet static
	address 192.227.14.150
	netmask 255.255.255.252
	gateway 192.227.14.149
```
ROUTING
```
AURA
#heiter
route add -net 192.227.0.0 netmask 255.255.248.0 gw 192.227.14.130
route add -net 192.227.8.0 netmask 255.255.252.0 gw 192.227.14.130
#frieren
route add -net 192.227.14.136 netmask 255.255.255.252 gw 192.227.14.134
route add -net 192.227.14.140 netmask 255.255.255.252 gw 192.227.14.134
route add -net 192.227.12.0 netmask 255.255.254.0 gw 192.227.14.134
route add -net 192.227.14.0 netmask 255.255.255.128 gw 192.227.14.134
route add -net 192.227.14.144 netmask 255.255.255.252 gw 192.227.14.134
route add -net 192.227.14.148 netmask 255.255.255.252 gw 192.227.14.134
FRIEREN
route add -net 192.227.12.0 netmask 255.255.254.0 gw 192.227.14.142
route add -net 192.227.14.0 netmask 255.255.255.128 gw 192.227.14.142
route add -net 192.227.14.144 netmask 255.255.255.252 gw 192.227.14.142
route add -net 192.227.14.148 netmask 255.255.255.252 gw 192.227.14.142
HIMMEL
route add -net 192.227.14.144 netmask 255.255.255.252 gw 192.227.14.2
route add -net 192.227.14.148 netmask 255.255.255.252 gw 192.227.14.2
```
DNS SERVER
```
# Richter
echo 'nameserver 192.168.122.1' >/etc/resolv.conf

apt update
apt install netcat -y
apt install bind9 -y

echo '
options {
  directory "/var/cache/bind";
  forwarders {
    192.168.122.1;
  };
  allow-query {any;};
  auth-nxdomain no; # conform to RFC1035
  listen-on-v6 {any;};
}' > /etc/bind/named.conf.options 

service bind9 restart
```

1. Aura
```
IPETH0="$(ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1)"
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source "$IPETH0" -s 192.227.0.0/20
```

2. Semua Router
```
iptables -A INPUT -p tcp -m multiport ! --dport 8080 -j DROP
iptables -A INPUT -p udp -j DROP
```
Test
```
nc -l -p 8080 dan nc <ip> 8080 untuk TCP, 
nc -u -l -p 8080 dan nc -u <ip> 8080 untuk UDP

```

3. Revolte dan Richter
```
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

Test dengan ping lebih dari 3 device

4. Stark dan Sein
```
iptables -A INPUT -p tcp --dport 22 -m iprange ! --src-range 192.227.8.3-192.227.11.254 -j DROP
```

Test dengan netcat dari GrobeForest dan subnet lain

5. Stark dan Sein
```
iptables -A INPUT -m time --timestart 08:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -j REJECT
```

6. Stark dan Sein
```
iptables -A INPUT -m time --timestart 12:00 --timestop 13:00 --weekdays Mon,Tue,Wed,Thu -j REJECT
iptables -A INPUT -m time --timestart 11:00 --timestop 13:00 --weekdays Fri -j REJECT
```
