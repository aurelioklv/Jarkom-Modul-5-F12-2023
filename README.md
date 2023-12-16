# Jarkom-Modul-5-F12-2023

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
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
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