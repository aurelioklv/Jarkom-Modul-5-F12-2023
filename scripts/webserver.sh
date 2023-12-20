# Sein dan Stark

echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install -y netcat apache2
service apache2 start

# 4
iptables -A INPUT -p tcp --dport 22 -m iprange ! --src-range 192.227.8.3-192.227.11.254 -j DROP

# 8
iptables -A INPUT -p tcp --dport 80 -s 192.227.14.150 -m time --datestart 2023-12-10 --datestop 2024-02-15 -j DROP

# 6
iptables -A INPUT -m time --timestart 12:00 --timestop 13:00 --weekdays Mon,Tue,Wed,Thu -j REJECT
iptables -A INPUT -m time --timestart 11:00 --timestop 13:00 --weekdays Fri -j REJECT

# 5
iptables -A INPUT -m time --timestart 08:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -j REJECT


echo '
Listen 80
Listen 443

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
' > /etc/apache2/ports.conf

echo "
<VirtualHost *:80>
    ServerName 192.227.8.2
    DocumentRoot /var/www/html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
<VirtualHost *:443>
    ServerName 192.227.8.2
    DocumentRoot /var/www/html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/sein.conf


# 9
iptables -N portscan

iptables -A INPUT -m recent --name portscan --update --seconds 600 --hitcount 20 -j DROP
iptables -A FORWARD -m recent --name portscan --update --seconds 600 --hitcount 20 -j DROP

iptables -A INPUT -m recent --name portscan --set -j ACCEPT
iptables -A FORWARD -m recent --name portscan --set -j ACCEPT

a2ensite sein.conf
service apache2 restart

# Sein
# echo 'Sein' > /var/www/html/index.html

# Stark
# echo 'Stark' > /var/www/html/index.html