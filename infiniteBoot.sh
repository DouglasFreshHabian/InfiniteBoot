#!/usr/bin/env bash

#############################################
# infiniteBoot.sh
# Fresh Forensics Boot Simulation Engine
#############################################

#########################################
# GLOBAL COLORS
#########################################
GREEN="\e[0;32m"
BLUE="\e[0;34m"
YELLOW="\e[0;33m"
RED="\e[0;31m"
CYAN="\e[0;36m"
WHITE="\e[1;37m"
DIM="\e[2m"
RESET="\e[0m"

HOSTNAME_REAL=$(hostname)
START_TIME=0

#########################################
# CLEAN EXIT (GLOBAL)
#########################################
cleanup() {
    tput cnorm
    printf "${RESET}\n"
    exit
}
trap cleanup SIGINT SIGTERM

#########################################
# HELP MENU
#########################################
show_help() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════╗"
    echo "║         Infinite Boot Simulator v1.0.0      ║"
    echo "║            Fresh Forensics Edition          ║"
    echo "╚══════════════════════════════════════════════╝"
    echo -e "${RESET}"

    echo -e "${WHITE}Usage:${RESET}"
    echo -e "  ${GREEN}./infiniteBoot.sh${RESET}"
    echo -e "  ${GREEN}./infiniteBoot.sh --journal${RESET}"
    echo -e "  ${GREEN}./infiniteBoot.sh --systemd${RESET}"
    echo ""

    echo -e "${WHITE}Options:${RESET}"
    printf "  %-15b %s\n" "${YELLOW}--journal${RESET}"  "Boot → Login → Infinite journalctl simulation"
    printf "  %-15b %s\n" "${YELLOW}--systemd${RESET}"  "Realistic systemd-style boot simulation"
    printf "  %-15b %s\n" "${YELLOW}--help${RESET}"     "Display this help menu"
    printf "  %-15b %s\n" "${YELLOW}--version${RESET}"  "Show version information"
    echo ""

    echo -e "${DIM}Terminal realism. Infinite loop. Clean exit with Ctrl+C.${RESET}"
}

#########################################
# =========================================================
# DEFAULT MODE (Script #1)
# =========================================================
#########################################

timestamp_default() {
    START_TIME=$(awk "BEGIN {print $START_TIME + (rand()/5)}")
    printf "%8.6f" "$START_TIME"
}

kprint_default() {
    local color=$1
    local message=$2
    printf "${DIM}[ %s ]${RESET} ${color}%s${RESET}\n" "$(timestamp_default)" "$message"
    sleep 0.05
}

disk_unlock_default() {
    printf "${WHITE}\nPlease unlock disk sda1_crypt:${RESET} "
    stty -echo
    read -r pass
    stty echo
    printf "\n${GREEN}Disk unlocked successfully.${RESET}\n"
    sleep 0.8
    clear
}

