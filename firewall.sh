#!/bin/bash

start() {
echo "start firewall"
ip6tables -A INPUT -i lo -j ACCEPT
#ip6tables -A INPUT -s e80::/16 -j ACCEPT
#ip6tables -A INPUT -s ff02::/16 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT
ip6tables -A INPUT -p ipv6-icmp -j ACCEPT
ip6tables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
ip6tables -A INPUT -m state --state INVALID -j DROP
ip6tables -A INPUT -j DROP

iptables -A INPUT -i lo -j ACCEPT
#iptables -A INPUT -s 192.168.0.0/16 -j ACCEPT
#iptables -A INPUT -s 172.16.0.0/12 -j ACCEPT
#iptables -A INPUT -s 10.0.0.0/8 -j ACCEPT
#iptables -A INPUT -p tcp -m multiport --dports 135,137:139,445 -s 192.168.0.0/16 -j ACCEPT
#iptables -A INPUT -p udp -m multiport --dports 135,137:139,445 -s 192.168.0.0/16 -j ACCEPT
#iptables -A INPUT -p tcp --dport 21 -j ACCEPT
#iptables -A INPUT -p udp --dport 53 -j ACCEPT
#iptables -A INPUT -p udp --dport 123 -j ACCEPT
#iptables -A INPUT -p tcp -m multiport --dports 80,443 -j DROP
#iptables -A INPUT -p tcp -m multiport --dports 25,110,143,465,587,993,995 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -j DROP
}

stop() {
echo "stop firewall"
ip6tables -F
iptables -F
}

status() {
echo "status firewall"
ip6tables -nvL --line-number
iptables -nvL --line-number
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  status)
    status
    ;;
  *)
    echo $"Usage: $0 {start|stop|restart|status}"
    exit 1
  esac
exit
