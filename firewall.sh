#!/bin/bash

# Firewall: iptables based firewall start/stop script
# Author: Samuil Arsov <samyil101@gmail.com>

start() {
echo -e "start firewall"

ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A INPUT -s e80::/16 -m state --state NEW -m comment --comment "localnet" -j ACCEPT
ip6tables -A INPUT -s ff02::/16 -m state --state NEW -m comment --comment "localnet" -j ACCEPT
ip6tables -A INPUT -p tcp --dport 22 -m state --state NEW -j LOG
ip6tables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT
ip6tables -A INPUT -p ipv6-icmp -j ACCEPT
ip6tables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
ip6tables -A INPUT -m state --state INVALID -j DROP
ip6tables -A INPUT -j DROP
ip6tables -A OUTPUT -m state --state INVALID -j DROP

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -s 192.168.0.0/16 -m state --state NEW -m comment --comment "localnet" -j ACCEPT
iptables -A INPUT -s 172.16.0.0/12 -m state --state NEW -m comment --comment "localnet" -j ACCEPT
iptables -A INPUT -s 10.0.0.0/8 -m state --state NEW -m comment --comment "localnet" -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j LOG
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -j DROP
iptables -A OUTPUT -m state --state INVALID -j DROP
}

stop() {
echo "stop firewall"
ip6tables -F
iptables -F
}

status() {
echo "status firewall"
ip6tables -nvL --line-number
echo ""
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
