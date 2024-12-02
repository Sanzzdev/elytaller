#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'


animate_text() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -en "${text:$i:1}"
        sleep 0.03
    done
    echo ""
}

themestall() {
    echo -e "${CYAN}=== PROSES INSTALASI ===${RESET}"
    GITHUB_TOKEN="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" 
    REPO_URL="https://${GITHUB_TOKEN}@github.com/Sanzzdev/elytaller.git"
    TEMP_DIR="elytaller"
    git clone "$REPO_URL"
    sudo mv "$TEMP_DIR/Theme.zip" /var/www/
    unzip -o /var/www/Theme.zip -d /var/www/
    rm -r elytaller
    rm /var/www/Theme.zip
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

    sudo apt update
    sudo apt install -y nodejs npm
    npm i -g yarn
    cd /var/www/pterodactyl
    yarn
    yarn build:production

    echo -e "${BLUE}Ketik 'yes'${RESET}"
    php artisan migrate
    php artisan view:clear
    animate_text "${GREEN}Successfully install the Elysium Theme${RESET}"
}

clear
echo -e "${CYAN}=========================================================${RESET}"
echo -e "${CYAN}██╗   ██╗██╗     ███████╗███████╗██╗   ██╗██╗███╗   ███╗${RESET}"
echo -e "${CYAN}██║   ██║██║     ██╔════╝██╔════╝██║   ██║██║████╗ ████║${RESET}"
echo -e "${CYAN}██║   ██║██║     █████╗  █████╗  ██║   ██║██║██╔████╔██║${RESET}"
echo -e "${CYAN}██║   ██║██║     ██╔══╝  ██╔══╝  ██║   ██║██║██║╚██╔╝██║${RESET}"
echo -e "${CYAN}╚██████╔╝███████╗███████╗██║     ╚██████╔╝██║██║ ╚═╝ ██║${RESET}"
echo -e "${CYAN} ╚═════╝ ╚══════╝╚══════╝╚═╝      ╚═════╝ ╚═╝╚═╝     ╚═╝${RESET}"
echo -e "${CYAN}=========================================================${RESET}"
animate_text "Wellcome to installer elysium"


echo -e "${GREEN}[1]${RESET} INSTALL ELYSIUM"
echo -e "${RED}[2]${RESET} EXIT"
echo -e "${CYAN}=========================================================${RESET}"
read -p "Select options (1-2): " OPTION

case "$OPTION" in
    1)
        themestall
        ;;
    2)
        echo -e "${YELLOW}Exit the installer!${RESET}"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid selection. Please try again.${RESET}"
        exit 1
        ;;
esac