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