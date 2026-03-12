# 1. Ver tu subred
ip route show | grep default
# o
ip addr show

# 2. Escanear (ejemplo con tu red)
sudo nmap -sn 172.30.203.0/24