default_mode() {

    tput civis
    clear
    START_TIME=0

    kprint_default "$CYAN" "Booting Fresh Forensics Kernel 6.7.0-ff-amd64"
    kprint_default "$CYAN" "Command line: forensic=1 integrity=strict"
    kprint_default "$BLUE" "Detected hostname: $HOSTNAME_REAL"
    kprint_default "$BLUE" "Memory: $(( (RANDOM % 16 + 8) * 1024 ))MB available"

    sleep 0.5
    disk_unlock_default

    services=(
    "Initializing cgroup subsys cpu"
    "Initializing cgroup subsys memory"
    "usbcore: registered new interface driver usbfs"
    "EXT4-fs (sda1): mounted filesystem"
    "Started Journal Service"
    "Reached target Network"
    "Started OpenSSH Server"
    "Loading forensic modules"
    "Integrity verification module loaded"
    "Network audit framework initialized"
    "Evidence logging daemon started"
    "Self-audit subsystem active"
    "Kernel signature verified"
    "Filesystem consistency verified"
    "No unauthorized processes detected"
    "Replaying system journal"
    "Starting container runtime"
    "Applying firewall rules"
    "Verifying cryptographic signatures"
    "Activating secure networking"
    )

    while true; do
        index=$((RANDOM % ${#services[@]}))
        msg="${services[$index]}"
        rand_status=$((RANDOM % 20))

        if [ "$rand_status" -eq 0 ]; then
            kprint_default "$RED" "[FAILED] $msg"
            sleep 0.2
            kprint_default "$YELLOW" "Retrying $msg"
            sleep 0.2
            kprint_default "$GREEN" "[  OK  ] $msg"
        else
            if [[ "$msg" == *"Started"* || "$msg" == *"Reached"* || "$msg" == *"verified"* || "$msg" == *"loaded"* ]]; then
                kprint_default "$GREEN" "[  OK  ] $msg"
            else
                kprint_default "$GREEN" "$msg"
            fi
        fi

        sleep 0.1
    done
}

#########################################
# =========================================================
# JOURNAL MODE (Script #2)
# =========================================================
#########################################

timestamp_kernel() {
    printf "%8.6f" "$(awk 'BEGIN{srand(); print rand()*5}')"
}

kprint_journal() {
    printf "${DIM}[ %10s ]${RESET} %s\n" "$(timestamp_kernel)" "$1"
    sleep 0.03
}

ok_journal() {
    printf "${GREEN}[  OK  ]${RESET} %s\n" "$1"
    sleep 0.04
}

journal_mode() {

    tput civis
    clear

    BOOT_TIME=$(date +"%b %d %H:%M:%S")

    kprint_journal "Linux version 6.7.0-amd64 (debian-kernel@lists.debian.org)"
    kprint_journal "Command line: BOOT_IMAGE=/boot/vmlinuz root=/dev/mapper/sda1_crypt ro quiet"
    kprint_journal "systemd[1]: systemd 254 running in system mode."
    kprint_journal "systemd[1]: Detected architecture x86-64."

    printf "\nPlease unlock disk sda1_crypt: "
    stty -echo
    read -r pass
    stty echo
    printf "\n"
    kprint_journal "device-mapper: crypt: set up successfully"
    sleep 0.5

    ok_journal "Reached target Local File Systems."
    ok_journal "Mounted /home."
    ok_journal "Started Journal Service."
    ok_journal "Started Network Manager."
    ok_journal "Started OpenSSH Server."
    ok_journal "Reached target Multi-User System."
    ok_journal "Started Login Service."

    printf "\nDebian GNU/Linux 12 %s tty1\n\n" "$HOSTNAME_REAL"
    printf "%s login: " "$HOSTNAME_REAL"
    read -r user
    printf "Password: "
    stty -echo
    read -r pass
    stty echo
    printf "\n\nLast login: %s on tty1\n" "$BOOT_TIME"

    sleep 0.5
    clear

    services=(
    "systemd[1]: Started Authorization Manager."
    "systemd[1]: Reloading configuration..."
    "NetworkManager[412]: <info>  [ethernet] link connected"
    "sshd[582]: Accepted publickey for $user from 192.168.1.$((RANDOM%255)) port $((RANDOM%60000+1024)) ssh2"
    "CRON[602]: (root) CMD (run-parts /etc/cron.hourly)"
    "kernel: audit: type=1400 audit($RANDOM.$RANDOM): apparmor=\"ALLOWED\""
    "systemd[1]: Starting Fresh Forensics Integrity Daemon..."
    "fresh-integrity[$((RANDOM%900+100))]: Performing background audit"
    "systemd[1]: Started Fresh Forensics Integrity Daemon."
    "systemd-logind[455]: New session $((RANDOM%20+1)) of user $user."
    "systemd[1]: Started Session $((RANDOM%20+1)) of User $user."
    "systemd[1]: Reached target Graphical Interface."
    "dbus-daemon[390]: Successfully activated service 'org.freedesktop.resolve1'"
    "kernel: EXT4-fs (sda1): re-mounted."
    )

    while true; do
        now=$(date +"%b %d %H:%M:%S")
        index=$((RANDOM % ${#services[@]}))
        msg="${services[$index]}"
        printf "%s %s %s\n" "$now" "$HOSTNAME_REAL" "$msg"

        if [ $((RANDOM % 20)) -eq 0 ]; then
            printf "%s %s %bWARNING%b: systemd[1]: Unit failed but recovered.\n" \
                "$now" "$HOSTNAME_REAL" "$YELLOW" "$RESET"
        fi

        sleep 0.2
    done
}

#########################################
# =========================================================
# SYSTEMD MODE (Script #3)
# =========================================================
#########################################

timestamp_systemd() {
    START_TIME=$(awk "BEGIN {print $START_TIME + (rand()/3)}")
    printf "%8.6f" "$START_TIME"
}

kprint_systemd() {
    printf "${DIM}[ %s ]${RESET} %s\n" "$(timestamp_systemd)" "$1"
    sleep 0.04
}

ok_line() {
    printf "${GREEN}[  OK  ]${RESET} %s\n" "$1"
    sleep 0.05
}

fail_line() {
    printf "${RED}[FAILED]${RESET} %s\n" "$1"
    sleep 0.1
}

disk_unlock_systemd() {
    printf "\n${WHITE}Please unlock disk sda1_crypt:${RESET} "
    stty -echo
    read -r pass
    stty echo
    printf "\n"
    ok_line "Unlocked sda1_crypt."
    sleep 0.6
}

systemd_mode() {

    tput civis
    clear
    START_TIME=0

    kprint_systemd "Linux version 6.7.0-ff-amd64 (root@fresh) (gcc version 13.2.0)"
    kprint_systemd "Command line: BOOT_IMAGE=/boot/vmlinuz forensic=1 quiet"
    kprint_systemd "Detected hostname: $HOSTNAME_REAL"
    kprint_systemd "Memory: $(( (RANDOM % 16 + 8) * 1024 ))MB available"

    sleep 0.5
    disk_unlock_systemd

    ok_line "Reached target Local File Systems."
    ok_line "Mounted /boot."
    ok_line "Mounted /home."
    ok_line "Started Journal Service."
    ok_line "Started udev Kernel Device Manager."
    ok_line "Started Network Manager."

    units=(
    "Starting OpenSSH Server..."
    "Started OpenSSH Server."
    "Starting Authorization Manager..."
    "Started Authorization Manager."
    "Reached target Network."
    "Reached target Multi-User System."
    "Started Fresh Forensics Integrity Daemon."
    "Starting Evidence Logging Service..."
    "Started Evidence Logging Service."
    "Starting Firewall Service..."
    "Started Firewall Service."
    "Starting Container Runtime..."
    "Started Container Runtime."
    "Starting Secure Networking..."
    "Started Secure Networking."
    "Reached target Graphical Interface."
    )

    while true; do
        index=$((RANDOM % ${#units[@]}))
        msg="${units[$index]}"
        rand=$((RANDOM % 25))

        if [[ "$msg" == Starting* ]]; then
            printf "${BLUE}%s${RESET}\n" "$msg"
        elif [[ "$msg" == Reached* || "$msg" == Started* ]]; then
            ok_line "$msg"
        else
            printf "%s\n" "$msg"
        fi

        if [ "$rand" -eq 0 ]; then
            fail_line "Dependency failed for Secure Session."
            printf "${YELLOW}Retrying...${RESET}\n"
            sleep 0.2
            ok_line "Started Secure Session."
        fi

        if [ $((RANDOM % 10)) -eq 0 ]; then
            printf "${DIM}%s systemd[1]: Reloading configuration...${RESET}\n" "$HOSTNAME_REAL"
            sleep 0.1
        fi

        sleep 0.08
    done
}

#########################################
# MODE DISPATCHER
#########################################

case "$1" in
    "")
        default_mode
        ;;
    --journal)
        journal_mode
        ;;
    --systemd)
        systemd_mode
        ;;
    --help|-h)
        show_help
        exit
        ;;
esac
