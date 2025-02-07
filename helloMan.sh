#!/bin/bash
# HELLO-MAN SYSTEM AUDITOR (v1.0)
#shirdalcode.ir

AUTH="Shayan Taki"
T_NME="HELLO-MAN"
T_VER="1.0.$(date +%y%m)"
NET_SCAN=true
SHOW_OFFLINE=true
show_anim() {
    echo -e "\033[1;33m"
    echo "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
    echo "█ ${T_NME} SYSTEM AUDITOR █"
    echo "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
    echo -e "\033[0m"
    
    for i in {1..3}; do
        echo -n "[${i}/3] Initializing "
        for j in {1..5}; do
            echo -n "•"
            sleep 0.1
        done
        echo
    done
}

get_input() {
    read -p "Perform network scan? (y/n): " net_choice
    [[ $net_choice == [Yy]* ]] && NET_SCAN=true
    
    read -p "Include stopped services? (y/n): " svc_choice
    [[ $svc_choice == [Yy]* ]] && SHOW_OFFLINE=true
}

scan_network() {
    echo -e "\n[NETWORK SCAN]"
    gateway=$(ip route | awk '/default/ {print $3}')
    echo "Gateway: $gateway"
    
    if command -v nmap &> /dev/null; then
        echo "Quick port scan:"
        nmap -T4 -F $gateway/24 | tail -n+5 | head -n-2
    else
        echo "Active hosts:"
        for ip in {1..254}; do
            ping -c1 -W1 $gateway.$ip | grep 'bytes from' | cut -d' ' -f4 &
        done | sort -V
    fi
}

check_firewall() {
    echo -e "\n[FIREWALL STATUS]"
    if command -v ufw &> /dev/null; then
        ufw status verbose | grep -v '^ '
    elif command -v firewall-cmd &> /dev/null; then
        firewall-cmd --state
        firewall-cmd --list-all
    else
        iptables -L -n | grep 'Chain'
    fi
}

gen_rpt() {
    F_NAME="HELLO_$(date +%Y%m%d_%H%M).txt"
    
    {
        echo "╔══════════════════════════════╗"
        echo "║   ${T_NME} SYSTEM REPORT v${T_VER}   ║"
        echo "║   Author: ${AUTH}   ║"
        echo "╚══════════════════════════════╝"
        
        echo -e "\n[SYSTEM]"
        echo "OS: $(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d'"' -f2)"
        echo "Kernel: $(uname -r)"
        
        echo -e "\n[SOFTWARE]"
        if type apt &>/dev/null; then
            dpkg --get-selections | grep -v deinstall | head -n25
        elif type rpm &>/dev/null; then
            rpm -qa | head -n25
        else
            echo "No package manager detected"
        fi
        
        echo -e "\n[SERVICES]"
        systemctl list-units --type=service --state=running 2>/dev/null | head -n10
        
        $SHOW_OFFLINE && {
            echo -e "\n[STOPPED SERVICES]"
            systemctl list-units --type=service --state=inactive 2>/dev/null | head -n5
        }
        
        echo -e "\n[NETWORK]"
        ip a 2>/dev/null | grep 'inet ' | awk '{print $2}' | grep -v '127.0.0.1'
        
        $NET_SCAN && scan_network
        
        echo -e "\n[STORAGE]"
        df -h | grep -v 'tmpfs\|loop'
        
        check_firewall
        
        echo -e "\n[SUMMARY]"
        echo "Uptime: $(uptime -p)"
        echo "Load: $(cat /proc/loadavg | cut -d' ' -f1-3)"
        echo "Memory: $(free -h | awk '/Mem/{print $3 \"/\" $2}')"
        
        echo -e "\n[END] Generated at: $(date '+%Y-%m-%d %H:%M:%S')"
    } > "${F_NAME}" 2>/dev/null
}